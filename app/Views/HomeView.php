<?php require_once APP_ROUTE."/Views/Template/Header.php"; ?>
            <!-- Titulo del Módulo Inicio -->
            <div class="container-fluid pt-4 px-4">
                <div class="row">
                    <div class="col-12 col-sm-12 col-md-3 col-lg-3 col-xl-3 mb-4 mb-md-0">
                        <div class="bg-transparent rounded d-flex align-items-center px-4">
                            <i id="moduleIcon"></i>
                            <h4 id="moduleTitle" class="mb-0 ms-3"></h4>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Titulo del Módulo Fin -->

            <!-- Contenido de Bievenida Inicio -->
            <div class="container-fluid pt-4 px-4">
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-center mb-4">
                        <h1 id="greetingTitle" class="mb-0"></h1>
                    </div>
                    <img src="/clinica/public/img/1.jpg" class="img-fluid w-100" alt="Pacientes Registrados" style="object-fit: cover; max-width: 950px;"> <!-- Ajusta el valor de max-width según tus necesidades -->
                </div>
            </div>
            <!-- Contenido de Bievenida Fin -->

   
<?php require_once APP_ROUTE."/Views/Template/Footer.php"; ?>