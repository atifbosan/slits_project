<?php 
  require 'db.php';
$response = array();

 $v_id=(isset($_POST['v_id']) ? $_POST['v_id'] : '');
 $v_title=(isset($_POST['v_title']) ? $_POST['v_title'] : '');
 $v_description=(isset($_POST['v_description']) ? $_POST['v_description'] : '');
 $thumb_img=(isset($_POST['thumb_img']) ? $_POST['thumb_img'] : '');
 $video_url=(isset($_POST['video_url']) ? $_POST['video_url'] : '');
 $user_id=(isset($_POST['user_id']) ? $_POST['user_id'] : '');

 $category=(isset($_POST['category']) ? $_POST['category'] : '');

    if($category=="insert"){


            $checkQuery="SELECT * FROM favrt_tble WHERE v_id='$v_id' and  user_id='$user_id'";
            $resultCheck=mysqli_query($con,$checkQuery);

            if(mysqli_num_rows($resultCheck)>0){

                $response['error']='11';
                $response['message']='already added to favourite';
                
            }else{

                $insertQuery="INSERT INTO favrt_tble(v_id, v_title, v_description, thumb_img, video_url,user_id) VALUES ('$v_id','$v_title','$v_description','$thumb_img','$video_url','$user_id')";
                $result=mysqli_query($con,$insertQuery);

                if($result){
                $response['error']='0';
                $response['message']="Added to favourite";
                }else{
                $response['error']='1';
                $response['message']="Added to favourite failed";
                }
        }


    }else if($category=="fetch"){

        $fetchQuery="SELECT * FROM favrt_tble WHERE user_id='$user_id'";

        $result=mysqli_query($con,$fetchQuery);

        if(mysqli_num_rows($result)>0){

            while($rows=$result->fetch_assoc()){
                $response[]=$rows;
            }
        }else{
            $response['error']='2';
            $response['message']="No data found!";
        }


    }else if($category=="delete"){

            $deleteQuery="DELETE FROM favrt_tble WHERE v_id='$v_id' and user_id='$user_id'";
            $result=mysqli_query($con,$deleteQuery);

            if($result){
                $response['error']='3';
                $response['message']='removed from favourite';
            }else{
                 $response['error']='4';
                $response['message']='action failed';
            }
    } else{

                $response['error']='5';
                $response['message']='No Category should be selected';
    }

 echo json_encode($response);
  ?>