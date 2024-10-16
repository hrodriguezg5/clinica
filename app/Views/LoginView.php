<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title><?= SITE_NAME; ?></title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="<?= URL_ROUTE; ?>/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Libraries Stylesheet -->
    <link href="<?= URL_ROUTE; ?>/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="<?= URL_ROUTE; ?>/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="<?= URL_ROUTE; ?>/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="<?= URL_ROUTE; ?>/css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-fluid position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center flex-column">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status"></div>
            <div class="text-center mt-3">
                <p> Cargando...</p>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Alerta HTML Inicio-->
        <div id="errorMessage" class="alert-dismissible position-fixed top-0 end-0 m-3 fade" role="alert">
            <i class="bi bi-bell-fill me-2"></i><span id="errorText"></span>
            <button id="closeButton" type="button" class="btn-close" aria-label="Close"></button>
        </div>
        <!-- Alerta HTML Fin -->


        <!-- Sign In Start -->
        <div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-11 col-sm-8 col-md-6 col-lg-5 col-xl-4 col-xxl-3">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                        <div class="d-flex align-items-center justify-content-center mb-3">
                            <h3 class="text-primary">
                                <img class="image me-2 mb-2" src="/clinica/img/logo.png">Clínica
                            </h3>
                        </div>
                        <form id="loginForm">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="loginUsername" placeholder="" autocomplete="username">
                                <label for="loginUsername">Usuario</label>
                            </div>
                            <div class="form-floating mb-4 position-relative">
                                <input type="password" class="form-control" id="loginPassword" placeholder="" autocomplete="current-password">
                                <label for="loginPassword">Contraseña</label>
                                <span id="togglePassword" class="position-absolute top-50 end-0 translate-middle-y pe-3 cursor-pointer">
                                    <i class="bi bi-eye"></i>
                                </span>
                            </div>
                            <button type="submit" class="btn btn-primary py-3 w-100 mb-4">Iniciar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sign In End -->
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<?= URL_ROUTE; ?>/lib/chart/chart.min.js"></script>
    <script src="<?= URL_ROUTE; ?>/lib/easing/easing.min.js"></script>
    <script src="<?= URL_ROUTE; ?>/lib/waypoints/waypoints.min.js"></script>
    <script src="<?= URL_ROUTE; ?>/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="<?= URL_ROUTE; ?>/lib/tempusdominus/js/moment.min.js"></script>
    <script src="<?= URL_ROUTE; ?>/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="<?= URL_ROUTE; ?>/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
    
    <script>
      	const urlBase = "<?= URL_ROUTE; ?>";
    </script>

    <script type="module" src="<?= URL_ROUTE; ?>/js/login.js"></script>
</body>

</html>