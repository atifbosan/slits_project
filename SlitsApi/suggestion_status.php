<?php 
require 'db.php';	
 $response = array();

        $s_id=( isset($_POST['s_id']) ? $_POST['s_id'] : '');
        

        $result=mysqli_query($con,"UPDATE suggestion_tbl  SET is_view='1' where s_id='$s_id'");

        if($result){
                $response['error']='0';
                $response['message']='Updated Successfully';
        }else{
                $response['error']='0';
                $response['message']='Updation failed';
        }


        echo json_encode($response);

?>