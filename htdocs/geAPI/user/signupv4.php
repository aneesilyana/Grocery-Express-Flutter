<?php
include '../connection.php';

// Get user data from the POST request
$username = $_POST['username'];
$fname = $_POST['fname'];
$email = $_POST['email'];
$phonenum = $_POST['phonenum'];
$password = md5($_POST['password']); // Encrypt password
$address = $_POST['address'];
$role_id = $_POST['role_id']; // Role ID sent from the frontend

try {
    // Start a transaction
    $connectNow->begin_transaction();

    // Insert user data into the `user` table
    $sqlInsertUser = "INSERT INTO user (username, fname, email, phonenum, `password`, `address`) 
                      VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = $connectNow->prepare($sqlInsertUser);
    $stmt->bind_param("ssssss", $username, $fname, $email, $phonenum, $password, $address);

    if (!$stmt->execute()) {
        throw new Exception("Error inserting user: " . $stmt->error);
    }

    // Get the last inserted user_id
    $user_id = $connectNow->insert_id;

    // Insert the user role into the `userroles` table
    $sqlInsertUserRole = "INSERT INTO userroles (user_id, role_id) VALUES (?, ?)";
    $stmt = $connectNow->prepare($sqlInsertUserRole);
    $stmt->bind_param("ii", $user_id, $role_id);

    if (!$stmt->execute()) {
        throw new Exception("Error assigning role: " . $stmt->error);
    }

    // Commit the transaction
    $connectNow->commit();

    // Return a success response
    echo json_encode(array("signUpSuccessful" => true));

} catch (Exception $e) {
    // Rollback the transaction on error
    $connectNow->rollback();
    echo json_encode(array("signUpSuccessful" => false, "error" => $e->getMessage()));
}

$connectNow->close();
?>
