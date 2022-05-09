<?php 
require 'db.php';	
 $response = array();

	  
	   $name = (isset($_POST['name']) ? $_POST['name'] : '');
	   $phoneNumber = (isset($_POST['phoneNumber']) ? $_POST['phoneNumber'] : '');
	   $email = (isset($_POST['email']) ? $_POST['email'] : '');
	   $password = (isset($_POST['password']) ? $_POST['password'] : '');
	   $user_type = (isset($_POST['user_type']) ? $_POST['user_type'] : '');

  	 $checkCustomer=mysqli_query($con,"SELECT * FROM user_registration WHERE email='$email'");
  	 
  	  if(mysqli_num_rows($checkCustomer)>0){
  	      
  	        $response ['error'] = '2';
  	     $response['message']='User Number Already Exist!';
  	 }
  	 else{
		   
			   $result = mysqli_query($con,"INSERT INTO user_registration(user_type,name,phoneNumber,email,password) VALUES('$user_type','$name','$phoneNumber','$email','$password')");	   
  	   if($result){

  	        $response ['error'] = '0';
	    	$response ['message'] = 'Registration Successful';
	   }
 	  	 
 	  	else {
 	  	    $response['error']='1';
 	  	    $response['message']="Not Successful";
 	  	}
 	
 	  }
 echo json_encode($response);
 ?>