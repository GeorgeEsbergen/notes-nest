<?php
define('MB', 1048576);

function requestdata($request){

    return htmlspecialchars(strip_tags($_POST[$request]));
    
}


function imageUpload($requestImage){
    global $msgError ;
  $imageName  = rand(100,1000).$_FILES[$requestImage]['name'];
  $imagetmp   = $_FILES[$requestImage]['tmp_name'];
  $imageSize  = $_FILES[$requestImage]['size'];
  $allowExt   = array('jpg' , 'png' , "gif" , "pdf");
  $strToArray = explode("." ,$imageName);
  $ext        = end($strToArray);
  $ext        = strtolower($ext);
  if(!empty($imageName) && !in_array($ext ,$allowExt))
  {
    $msgError[] = 'Ext' ;
  }
  if($imageSize > 2*MB){ $msgError[]  ='size';}

  if(empty($msgError)){
    move_uploaded_file($imagetmp , "../upload/".$imageName);
    return $imageName;
  }
  else{
    echo "<pre>";
    print_r($msgError);
    echo "</ pre>";
  }

}

// This Function to delete the images

function deleteFile($dir  ,$imagename){
  if(file_exists($dir.'/'. $imagename)){
    unlink($dir.'/'. $imagename);
  }
}



function checkAuthenticate(){
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

        if ($_SERVER['PHP_AUTH_USER'] != "george" ||  $_SERVER['PHP_AUTH_PW'] != "geo55321"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
  }
