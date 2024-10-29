<?php

$serverHost = "localhost";
$user = "sithum";
$pass = "12345678";
$db = "energy_effix";

$connectNow = new mysqli($serverHost, $user, $pass, $db);

if(!$connectNow){
    die("Connection Failed :".mysqli_connect_error());
}

?>