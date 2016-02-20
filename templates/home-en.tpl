<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="en-GB" data-ng-app="app">

<head>
	<title>Welcome to Student Robotics | Student Robotics</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="keywords" content="student, robotics, robot, srobo, competition, southampton" />
	<meta name="description" content="Student Robotics is an exciting competition between sixth form schools and colleges to build fully autonomous robots." />
	<meta name="google-site-verification" content="GizX0DcCqEeGihd9CyYaqM1bVXUB-lhB9rhm53UdRC8" />
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/main.css" />
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/home.css" />
{if $smarty.const.COMPETITION_MODE}
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/comp.css" />
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/home_competition.css" />
{/if}
	<link rel="alternate" type="application/rss+xml" title="SR RSS" href="{$root_uri}feed.php" />
	<link rel="shortcut icon" href="{$root_uri}images/template/favicon.ico" />

{if $smarty.const.COMPETITION_MODE}
	<script type="text/javascript" src="{$root_uri}js/polyfill.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.1/angular.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.1/angular-resource.min.js"></script>
	<script type="text/javascript">
		var API_ROOT = "/comp-api";
	</script>

	<script type="text/javascript" src="{$root_uri}js/lib/angularjs-ordinal-filter/ordinal.js"></script>
	<script type="text/javascript" src="{$root_uri}js/competition-utils.js"></script>
	<script type="text/javascript" src="{$root_uri}js/competition-filters.js"></script>
	<script type="text/javascript" src="{$root_uri}js/competition-resources.js"></script>
	<script type="text/javascript" src="{$root_uri}js/controllers/CompMode.js"></script>

	<script type="text/javascript" src="https://jwpsrv.com/library/XE4vyEM1EeOQDCIACqoGtw.js"></script>
	<script type="text/javascript" src="{$root_uri}js/live-streams.js"></script>
{/if}

	{include file="tracking.tpl"}
</head>

<body data-ng-controller="CompMode">
{include file="tracking-image.tpl"}
<div id="pageWrapper">
{if $smarty.const.COMPETITION_MODE}
	{include file="comp-home.tpl"}
{else}
	{include file="header-en.tpl"}

	<div class="content">
		<section id="latestNews">
			<h1>Latest News&hellip;</h1>
			<div>
				{latestRSS}
			</div>
		</section>
		<section id="whatis" class="bar">
			<h1>What is Student Robotics?</h1>
			<p>
				Student Robotics is an annual robotics competition that challenges teams of 16-18 year-olds to design, build and present their own fully autonomous robots.
				It is free to take part and we exist to enthuse, excite and encourage a real-world approach to engineering.
			</p>
			<p class="readmore"><a href="{$root_uri}schools/how_to_enter">Tell me how to enter&hellip;</a></p>
		</section>
		<section id="season" class="bar">
			<h1>The SR Season</h1>
			<p>The season begins around the end of October with the Kickstart event. Throughout the season teams are supported by mentors and regular Tech Days. This all culminates in a two-day Competition in April.</p>
			<br>
			<p id="key-dates">You can view the planned dates for upcoming events on the <a href="{$root_uri}key_dates">key dates page</a>.</p>
			<div class="seasonBoxes">
				<div>
					<h2>Kickstart</h2>
					<p>Teams will be introduced to the challenge, the Kit and will be set a series of small challenges to familiarise themselves with the Kit.</p>
					<p class="readmore"><a href="{$root_uri}events/kickstart">Read more about Kickstart&hellip;</a></p>
				</div>
				<div>
					<h2>Tech Days</h2>
					<p>Teams will be invited to attend multiple Tech Days throughout the season where many mentors will be on hand to help them with any troubles.</p>
					<p class="readmore"><a href="{$root_uri}events/tech_days">Read more about Tech Days&hellip;</a></p>
				</div>
				<div>
					<h2>The Competition</h2>
					<p>Teams come together for a two-day robot spectacular. Here, their robot will be pitted against other teams' robots to compete for the coveted Student Robotics trophy.</p>
					<p class="readmore"><a href="{$root_uri}events/competition">Read more about the Comeptition&hellip;</a></p>
				</div>
			</div>
		</section>
		<section id="getinvolved" class="bar">
			<h1>Get Involved</h1>
			<p>
				Not only are we always looking to recruit more teams, we are continuously striving to expand our ever growing group of industry and university mentors.
				Mentors play a key role in a team's development and learning.
				As a mentor you would help guide a team through their robot building journey, from Kickstart to Competition.
			</p>
			<p class="readmore"><a href="{$root_uri}about/how_to_help">See how you can help&hellip;</a></p>
		</section>
	</div>
{/if}
	{include file="footer-en.tpl"}

</div>

</body>

</html>
