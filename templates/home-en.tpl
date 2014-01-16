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
	  });
	</script>
	{/literal}

	{include file=tracking.tpl}
</head>

<body>
{include file=tracking-image.tpl}
<div id="pageWrapper">

	{include file="header-en.tpl"}

	<div class="content">

		<div id="topBanner">
			<img src="{$root_uri}images/content/srobo_website_robot.png" alt="Image of Robot" />

			<h1>Welcome to Student Robotics</h1>

			<p>Student Robotics is an exciting competition, held at
			the University of Southampton, between teams of students from sixth
			form schools and colleges, to build fully autonomous robots. Led by
			a group of students from the Universities of Southampton and
			Bristol, participating teams will have to design, build and test 
			their robots, ready to compete against other teams.</p>
		</div>

		<div id="latestNews">

			{latestRSS}

		</div>

		<div id="expMenuAndBoxWrapper">

			<div id="expandedMenu">

				<h3>Take a Look Around</h3>

				{makemenu menu=$side_menu}

			</div>

			<div id="boxWrapper">

				<div class="box">
					<h3><a href="{$root_uri}about/how_to_help">Want to Get Involved?</a></h3>
					<p>
						Student Robotics is always looking for more people to get involved, and not just schools.
						Whether you're a University student or a company considering sponsoring the competition,
						you are more than welcome to get involved.
					</p>

				</div>

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

