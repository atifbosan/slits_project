<?php 
  require 'db.php';
  $response = array();

      
      $user_type = (isset($_POST['user_type']) ? $_POST['user_type'] : '');
      $email = (isset($_POST['email']) ? $_POST['email'] : '');

     if($user_type=="User"){

       $email = (isset($_POST['email']) ? $_POST['email'] : '');
       $password = (isset($_POST['password']) ? $_POST['password'] : '');
  
            $checkUser="SELECT * FROM user_registration WHERE email='$email' AND user_type='$user_type'";
            $result = mysqli_query($con,$checkUser);

      if(mysqli_num_rows($result)>0){

          $checkUserQuery="SELECT * FROM user_registration WHERE email='$email' and  password='$password' ";

            $resultant = mysqli_query($con,$checkUserQuery);

          if(mysqli_num_rows($resultant)>0){

             while($row=$resultant->fetch_assoc())
              $response['user'] = $row; 
               $response['error'] = '0';
               $response['message'] = "You are logged in successfully";
              
           
         }else{
          $response['user'] = (object)[];
          $response['error']='1';
          $response['message'] = "Wrong Credentials";
         }
       }else{
         $response['user'] = (object)[];
          $response['error']='2';
          $response['message'] = "User Does not Exits";
       }

      }
      //----------------------------------Admin----------------------------
    else if($user_type=="Admin"){

       $email = (isset($_POST['email']) ? $_POST['email'] : '');
       $password = (isset($_POST['password']) ? $_POST['password'] : '');

        $checkUser="SELECT * FROM user_registration WHERE email='$email' AND user_type='$user_type'";
        $result = mysqli_query($con,$checkUser);

      if(mysqli_num_rows($result)>0){

        $checkUserQuery="SELECT * FROM user_registration WHERE email='$email' and  password='$password' ";

          $resultant = mysqli_query($con,$checkUserQuery);

          if(mysqli_num_rows($resultant)>0){

             while($row=$resultant->fetch_assoc())
              $response['user'] = $row; 
               $response['error'] = '0';
               $response['message'] = "You are logged in successfully";
              
           
         }else{
          $response['user'] = (object)[];
          $response['error']='1';
          $response['message'] = "Wrong Credentials";
         }
       }else{
         $response['user'] = (object)[];
          $response['error']='2';
          $response['message'] = "User Does not Exits";
       }
      }
         else{
              $response['user'] = (object)[];
              $response['error']='3';
              $response['message'] = "No Category Should be selected!";
      }
echo json_encode($response);
?>

