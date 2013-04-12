<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>Welcome to Student Robotics | Student Robotics</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="keywords" content="student, robotics, robot, srobo, competition, southampton" />
	<meta name="description" content="Student Robotics is an exciting competition between sixth form schools and colleges to build fully autonomous robots." />
	<meta name="google-site-verification" content="GizX0DcCqEeGihd9CyYaqM1bVXUB-lhB9rhm53UdRC8" />
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/main.css" />
	<link rel="stylesheet" type="text/css" href="{$root_uri}css/home.css" />
	<link rel="alternate" type="application/rss+xml" title="SR RSS" href="{$root_uri}feed.php" />
	<link rel="shortcut icon" href="{$root_uri}images/template/favicon.ico" />

	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>

	{literal}
	<script type="text/javascript">
	  $(document).ready(function() {
	    $("#date_tabs").tabs();

            setInterval(function() {
              $("#event_sched").load("screens/event_sched.html");
              $("#match_sched").load("screens/match_sched.html");
              $("#leaderboard").load("screens/leaderboard.html");
            }, 10000);
	  });
	</script>
	{/literal}

	{literal}
	<style type="text/css">
		div.content div#competition {
			margin-top: -20px;
			position: relative;
			margin-bottom: 20px;
			border-bottom:1px solid silver;
			overflow: hidden;
		}

		div#header {
			float:right;
			width:960px;
		}

		div#header div#navwrapper {
			float: right;
			margin-top: 50px;
			margin-right: 30px;
			font-size: 30px;
			font-weight: bold;
		}

		div#header a {
			float:left;
			margin-top:20px;
			margin-left:20px;
		}

		div#header ul {
			clear:both;
			display: block;
			margin-top:-8px;
		}

		div#header ul li {
			float:left;
			margin-left:20px;
		}

		div#header ul li a {
			text-decoration:none;
			color:#8b8884;
			padding:8px;
			letter-spacing:1px;
			margin-top:0px;
			margin-left:0px;
			display:block;
		}

		div#header ul li a:hover, div#header ul li a:focus {
			color: #DE6400;
		}
	</style>
	{/literal}

	{include file=tracking.tpl}
</head>

<body>
{include file=tracking-image.tpl}
<div id="pageWrapper">

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
			<a style="position: absolute; right:0; margin-top: 20px; margin-right: 100px;" href="{$root_uri}events/sr2013/2013-04-13-competition">Tell me more...</a>
			<h1 style="text-align: center;">SR2013 Live!</h1>
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

			<p style="float: left;"><a
			    width="500"
			    height="300"
			    class="twitter-timeline"
			    data-dnt="true"
			    data-chrome="noheader nofooter"
			    data-widget-id="321728443496660993"
			    href="https://twitter.com/StudentRobotics"
			    >
				Tweets from @StudentRobotics
			</a>
			<script id="twitter-wjs" src="https://platform.twitter.com/widgets.js"></script></p>

			<br style="clear: both;" />

			<div style="width: 300px; float: left;">
			<h2>Event Schedule</h2>
			<div id="event_sched">
			</div>
			</div>

			<div style="width: 300px; float: left;">
			<h2>Match Schedule</h2>
			<div id="match_sched">
			</div>
			</div>

			<div style="width: 300px; float: left;">
			<h2>Leaderboard</h2>
			<div id="leaderboard">
			</div>
			</div>
		</div>

		<div id="expMenuAndBoxWrapper">

			<div id="expandedMenu">

				<h3>Take a Look Around</h3>

				{makemenu menu=$side_menu}

			</div>

			<div id="boxWrapper">

				<div class="box">
					<h3><a href="{$root_uri}about">Who are we?</a></h3>
					<p>Student Robotics is an exciting competition, held at the University of Southampton, between teams of students from sixth form schools and colleges to build fully autonomous robots. Led by a group of students from the Universities of Southampton and Bristol, participating teams will have to design, build and test their robots, ready to compete against other teams.
					</p>

				</div>

				<div class="box">
					<h3><a href="{$root_uri}schools/key_dates">SR2013 Key Dates</a></h3>
					<div id="date_tabs">
						<ul>
							<li><a href="#date_soton">Southampton</a></li>
							<li><a href="#date_bristol">Bristol</a></li>
							<li><a href="#date_oxford">Oxford</a></li>
							<li><a href="#date_munich">Munich</a></li>
						</ul>
						<div id="date_soton">
							<a href="{$root_uri}schools/tech_days">Tech Days</a>:
							<ul>
								<li><a href="{$root_uri}events/sr2013/2012-12-01-soton_tech_day_1">1<sup>st</sup> December</a></li>
								<li><a href="{$root_uri}events/sr2013/2013-02-09-soton_tech_day_2">9<sup>th</sup> February</a></li>
								<li><a href="{$root_uri}events/sr2013/2013-03-16-soton_tech_day_3">16<sup>th</sup> March</a></li>
							</ul>
						</div>
						<div id="date_bristol">
							<a href="{$root_uri}schools/tech_days">Tech Days:</a>
							<ul>
								<li><a href="{$root_uri}events/sr2013/2012-12-01-bristol_tech_day_1">1<sup>st</sup> December</a></li>
								<li><a href="{$root_uri}events/sr2013/2013-02-02-bristol_tech_day_2">2<sup>nd</sup> February</a></li>
								<li><a href="{$root_uri}events/sr2013/2013-03-02-bristol_tech_day_3">2<sup>nd</sup> March</a></li>
							</ul>
						</div>
						<div id="date_oxford">
							<a href="{$root_uri}schools/tech_days">Tech Days:</a>
							<ul>
								<li><a href="{$root_uri}events/sr2013/2013-02-23-oxford_tech_day_1">23<sup>rd</sup> February</a></li>
							</ul>
						</div>
						<div id="date_munich">
							<a href="{$root_uri}schools/tech_days">Tech Days:</a>
							<ul>
								<li><a href="{$root_uri}events/sr2013/2013-02-09-munich_tech_day_1">9<sup>th</sup> February</a></li>
							</ul>
						</div>

					</div>
					<div>
						<a href="{$root_uri}schools/kickstart">Kickstart:</a>
						<ul>
							<li><a href="{$root_uri}events/sr2013/2012-11-03-kickstart">3<sup>rd</sup> November</a></li>
						</ul>

						<a href="{$root_uri}schools/competition">Competition:</a>
						<ul>
							<li><a href="{$root_uri}events/sr2013/2013-04-13-competition">13<sup>th</sup> &amp; 14<sup>th</sup> April</a></li>
						</ul>

					</div>

				</div>

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

