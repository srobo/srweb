<?php
// Special page to merge together the information in the current teams.json with the team status info.

require_once('config.inc.php');
require_once('classes/team_info.php');

$team_statuses = get_team_info();

$combined_teams_info = array();


foreach ($team_info_college_lut as $tla => $college_info) {
    if ($tla == 'SRZ') {
        continue;
    }
    if (isset($team_statuses[$tla])) {
        $info = $team_statuses[$tla];
    } else {
        // no status -- just convert the layout of the information
        $info = array('college' => $college_info);
    }
    $combined_teams_info[$tla] = $info;
}

header('Content-Type: text/json');
echo json_encode($combined_teams_info);
