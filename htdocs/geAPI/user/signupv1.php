<?php
include '../connection.php';

//POST => send data to db

//GET => fetch data from db

$username = $_POST['username'];
$email = $_POST['email'];
$password = md5($_POST['password']);
$role = $_POST['role'];

$sqlQuery = "INSERT INTO user SET username = '$username', email = '$email', password = '$password', role = '$role'";

$resultQuery = $connectNow->query($sqlQuery);

if($resultQuery)
{
    echo json_encode(array("signUpSuccessful"=>true));
}
else
{
    echo json_encode(array("signUpSuccessful"=>false));
}