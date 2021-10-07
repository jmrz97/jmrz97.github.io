<!doctype html>
<html lang="es">
  <head>    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" />
    <title>Generos</title>
  </head>
  <body>
    <br/>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <h4>Agregar Libros</h4>
            </div>
            <div class="card-body">
                <form action = "" method = "POST">
                    <label>Codigo:</label>
                    <input type = "text" name = "codigoLibro" id = "codigoLibro" class="form-control"/>
                    <br />
                    <label>Ingresar:</label>
                    <input type = "text" name = "existencias" id = "existencias" class="form-control"/>
                    <br />
                    <input type = "Submit" value ="Guardar" name = "submit" class="btn btn-success"/>
                    <a class="btn btn-info" href="listar_libros.php">Regresar</a>
                    <br />
                </form>
            </div>
        </div>
    </div>

      <?php
         if(isset($_POST["submit"])){
            include 'conexion.php';
            $conn = OpenCon();
           
            // Verificamos la conexión
            if ($conn == null) {
               die("No se pudo conectar a la base de datos: ");
            }
            $existencias = $_POST['existencias'];
            $codigoLibro = $_POST['codigoLibro'];

            $sql = "INSERT INTO `inventario` (`codigoLibro`, `existencias`, `idEstado`) VALUES ('1', '$existencias', '1');";

            $count = $conn->exec($sql);
            if ($count > 0) {
               echo "<div class=\"alert alert-success\" role=\"alert\">";
               echo "Se ha actualizado el genero";
               echo "</div>";
            } else {
               echo "<div class=\"alert alert-danger\" role=\"alert\">";
               echo "No se pudo actualizar el genero. ";
               echo "Error: " . $sql;
               print_r($conn->errorInfo());
               echo "</div>";               
            }
            CloseCon($conn);
         }
      ?>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
  </body>
</html>

