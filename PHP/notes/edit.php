<?php

include '../connect.php';
include '../functions.php';



$noteid =  requestdata("id");
$title    = requestdata("title");
$content = requestdata("content");
$imagename = requestdata("imagename");

if(isset($_FILES['file'])){
    deleteFile('../upload', $imagename);
    $imagename = imageUpload("file");

}


$stmt = $con->prepare("UPDATE `notes` SET `notes_title`= ? ,`notes_content`= ? , notes_image=? WHERE `note_id`= ? ");

$stmt->execute(array($title,$content, $imagename,$noteid));


$count = $stmt-> rowCount();

if($count>0){
    echo json_encode(array("status" => "Success"));
}
else{
    echo json_encode(array("status" => "Fail"));
}
//array($username,$email,$password)