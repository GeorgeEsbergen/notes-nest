<?php

include '../connect.php';
include '../functions.php';



$userid = requestdata('id');


$stmt = $con->prepare("SELECT * FROM  `notes` WHERE  `user_id`=? ");

$stmt ->execute(array($userid));

$data=$stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt-> rowCount();

if($count>0){
    echo json_encode(array("status" => "Success" ,"data"=>$data));
}
else{
    echo json_encode(array("status" => "Fail"));
}