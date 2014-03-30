<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" data-ng-app="app">

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

	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
{if $smarty.const.COMPETITION_MODE}
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.1/angular.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.0-beta.1/angular-resource.min.js"></script>
	<script type="text/javascript">
		var SRWEB_ROOT = "{$root_uri}";
		var API_ROOT = "/comp-api";
	</script>

	<script type="text/javascript" src="{$root_uri}js/competition-utils.js"></script>
	<script type="text/javascript" src="{$root_uri}js/competition-filters.js"></script>
	<script type="text/javascript" src="{$root_uri}js/controllers/CompMode.js"></script>
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

	{include file=tracking.tpl}
</head>

<body data-ng-controller="CompMode">
{include file=tracking-image.tpl}
<div id="pageWrapper">

{if $smarty.const.COMPETITION_MODE}
<!-- TODO:
* Add a link to /comp/gamepoints somewhere
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
			<a style="position: absolute; right:0; margin-top: 20px; margin-right: 100px;"
			   href="{$root_uri}events/sr2014/2014-04-26-competition">Tell me more...</a>
			<h1 style="text-align: center;">SR2014 Live!</h1>
			<!-- TODO: work out if ths is the right Justin.tv feed? -->
			<p style="float: left;"><object
			    class="video"
			    type="application/x-shockwave-flash"
			    data="http://www.justin.tv/widgets/live_embed_player.swf?channel=studentrobotics"
			    id="live_embed_player_flash"
			    height="300"
			    width="400"
			    >
				<param name="allowFullScreen" value="true"/>
				<param name="allowScriptAccess" value="always" />
				<param name="allowNetworking" value="all" />
				<param name="movie" value="http://www.justin.tv/widgets/live_embed_player.swf" />
				<param name="flashvars" value="hostname=www.justin.tv&amp;channel=studentrobotics&amp;auto_play=true&amp;start_volume=26" />
			</object></p>

			<p style="float: left;">
				<a width="500" height="300"
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

			<br style="clear: both;" />

			<div style="width: 600px; float: left;">
				<h2><a href="{$root_uri}comp/schedule">Match Schedule</a></h2>
				<div id="match_sched">
{literal}
<table class="schedule">
	<thead>
		<tr>
			<th>Time</th>
			<th>Match</th>
			<th data-ng-repeat="arena in arenas" colspan="4">Arena {{arena}}</th>
		</tr>
	</thead>
	<tbody>
		<tr data-ng-repeat="match in matches"
			id="match-{{match.number}}">
			<td title="Begins at {{match.time|date:'HH:mm:ss'}}.">{{match.time|date:'HH:mm'}}</td>
			<td>{{match.number}}</td>
			<td data-ng-repeat="team in match.teams track by $index"
				data-ng-class="{match: team==chosenTeam}"
				title="{{team|teamName:teams}}">
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

			<div style="width: 300px; float: left;">
				<!-- TODO: maybe move to left so that you read this first
				  -- this tells you that the TLAs are teams -->
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
	<tr data-ng-repeat="item in league_points|limitTo:10" id="{{item.tla}}">
		<td>{{item.pos}}</td>
		<td>{{item.points}}</td>
		<td title="{{item.tla|teamName:teams}}">
		<a href="{/literal}{$root_uri}{literal}teams/{{item.tla}}">{{item.tla}}</a>
		</td>
	</tr>
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
{else}
					<h3><a href="{$root_uri}about/how_to_help">Want to Get Involved?</a></h3>
					<p>
						Student Robotics is always looking for more people to get involved, and not just schools.
						Whether you're a University student or a company considering sponsoring the competition,
						you are more than welcome to get involved.
					</p>
{/if}
				</div>

{if !$smarty.const.COMPETITION_MODE}
				<div class="box">
					<h3><a href="{$root_uri}key_dates">SR2014 Key Dates</a></h3>
					<div id="date_tabs">
						<ul>
							<li><a href="#date_soton">Southampton</a></li>
							<li><a href="#date_bristol">Bristol</a></li>
							<li><a href="#date_munich">Munich</a></li>
							<li><a href="#date_norfolk">Norfolk</a></li>
							<li><a href="#date_oxford">Oxford</a></li>
							<li><a href="#date_surrey">Guildford</a></li>
						</ul>
						<div id="date_soton">
							<a href="{$root_uri}events/tech_days">Tech Days</a>:
                            <ul>
                                <li><a href="{$root_uri}events/sr2014/2013-11-30-soton_tech_day_1">30<sup>th</sup> November</a></li>
                                <li><a href="{$root_uri}events/sr2014/2014-02-15-soton_tech_day_2">15<sup>th</sup> February</a></li>
                                <li><a href="{$root_uri}events/sr2014/2014-03-15-soton_tech_day_3">15<sup>th</sup> March</a></li>
                            </ul>

                            <a href="{$root_uri}events/kickstart">Kickstart:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2014/2013-10-12-soton_kickstart">12<sup>th</sup> October</a></li>
                            </ul>
						</div>
						<div id="date_bristol">
							<a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>

                                <li><a href="{$root_uri}events/sr2014/2013-11-30-bristol_tech_day_1">30<sup>th</sup> November</a></li>
                                <li><a href="{$root_uri}events/sr2014/2014-02-08-bristol_tech_day_2">8<sup>th</sup> February</a></li>
                                <li><a href="{$root_uri}events/sr2014/2014-03-08-bristol_tech_day_3">8<sup>th</sup> March</a></li>
                            </ul>

                            <a href="{$root_uri}events/kickstart">Kickstart:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2014/2013-10-12-bristol_kickstart">12<sup>th</sup> October</a></li>
                            </ul>
						</div>
						<div id="date_oxford">
							<a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>
                                <li><i>To be announced</i></li>
                            </ul>
						</div>
						<div id="date_surrey">
							<a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2014/2013-12-07-surrey_tech_day_1">7<sup>th</sup> December</a></li>
                                <li><a href="{$root_uri}events/sr2014/2014-03-01-surrey_tech_day_2">1<sup>st</sup> March</a></li>
                            </ul>
						</div>
						<div id="date_norfolk">
							<a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>
                                <li><i>To be announced</i></li>
                            </ul>
                            <a href="{$root_uri}events/kickstart">Kickstart:</a>
                            <ul>
                                <li><a href="{$root_uri}events/sr2014/2013-10-12-norfolk_kickstart">12<sup>th</sup> October</a></li>
                            </ul>


						</div>
						<div id="date_munich">
							<a href="{$root_uri}events/tech_days">Tech Days:</a>
                            <ul>
                                <li><i>To be announced</i></li>
                            </ul>
						</div>
					</div>
					<div>
						<a href="{$root_uri}events/competition">Competition:</a>
						<ul>
							<li><a href="{$root_uri}events/sr2014/2014-04-26-competition">26<sup>th</sup> and 27<sup>th</sup> April 2014</a></li>
						</ul>
					</div>

				</div>
{/if}
				<div class="box clearboth">
					<h3><a href="{$root_uir}ide">The IDE</a></h3>
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

