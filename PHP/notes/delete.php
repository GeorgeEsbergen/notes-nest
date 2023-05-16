<?php

include '../connect.php';
include '../functions.php';



$noteid =  requestdata("id");
$imagename = requestdata("imagename");



$stmt = $con->prepare("DELETE FROM notes WHERE `note_id` =? ");

$stmt->execute(array($noteid));


$count = $stmt-> rowCount();

if($count>0){
    deleteFile('../upload', $imagename);
    echo json_encode(array("status" => "Success"));
}
else{
    echo json_encode(array("status" => "Fail"));
}
//array($username,$email,$password)