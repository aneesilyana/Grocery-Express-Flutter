<?php
include '../connection.php';

// Collect POST data
$username = $_POST['username'];
$email = $_POST['email'];
$password = md5($_POST['password']); // Hash the password
$role_name = $_POST['role_name']; // Role name provided by the client

try {
    // Start a transaction
    $connectNow->begin_transaction();

    // Step 1: Insert the user into the `user` table with default values
    $userInsertQuery = "INSERT INTO user (username, email, password) 
                         VALUES (?, ?, ?)";
    $userStmt = $connectNow->prepare($userInsertQuery);
    $userStmt->bind_param("sss", $username, $email, $password);
    $userStmt->execute();

    if ($userStmt->affected_rows <= 0) {
        throw new Exception("Failed to insert user.");
    }

    // Get the newly inserted user_id
    $user_id = $userStmt->insert_id;

    // Step 2: Retrieve the role_id for the given role_name
    $roleSelectQuery = "SELECT role_id FROM roles WHERE role_name = ?";
    $roleStmt = $connectNow->prepare($roleSelectQuery);
    $roleStmt->bind_param("s", $role_name);
    $roleStmt->execute();
    $roleResult = $roleStmt->get_result();

    if ($roleResult->num_rows <= 0) {
        throw new Exception("Role not found.");
    }

    $roleRow = $roleResult->fetch_assoc();
    $role_id = $roleRow['role_id'];

    // Step 3: Insert the user_id and role_id into the `userroles` table
    $userRoleInsertQuery = "INSERT INTO userroles (user_id, role_id) VALUES (?, ?)";
    $userRoleStmt = $connectNow->prepare($userRoleInsertQuery);
    $userRoleStmt->bind_param("ii", $user_id, $role_id);
    $userRoleStmt->execute();

    if ($userRoleStmt->affected_rows <= 0) {
        throw new Exception("Failed to assign role to user.");
    }

    // Commit the transaction
    $connectNow->commit();

    echo json_encode(array("signUpSuccessful" => true));
} catch (Exception $e) {
    // Rollback the transaction on error
    $connectNow->rollback();

    echo json_encode(array("signUpSuccessful" => false, "message" => $e->getMessage()));
} finally {
    // Close statements and connections
    if (isset($userStmt)) $userStmt->close();
    if (isset($roleStmt)) $roleStmt->close();
    if (isset($userRoleStmt)) $userRoleStmt->close();
    $connectNow->close();
}
