<?php
require 'db.php';	
 $response = array();


    $category = (isset($_POST['category']) ? $_POST['category'] : '');
    $s_title = (isset($_POST['s_title']) ? $_POST['s_title'] : '');
    $s_description = (isset($_POST['comp_description']) ? $_POST['comp_description'] : '');
    $user_id = (isset($_POST['user_id']) ? $_POST['user_id'] : '');
    $name = (isset($_POST['name']) ? $_POST['name'] : '');
    $is_view = (isset($_POST['is_view']) ? $_POST['is_view'] : '');

  if($category=="insert"){

            $query="INSERT INTO suggestion_tbl(user_id,name, s_title, is_view,user_type) VALUES ('$user_id','$name','$s_title','0','Admin')";
            $result=mysqli_query($con,$query);

            if($result){
                $response['error']='0';
                $response['message']='Sent Successful';
            }else{
                $response['error']='1';
                $response['message']='Sent Failed';
            }

  }else if($category=="fetch"){

        $replyQuery="SELECT * FROM suggestion_tbl where user_type='User' order by is_view ASC";
        $result=mysqli_query($con,$replyQuery);

        if(mysqli_num_rows($result)){

            while($rows=$result->fetch_assoc()){
                $response[]=$rows;
            }

        }else{
            $response['error']='2';
            $response['message']="No Data Found!";
        }

  }else{
        $response['error']='3';
        $response['message']="No Category Should be selected";
  }



echo json_encode($response);
?>