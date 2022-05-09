<?php
 require 'db.php';
 $response = array();


    $admin_id=(isset($_POST['admin_id']) ? $_POST['admin_id']: '');
    $v_title=(isset($_POST['v_title']) ? $_POST['v_title']: '');
    $v_description=(isset($_POST['v_description']) ? $_POST['v_description']: '');

    $videossurl=isset($_FILES['video']['name']) ;
    $image=isset($_FILES['image']['name']) ;

    $fileName = basename( $_FILES["image"]["name"]);
     $fileNameVideo= basename( $_FILES["video"]["name"]);
    //---Video
    $videoPath="videos/".$fileNameVideo;
    $temp_name_video=isset($_FILES['video']['tmp_name']);

//-------Image
    $imageDirect="thumbnail/".$fileName;
    $temp_name_img=isset($_FILES['image']['tmp_name']);


move_uploaded_file($_FILES["image"]["tmp_name"],$imageDirect);
  
move_uploaded_file($_FILES["video"]["tmp_name"],$videoPath);

 
         $videoUrl="http://192.168.100.3/SlitsApi/". $videoPath;
        $imageUrl="http://192.168.100.3/SlitsApi/".$imageDirect;

        $query="INSERT INTO videos_tbl (admin_id, v_title, v_description, video_url, thumb_img) VALUES ('$admin_id','$v_title','$v_description','$videoUrl','$imageUrl')";
        $result=mysqli_query($con,$query);
        
        if($result){
            $response['error']='0';
            $response['message']='Uploaded Successfully!'.$videoPath;
        }else{
            $response['error']='1';
            $response['message']='Uploading failed!';
        }
  



  echo json_encode($response);
?>