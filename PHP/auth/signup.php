<?php

include '../connect.php';
include '../functions.php';



$username =  requestdata("username");
$email    = requestdata("email");
$password = requestdata("password");

$stmt = $con->prepare("INSERT INTO `users`( `username`, `email` , `password` ) VALUES (?,?,?)");

$stmt->execute(array($username,$email,$password));


$count = $stmt-> rowCount();

if($count>0){
    echo json_encode(array("status" => "Success"));
}
else{
    echo json_encode(array("status" => "Fail"));
}
//array($username,$email,$password)