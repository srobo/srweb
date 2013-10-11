<?php

$teams_json = 'resources/2014/teams.json';

$team_info_college_lut = json_decode(file_get_contents($teams_json), true);
