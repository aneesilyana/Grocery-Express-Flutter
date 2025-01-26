<?php
include '../connection.php';

// Collect POST data from Flutter
$user_id = $_POST['id'];
$username = $_POST['username'];
$fname = $_POST['fname'];
$email = $_POST['email'];
$phonenum = $_POST['phonenum'];
$password = md5($_POST['password']); // Optional: Hash password only if updated
$address = $_POST['address'];

try {
    // Prepare the SQL query to update the user
    $sqlQuery = "UPDATE user SET 
        username = ?, 
        fname = ?, 
        email = ?, 
        phonenum = ?, 
        password = ?, 
        address = ? 
        WHERE user_id = ?";

    $stmt = $connectNow->prepare($sqlQuery);
    $stmt->bind_param(
        "ssssssi",
        $username,
        $fname,
        $email,
        $phonenum,
        $password,
        $address,
        $user_id
    );

    // Execute the query
    if ($stmt->execute()) {
        echo json_encode(array("updateSuccessful" => true));
    } else {
        echo json_encode(array("updateSuccessful" => false, "message" => $stmt->error));
    }
} catch (Exception $e) {
    echo json_encode(array("updateSuccessful" => false, "message" => $e->getMessage()));
} finally {
    $stmt->close();
    $connectNow->close();
}
