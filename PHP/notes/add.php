<?php

include '../connect.php';
include '../functions.php';





$title =  requestdata("title");
$content    = requestdata("content");
$userid = requestdata("id");

$imagename = imageUpload("file");

if($imagename!= 'fail' ){
    $stmt = $con->prepare("INSERT INTO `notes`( `notes_title`, `notes_content` , `user_id` ,`notes_images` ) VALUES (?,?,?,?)");

$stmt->execute(array($title,$content,$userid  ,$imagename));


$count = $stmt-> rowCount();

if($count>0){
    echo json_encode(array("status" => "Success"));
}
else{
    echo json_encode(array("status" => "Fail"));
}
}else{
    echo json_encode(array("status" => "Fail"));
}
//array($username,$email,$password)