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

	<script type="text/javascript" src="{$root_uri}js/polyfill.js"></script>

	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
{if $smarty.const.COMPETITION_MODE}
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.1/angular.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.1/angular-resource.min.js"></script>
	<script type="text/javascript">
		var API_ROOT = "/comp-api";
	</script>

	<script type="text/javascript" src="{$root_uri}js/competition-utils.js"></script>
	<script type="text/javascript" src="{$root_uri}js/competition-filters.js"></script>
	<script type="text/javascript" src="{$root_uri}js/competition-resources.js"></script>
	<script type="text/javascript" src="{$root_uri}js/controllers/CompMode.js"></script>

	<script type="text/javascript" src="https://jwpsrv.com/library/XE4vyEM1EeOQDCIACqoGtw.js"></script>
	<script type="text/javascript" src="{$root_uri}js/live-streams.js"></script>
{else}
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>

	{literal}
	<script type="text/javascript">
	  $(document).ready(function() {
	    $("#date_tabs").tabs();
	  });
	</script>
	{/literal}
{/if}

	{include file="tracking.tpl"}
</head>

<body data-ng-controller="CompMode">
{include file="tracking-image.tpl"}
<div id="pageWrapper">

{if $smarty.const.COMPETITION_MODE}
<!-- TODO:
* Add an outline of and link to the rules?
-->

	<div id="header">
		<a href="{$root_uri}"><img src="{$root_uri}images/template/website_logo.png" alt="Student Robotics Logo" /></a>
		<div id="navwrapper">
		<ul>
			<li><a href="{$root_uri}about">About Us</a></li>
			<li><a href="{$root_uri}ide">IDE</a></li>
			<li><a href="{$root_uri}docs/">Docs</a></li>
		</ul>
		</div>
	</div>

	<div class="content">
		<div id="competition">
			<span class="top-links" id="more-link">
				<a href="{$root_uri}events/sr2014/2014-04-26-competition">Tell me more...</a>
			</span>
			<h1 style="text-align: center;">SR2014 Live!</h1>
			<div id="live-stream-wrapper">
				<div id="live-stream-controls">
					<a id="live-stream-a-link" class="selected" href="#">Arena A</a> |
					<a id="live-stream-b-link" href="#">Arena B</a> |
					<a id="live-stream-hide-link" href="#">No stream</a>
				</div>
				<div id="live-stream-a"></div>
				<div id="live-stream-b"></div>
			</div>
			<div id="match-info">
{literal}
<div class="scored match" style="position:relative;margin-top:10px;">
	<span style="position:absolute;margin-left:50px;left:0">
		<a href="{/literal}{$root_uri}{literal}comp/points">more scores...</a>
	</span>
	<h4>
		Latest Scores<span data-ng-if="previous_match">: {{previous_match.display_name}}</span>
	</h4>
	<span data-ng-if="!previous_match">No scores yet recorded.</span>
	<div class="game"
	     data-ng-repeat-start="(arena, game) in previous_match.games">
		<h4 style="color: {{arenas[arena].colour}};">Arena {{arenas[arena].display_name}}</h4>
		<table class="scores"
		       data-ng-if="game.scores">
			<thead>
				<tr>
					<th data-ng-repeat="tla in game.teams track by $index"
					    title="{{team|teamInfo:teams|teamName}}">
						{{tla}}
						<span data-ng-if="!tla">-</span>
					</th>
				</tr>
			</thead>
			<tr data-ng-repeat="(type, scores) in game.scores">
				<td data-ng-repeat="tla in game.teams track by $index">
					{{scores[tla]}}
				</td>
			</tr>
		</table>
		<p data-ng-if="!game.scores">No scores yet recorded for this game.</p>
	</div>
	<div class="game headings" data-ng-repeat-end data-ng-if="!$last">
		<h4>&nbsp;</h4>
		<table class="scores"
		       data-ng-if="game.scores">
			<thead>
				<tr>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tr data-ng-repeat="(type, scores) in game.scores">
				<th>{{type|titleCase}}</th>
			</tr>
		</table>
	</div>
</div>
<script type="text/ng-template" id="match-info">
	<h4>{{data.description}}: {{data.match.display_name}}</h4>
	<div class="game" data-ng-repeat-start="(arena, game) in data.match.games">
		<table>
			<thead>
				<tr>
					<th data-ng-repeat="tla in game.teams track by $index">
						{{$index}}
					</th>
				</tr>
			</thead>
			<tr>
				<td data-ng-repeat="tla in game.teams track by $index" title="{{tla|teamInfo:teams|teamName}}">
					{{tla}}
					<span data-ng-if="!tla">-</span>
				</td>
			</tr>
		</table>
	</div>
	<div class="game headings" data-ng-repeat-end data-ng-if="!$last">
		<table>
			<thead>
				<tr>
					<th>Corner</th>
				</tr>
			</thead>
			<tr>
				<th>Team</th>
			</tr>
		</table>
	</div>
</script>

<div class="current match"
     data-ng-if="current_match.exists"
     data-ng-init="data={description:'Current',match:current_match}"
     data-ng-include="'match-info'">
</div>
<div class="match"
     data-ng-if="next_match.exists"
     data-ng-init="data={description:'Next',match:next_match}"
     data-ng-include="'match-info'">
</div>
<div class="match"
     data-ng-if="upcoming_match.exists"
     data-ng-init="data={description:'Upcoming',match:upcoming_match}"
     data-ng-include="'match-info'">
</div>

{/literal}
			</div>

			<div id="leaderboard-container" class="info-box">
				<!-- TODO: maybe move to left so that you read this first
				  -- this tells you that the TLAs are teams -->
				<span class="more-link">
					<a href="{$root_uri}comp/league">more...</a>
				</span>
				<h2><a href="{$root_uri}comp/league">Leaderboard</a></h2>
				<div id="leaderboard">
{literal}
<table>
	<thead>
		<tr>
			<th>Position</th>
			<th>Points</th>
			<th>Team</th>
		</tr>
	</thead>
	<tr data-ng-repeat="team in teams|leaderboard:10" id="{{team.tla}}">
		<td>{{team.league_pos}}</td>
		<td>{{team.scores.league}}</td>
		<td title="{{team|teamName}}">
			<a href="{/literal}{$root_uri}{literal}teams/{{item.tla}}">{{team.tla}}</a>
		</td>
	</tr>
</table>
{/literal}
				</div>
			</div>

			<br style="clear: left;" />

			<div style="width: 600px" class="info-box">
				<span class="more-link">
					<a href="{$root_uri}comp/schedule">more...</a>
				</span>
				<h2><a href="{$root_uri}comp/schedule">Match Schedule</a></h2>
				<div id="match_sched">
{literal}
<table class="schedule">
	<thead>
		<tr>
			<th>Time</th>
			<th>Match</th>
			<th data-ng-repeat="arena in arenas" colspan="4" style="color: {{arena.colour}};">Arena {{arena.display_name}}</th>
		</tr>
	</thead>
	<tbody>
		<tr data-ng-repeat="match in matches|matchesEndingAfterNow:time_offset|limitTo:10"
			data-ng-class="{current: match.num==current_match.num}"
			id="match-{{match.num}}">
			<td title="Begins at {{match.time|date:'HH:mm:ss on EEEE, d MMMM'}}.">{{match.time|date:'HH:mm'}}</td>
			<td title="{{match.display_name}}">{{match.num}}</td>
			<td data-ng-repeat="team in match.teams track by $index"
				title="{{team|teamInfo:teams|teamName}}">
				<!--- TODO: non-literal filtering, possibly based on the existence of the page -->
				<a data-ng-if="team != '-'"
				   href="{/literal}{$root_uri}{literal}teams/{{team}}">{{team}}</a>
				<span data-ng-if="team == '-'">{{team}}</span>
			</td>
		</tr>
	</tbody>
</table>
{/literal}
				</div>
			</div>
		</div>
{else}
	{include file="header-en.tpl"}

	<div class="content">

		<div id="topBanner">
			<img src="{$root_uri}images/content/srobo_website_robot.png" alt="Image of Robot" />

			<h1>Welcome to Student Robotics</h1>

			<p>Student Robotics is an exciting annual
			  competition that challenges teams of 16-18
			  year-olds to build fully autonomous robots.
			  Participating teams must design, build and
			  test their robots, ready to compete against
			  other teams.</p>
		</div>

		<div id="latestNews">

			{latestRSS}

		</div>
{/if}

		<div id="expMenuAndBoxWrapper">

			<div id="expandedMenu">

				<h3>Take a Look Around</h3>

				{makemenu menu=$side_menu}

			</div>

			<div id="boxWrapper">

				<div class="box">
{if $smarty.const.COMPETITION_MODE}
					<h3><a href="{$root_uri}about">Who are we?</a></h3>
					<p>
						<!-- TODO: or something better -->
						Student Robotics run an annual robotics <a href="/~peter/sr/srweb/schools/game">competition</a>
						for sixth-form schools and colleges.
						All of the <a href="{$root_uri}schools/kit">kit</a> the schools &amp; colleges use is designed, built, tested and distributed by us.
						Student Robotics is run, in its entirety, by a <a href="{$root_uri}about/committee">team</a> of university students and recent graduates
						&mdash; mainly from the Universities of <a href="http://www.soton.ac.uk">Southampton</a> and <a href="http://bristol.ac.uk">Bristol</a>.
					</p>

					<h3><a href="https://twitter.com/StudentRobotics">Tweets from @StudentRobotics</a></h3>
					<p style="text-align:center;">
						<a width="640" height="300"
						   class="twitter-timeline"
						   data-dnt="true"
						   data-chrome="noheader nofooter"
						   data-widget-id="321728443496660993"
						   href="https://twitter.com/StudentRobotics"
						   >
							Tweets from @StudentRobotics
						</a>
						<script id="twitter-wjs" src="https://platform.twitter.com/widgets.js"></script>
					</p>

{else}
					<h3><a href="{$root_uri}about/how_to_help">Want to Get Involved?</a></h3>
					<p>
						Student Robotics is always looking for more people to get involved, and not just schools.
						Whether you're a University student or a company considering sponsoring the competition,
						you are more than welcome to <a href="{$root_uri}about/how_to_help">get involved</a>.
					</p>
{/if}
				</div>

{if !$smarty.const.COMPETITION_MODE}
				<div class="box">
					<h3><a href="{$root_uri}key_dates">SR2015 Key Dates</a></h3>
					<div id="date_tabs">
						<ul>
							<li><a href="#date_soton">Southampton</a></li>
							<li><a href="#date_bristol">Bristol</a></li>
							<li><a href="#date_london">London</a></li>
							<li><a href="#date_munich">Munich</a></li>
							<li><a href="#date_oxford">Oxford</a></li>
						</ul>
						<div id="date_soton">
                            <a href="{$root_uri}events/kickstart">Kickstart:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2015/2014-10-25-soton_kickstart">
                                    25<sup>th</sup> October 2014
                                </a></li>
                            </ul>
                            <a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2015/2014-12-06-soton_tech_day_1">
                                    6<sup>th</sup> December 2014
                                </a></li>
                                <li><a href="{$root_uri}events/sr2015/2015-02-21-soton_tech_day_2">
                                    21<sup>st</sup> February 2015
                                </a></li>
                                <li><a href="{$root_uri}events/sr2015/2015-03-14-soton_tech_day_3">
                                    14<sup>th</sup> March 2015
                                </a></li>
                            </ul>
						</div>
						<div id="date_bristol">
                            <a href="{$root_uri}events/kickstart">Kickstart:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2015/2014-10-25-bristol_kickstart">
                                    25<sup>th</sup> October 2014
                                </a></li>
                            </ul>
                            <a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2015/2014-12-06-bristol_tech_day_1">
                                    6<sup>th</sup> December 2014
                                </a></li>
                                <li><a href="{$root_uri}events/sr2015/2015-02-07-bristol_tech_day_2">
                                    7<sup>th</sup> February 2015
                                </a></li>
                                <li><a href="{$root_uri}events/sr2015/2015-03-14-bristol_tech_day_3">
                                    14<sup>th</sup> March 2015
                                </a></li>
                            </ul>
						</div>
						<div id="date_london">
                            <a href="{$root_uri}events/kickstart">Kickstart:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2015/2014-10-25-london_kickstart">
                                    25<sup>th</sup> October 2014
                                </a></li>
                            </ul>
						</div>
						<div id="date_munich">
                            <a href="{$root_uri}events/kickstart">Kickstart:</a>
                            <ul>
                                <li>
                                    8<sup>th</sup> November 2014
                                </li>
                            </ul>
						</div>
						<div id="date_oxford">
                            <a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2015/2015-02-21-oxford_tech_day_1">
                                    21<sup>st</sup> February 2015
                                </a></li>
                            </ul>
						</div>
					</div>

					<div>
						<a href="{$root_uri}events/competition">Competition:</a>
						<ul>
							<li><a href="{$root_uri}events/sr2015/2015-04-25-competition">
								25<sup>th</sup> and 26<sup>th</sup> April 2015
							</a></li>
						</ul>
					</div>
				</div>
{/if}
				<div class="box clearboth">
					<h3><a href="{$root_uri}ide">The IDE</a></h3>
					<p>
						<a href="{$root_uri}ide"><img src="{$root_uri}images/template/sr_round_flat.png" alt="SR logo" title="SR logo" /></a>

						The Student Robotics web&ndash;based <abbr title="Integrated Development Environment">IDE</abbr>
						is used by all of the schools &amp; colleges taking part to write programs for their robots.
						You will need to be registered to use it.
					</p>
				</div>

				<div class="box">
					<h3><a href="{$root_uri}schools/kit/">The Kit</a></h3>
					<p>
						<a href="{$root_uri}schools/kit/"><img src="{$root_uri}images/template/kit_motor_board.jpg" alt="motor board prototpye" title="Motor Board Prototype" /></a>
						Student Robotics design and build a range of easily&ndash;programmable boards
						designed specifically for building robots. The teams receive the kit at Kickstart
						and have about 7 months to build a competition&ndash;winning robot.
					</p>
				</div>

			</div>

		</div>

		<p></p>

	</div>


	{include file="footer-en.tpl"}

</div>

</body>

</html>
