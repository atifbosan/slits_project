<?php 


  define("dbhost", "localhost");
  define("dbuser", "root");
  define("dbpass", "");
  define("dbname", "slits_db");

    $con = mysqli_connect(dbhost,dbuser,dbpass,dbname) or die('connection has not been established');
    
    // if ($con) {
    //   echo "Successfull";
    // }


 ?>
