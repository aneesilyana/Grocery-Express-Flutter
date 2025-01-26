<?php

include '../connection.php';

//POST => send data to db

//GET => fetch data from db

$role_id = $_POST['role_id'];

$sqlRole = "INSERT INTO userroles SET role_id = '$role_id'";