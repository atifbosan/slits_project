<?php
  require 'db.php';
  $response = array();

  $query="SELECT * FROM videos_tbl";
  $result = mysqli_query($con,$query);

  if(mysqli_num_rows($result)>0){
      while($rows=$result->fetch_assoc()){
          $response[]=$rows;
      }

  }else{
      $response['error']='1';
      $response['message']='No Data Found!';
  }

echo json_encode($response);

?>