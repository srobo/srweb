<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Team {$team->team_id} | Student Robotics</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="keywords" content="SR Student Robotics Team {$team->team_name} {$team->college.name}" />
	<meta name="description" content="Information about Student Robotics team '{$team->team_name}'" />
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/main.css" />
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/content_extra.css" />
	<link rel="stylesheet" type="text/css" media="print" href="{$root_uri}css/print.css" />
	<link rel="alternate" type="application/rss+xml" title="SR RSS" href="{$root_uri}feed.php" />
	<link rel="shortcut icon" href="{$root_uri}images/template/favicon.ico" />

	{include file="tracking.tpl"}
</head>
<body>
{include file="tracking-image.tpl"}
<div id="pageWrapper">
	{include file=$header_file}

	<div id="{$page_id}" class="content team-page">
		<a class="link-top" href="{$root_uri}teams">Back to all teams</a>

		{if !empty($team->college.rookie) }
		<h2 id="rookie-team"
		    title="This is the first time a team from this school or college has entered Student Robotics"
		    >Rookie Team</h2>
		{/if}

		<h1>{$team->team_id}: {$team->team_name}</h1>

		{if !empty($team->image) }
		<div id="team-img">
			<img alt="Photograph of the progress made by team {$team->team_name}" src="{$root_uri}{$team->image}" />
			<p>Last updated {$team->image->date}</p>
		</div>
		{/if}

		{if !empty($team->description) }
		{$team->description}
		{/if}

		<p id="team-links">
		<span id="team-name">
		{if !empty($team->url) }
		<a href="{$team->url}">
		{/if}
		Team {$team->team_id}
		{if !empty($team->url) }
		</a>
		{/if}
		</span>
		{if !empty($team->facebook) }
		<a class="facebook" href="{$team->facebook}">
			<img src="{$root_uri}images/template/facebook25x25.png" alt="Facebook" title="Team {$team->team_id} Facebook page" /></a>
		{/if}
		{if !empty($team->twitter) }
		<a class="twitter" href="{$team->twitter}">
			<img src="{$root_uri}images/template/twitter25x25.png" alt="Twitter" title="Team {$team->team_id} Twitter feed" /></a>
		{/if}
		{if !empty($team->youtube) }
		<a class="youtube" href="{$team->youtube}">
			<img src="{$root_uri}images/template/youtube25x59.png" alt="YouTube" title="Team {$team->team_id} YouTube account" /></a>
		{/if}
		</p>

		{if !empty($team->college) }
		<p id="college-name">
		from
		{if !empty($team->college.URL) }
		<a href="{$team->college.URL}" target="_blank">
		{/if}
		{$team->college.name}
		{if !empty($team->college.URL) }
		</a>
		{/if}
		</p>
		{/if}

		{if isset($team->feed->latest)}
		<h2>Latest Blog Post</h2>
		<div class="blog-post-date">
		<div class="day">{$team->feed->latest->date->day}</div>
		<div class="month">{$team->feed->latest->date->month}</div>
		<div class="year">{$team->feed->latest->date->year}</div>
		</div>
		<div class="blog-post-content">
		<h3><a href="{$team->feed->latest->url}">{$team->feed->latest->title}</a></h3>
		<p>
		{$team->feed->latest->description}
		</p>
		</div>
		{/if}

		<div class="clearboth"><a class="link-bottom-left" href="{$root_uri}teams">Back to all teams</a></div>

	</div>
	<div id="original">
		The content and links on this page belong to team {$team->team_id},
		and may not reflect the views of Student Robotics.
	</div>

</div>
</body>
</html>
