<?php
include '../connection.php';

// POST => send data to db
$username = $_POST['username'];
$fname = $_POST['fname'];
$email = $_POST['email'];
$phonenum = $_POST['phonenum'];
$password = $_POST['password'];
$address = $_POST['address'];
$role_id = $_POST['role_id'];

$sqlQuery = "INSERT INTO user (username, fname, email, phonenum, `password`, `address`, created_at, role_id) 
VALUES ('$username', '$fname', '$email', '$phonenum', '$password', '$address', CURRENT_TIMESTAMP, '$role_id')";

$resultQuery = $connectNow->query($sqlQuery);

if ($resultQuery) {
    $userId = $connectNow->insert_id;
    echo json_encode(array("signUpSuccessful" => true));
} else {
    echo json_encode(array("signUpSuccessful" => false, "error" => $connectNow->error));
}
?>
