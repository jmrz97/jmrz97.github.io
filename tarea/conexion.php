<?php
function OpenCon()
 {

   $dsn = 'mysql:dbname=inventario_libros;host=127.0.0.1';
   $usuario = 'root';
   $contraseña = '';
   
   try {
      $mbd = new PDO($dsn, $usuario, $contraseña);
   } 
   catch (PDOException $e) {
      die("Falló la conexión: " . $e->getMessage());
      $mbd = null;
   }

   return $mbd;
}
 
function CloseCon($mbd) {
   $mbd = null;
}
   
?>