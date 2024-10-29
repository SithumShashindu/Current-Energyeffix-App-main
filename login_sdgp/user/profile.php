<?php

include '../connection.php';

// Handle POST request for user sign-in
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get user credentials from the POST request
    $email = $_POST['usersEmail'];
    $username = $_POST['usersUId'];
    $password = $_POST['usersPwd'];

    // Query to check if user exists
    $sql = "SELECT * FROM users WHERE (email = '$email' OR username = '$username') AND password = '$password'";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // User exists, return user details
        $user = $result->fetch_assoc();
        echo json_encode(array("success" => true, "userData" => $user));
    } else {
        // User does not exist or incorrect credentials
        echo json_encode(array("success" => false));
    }
}

// Close the database connection
$conn->close();

?>
