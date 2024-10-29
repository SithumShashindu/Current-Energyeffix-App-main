<?php
// Database connection parameters
$servername = "localhost";
$username = "root"; //daily_energy
$password = ""; //QX6cZi(8-6EYYCwu
$dbname = "energy_effix";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to fetch kWh value where id is 30
$sql = "SELECT kWh FROM daily_energy WHERE id = 2";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        echo $row["kWh"];
    }
} else {
    echo "0 results";
}
$conn->close();
?>