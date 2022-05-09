<?php 
  require 'db.php';
  $response = array();
  $category=(isset($_POST['category']) ? $_POST['category'] : '');
  $v_id=(isset($_POST['v_id']) ? $_POST['v_id'] : '');
  $admin_id=(isset($_POST['admin_id']) ? $_POST['admin_id'] : '');
  $v_title=(isset($_POST['v_title']) ? $_POST['v_title'] : '');
  $v_description=(isset($_POST['v_description']) ? $_POST['v_description'] : '');
 
  if($category=="insert"){

    $insertQuery="";
    $resultInsert=mysqli_query($con,$insertQuery);

        if($resultInsert){
          $response['error']='0';
          $response['message']='Insertion Successful!';
        }else{
            $response['error']='1';
          $response['message']='Insertion failed!';
        }

  }else if($category=="update"){

    $updateQuery="UPDATE videos_tbl SET v_title='$v_title', v_description='$v_description' WHERE v_id='$v_id'";
    $resultUpdate=mysqli_query($con,$updateQuery);

        if($resultUpdate){
            $response['error']='2';
            $response['message']='Updation Successful!';
        }else{
            $response['error']='3';
            $response['message']='Updation failed!';
        }

  }else if($category=="delete"){
    
    $deleteQuery="DELETE FROM videos_tbl WHERE v_id='$v_id'";
    $resultDelete=mysqli_query($con,$deleteQuery);

        if($resultDelete){
          $response['error']='4';
          $response['message']="Deletion Successful!";

        }else{
          $response['error']='5';
          $response['message']="Deletion Failed!";
        }

  }else{
      $response['error']='7';
      $response['message']='No category should be selected';
  }
 



echo json_encode($response);

?>