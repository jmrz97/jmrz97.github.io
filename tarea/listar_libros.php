<!doctype html>
<html lang="es">
  <head>    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.12.1/css/all.css" />
    <title>Libros</title>
  </head>
  <body>
    <br/>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <div class="row">
                    <div class="col-lg-9">
                        <h4>Lista de libros</h4>
                    </div>
                    <div class="col-lg-3">
                        <a class="btn btn-success" href="agregar_libro.php"><i class="fas fa-plus"></i> Agregar</a>
                        <a class="btn btn-info" href="listar_libros_inventario.php"><i class="fas fa-history"></i> Historial</a>
                    </div>
                </div>                
            </div>

            <?php
            include 'conexion.php';
            $conn = OpenCon();
            
            $sql = "SELECT libros.codigoLibro, libros.nombreLibro, libros.existencias, libros.precio, autores.nombreAutor,  editoriales.nombreEditorial, generos.nombreGenero, libros.descripcion 
            FROM libros 
            INNER JOIN autores ON libros.codigoAutor = autores.codigoAutor
            INNER JOIN editoriales ON libros.codigoEditorial = editoriales.codigoEditorial
            INNER JOIN generos ON libros.idGenero = generos.idGenero";
            
            ?>

                <table class="table">
                    <thead>
                        <tr>
                            <th>Código Libro</th>
                            <th>Nombre</th>
                            <th>Stock</th>
                            <th>Precio</th>
                            <th>Autor</th>
                            <th>Editorial</th>
                            <th>Genero</th>
                            <th>Descripcion</th>
                            <th>Opciones</th>
                        </tr>                        
                    </thead>
                    <tbody>
                <?php
                    foreach ($conn->query($sql) as $row) {
                        echo "<tr>";
                        echo "<td>" . $row["codigoLibro"]. "</td>";
                        echo "<td>" . $row["nombreLibro"]. "</td>";
                        echo "<td>" . $row["existencias"]. "</td>";
                        echo "<td>" . $row["precio"]. "</td>";
                        echo "<td>" . $row["nombreAutor"]. "</td>";
                        echo "<td>" . $row["nombreEditorial"]. "</td>";
                        echo "<td>" . $row["nombreGenero"]. "</td>";
                        echo "<td>" . $row["descripcion"]. "</td>";
                        echo "<td>";
                        echo "<a class=\"btn btn-primary\" href=\"ingresar_libro.php?codigo=";
                        echo $row["codigoLibro"]."\"><i class=\"button\">Ingresar</i></a> ";
                        echo "<a class=\"btn btn-warning\" href=\"retirar_libro.php?codigo=";
                        echo $row["codigoLibro"]."\"><i class=\"button\">Retirar</i></a> ";
                        echo "<a class=\"btn btn-danger\" href=\"eliminar_libro.php?codigo=";
                        echo $row["codigoLibro"]."\"><i class=\"far fa-trash-alt\"></i></a>";
                        echo "</td>";
                        echo "</tr>";
                    }

                    ?>
                    </tbody>
                </table>
            <?php

            CloseCon($conn);
        ?>

        </div>

        <?php
            if (isset($_GET['result'])) {
               if($_GET['result'] == 1) {
                    echo "<div class=\"alert alert-success\" role=\"alert\">";
                    echo "Se ha eliminado el genero";
                    echo "</div>";
               }else{
                    echo "<div class=\"alert alert-danger\" role=\"alert\">";
                    echo "No se pudo eliminar el genero. ";                
                    echo "</div>";  
               }
            }
        ?>

    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
  </body>
</html>

