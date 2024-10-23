<?php require_once APP_ROUTE."/Views/Template/Header.php"; ?>
            <!-- Contenido de la Página Inicio -->
            <div id="content">
                <!-- Titulo del Módulo Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row">
                        <div class="col-12 mb-0">
                            <div class="bg-transparent rounded d-flex align-items-center px-2">
                                <i id="moduleIcon"></i>
                                <h4 id="moduleTitle" class="mb-0 ms-2"></h4>
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
                        <img src="<?= URL_ROUTE; ?>/img/home.jpg" class="img-fluid w-100" alt="Inicio" style="object-fit: cover; max-width: 950px;"> <!-- Ajusta el valor de max-width según tus necesidades -->
                    </div>
                </div>
                <!-- Contenido de Bievenida Fin -->
            </div>
            <!-- Contenido de la Página Fin -->

<?php require_once APP_ROUTE."/Views/Template/Footer.php"; ?>