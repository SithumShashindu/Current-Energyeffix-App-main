<?php

include '../connection.php';

$userEmail = $_POST['usersUId'];
$userName = $_POST['usersUId'];
$password = md5($_POST['usersPwd']);

$sqlQuery = "SELECT * FROM users WHERE (usersEmail ='$userEmail' OR usersUId ='$userName') AND usersPwd='$password'";
$resultofQuery = $connectNow->query($sqlQuery);

if ($resultofQuery->num_rows > 0) {
	
	$userRecord = array();
	while($rowFound = $resultofQuery -> fetch_assoc()){
	$userRecord[] = $rowFound;
	}
	
	echo json_encode(
	array(
		"success" => true,
		"userData" => $userRecord[0]
		,)
	);
} 
else {
    echo json_encode(array("success" => false));
}
?>
