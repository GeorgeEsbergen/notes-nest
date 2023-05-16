<?php

include '../connect.php';
include '../functions.php';


$email = requestdata('email');
$password = requestdata('password');

$stmt = $con->prepare("SELECT * FROM  users WHERE  `email`=?  And  `password`=? ");

$stmt ->execute(array($email , $password ));

$data=$stmt->fetch(PDO::FETCH_ASSOC);

$count = $stmt-> rowCount();

if($count>0){
    echo json_encode(array("status" => "Success" ,"data"=>$data));
}
else{
    echo json_encode(array("status" => "Fail"));
}