<?php

require_once('classes/simplepie/simplepie.inc');

$team_info_college_lut = json_decode(file_get_contents(TEAMS_JSON), true);

if ($team_info_college_lut === null) {
	trigger_error("Failed to parse team LUT '" . TEAMS_JSON . "'.", E_USER_WARNING);
}

class LiveStatusItem extends stdClass
{
	public $content;

	public function __construct($live)
	{
		$this->content = $live;
	}

	public function __toString()
	{
		return $this->content;
	}
}

/*
 * Return array of team IDs. If $file_path is true then the array is
 * indexed by team ID with the value set to the path of the status file.
 */
function get_team_list($file_path = False) {
	$teams = glob(TEAM_STATUS_DIR."/*-status.json");
	// guard against there being no teams.
	if (empty($teams))
		return array();
	$team_ids = array_map(function($t) {
	                      return preg_replace('/.*?([A-Z0-9]+)-status\.json/', '$1', $t);
	                      },
	                      $teams);
	if ($file_path)
		return array_combine($team_ids, $teams);
	else
		return $team_ids;
}

function get_team_info($team_id = False) {
	if ($team_id === False) {
		$teams = array();
		$team_files = get_team_list(true);
		foreach ($team_files as $team_id => $fn) {
			$teams[$team_id] = _build_team_info($fn, $team_id);
		}
		return $teams;
	} else {
		$fn = TEAM_STATUS_DIR."/".$team_id."-status.json";
		if (file_exists($fn)) {
			$team = _build_team_info($fn, $team_id);
			if (!empty($team->feed))
				_fill_team_latest_post($team);
			return $team;
		} else {
			return False;
		}
	}
}

/**
 * Builds information for a team from a json file and its Id.
 */
function _build_team_info($path, $team_id) {
	$json_text = file_get_contents($path);
	$team_raw = json_decode($json_text);
	$team = new stdClass();
	_set_team_image($team_raw, $team, $team_id);
	$team->team_name = empty($team_raw->name->live) ? "Team $team_id" : strip_tags($team_raw->name->live);
	foreach (array('url', 'feed', 'description', 'facebook', 'youtube', 'twitter') as $item) {
		if (empty($team_raw->$item->live)) {
			$team->$item = null;
		} else {
			$live = strip_tags($team_raw->$item->live);
			if ($item == 'description' && !empty($live)) {
				require_once('markdown.php');
				$live = Markdown($live);
			}
			$team->$item = $live;
		}
	}
	$team->team_id = $team_id;

	global $team_info_college_lut;
	$team->college = array_key_exists($team_id, $team_info_college_lut) ? $team_info_college_lut[$team_id] : null;

	return $team;
}

/**
 * Sets the team's image & its info (including the thumbnail).
 */
function _set_team_image($status, $team, $team_id) {
	if (empty($status->image->live)) {
		$team->thumb = null;
		$team->image = null;
		return;
	}
	$team->thumb = _get_team_thumb($team_id);
	$team->image = new LiveStatusItem(_get_team_image($team_id));
	if (!file_exists(ROOT_DIR.'/'.$team->thumb)) {
		$team->thumb = null;
	}
	$image_path = ROOT_DIR.'/'.$team->image;
	if (!file_exists($image_path)) {
		$team->image = null;
		return;
	}

	$age = intval(floor(time() - filemtime($image_path)) / 86400);
	if ($age == 0)
		$team->image->date = "today";
	elseif ($age == 1)
		$team->image->date = "yesterday";
	else
		$team->image->date = sprintf("%d days ago", $age);
}

/**
 * Returns the path to the thumbnail sized (160*120) image for the team.
 */
function _get_team_thumb($team_id) {
	return TEAM_STATUS_IMG."/".$team_id."_thumb.png";
}

/**
 * Returns the path to the full sized (480*320) image for the team.
 */
function _get_team_image($team_id) {
	return TEAM_STATUS_IMG."/".$team_id.".png";
}

function _fill_team_latest_post(&$team) {
	$url = $team->feed;
	$team->feed = new LiveStatusItem($url);

	$feed = new SimplePie();
	$feed->set_feed_url($url);
	$feed->set_cache_location(CACHE_DIR);
	$feed->init();

	if ($feed->get_item_quantity() > 0) {
		$item = $feed->get_item(0);
		$latest = new stdClass();
		$latest->title = $item->get_title();
		$latest->url = $item->get_link();
		$latest->description = $item->get_description();
		$date = new stdClass();
		$date->day = $item->get_date("d");
		$date->month = $item->get_date("M");
		$date->year = $item->get_date("Y");
		$latest->date = $date;
		$team->feed->latest = $latest;
	}
}

?>
