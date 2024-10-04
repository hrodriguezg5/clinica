    <section id="home" class="home">
        
        <div class="home_title">
            <h1>GPSgt Protegiendo tu Vehículo</h1>
            <p>Nos especializamos en la instalación de dispositivos GPS en vehículos terrestres y marinos, 
                garantizando una instalación precisa y confiable, brindando a 
                nuestros clientes tranquilidad y control sobre sus activos en cualquier entorno.
            </p>
        </div>
        <div class="background">
            <img src="<?= URL_ROUTE; ?>/img/background.png" />
        </div>

        <div class="login_form_container">
			<i class='bx bx-x form_close'></i>

            <!-- Formulario de inicio de sesión y registro -->
            <div class="form login_form">

                <!-- Formulario de inicio de sesión -->
                <form action="<?php echo URL_ROUTE; ?>/inicio/ingresar" method="POST">
                    <h2>Inicio de Sesión</h2>
                    <div class="input_box">
                        <input
                            type="email"
                            name="login_email"
                            placeholder="Ingresa tu correo"
                            required
                            autocomplete="email"
                            value="<?=$data["login_email"]; ?>"
                        >
                        <i class='bx bx-envelope email'></i>
                    </div>
                    <div class="input_box">
                        <input
                            type="password"
                            name="login_password"
                            placeholder="Ingresa tu contraseña"
                            required
                            autocomplete="current-password"
                            value="<?=$data["login_password"]; ?>"
                        >
						<i class='bx bx-lock-alt password'></i>
						<i class="bx bx-show pw_hide"></i>
                    </div>
                    <div class="invalid_login">
                        <span>
                        <?php
                        if(isset($_SESSION["loggedin_error"])){
                            echo '<script>
                                        document.addEventListener("DOMContentLoaded", function() {
                                        document.querySelector(".page").classList.add("show");
                                        document.body.style.overflow = "hidden";
                                    });
                                </script>';
                            
                            echo 'Contraseña o usuario incorrecto';
                            session_unset();
                            session_destroy();
                        }
                        ?>
                        </span>
                    </div>
                    <button class="button">Ingresar</button>
                    <div class="login_signup">¿No tienes una cuenta? <a href="." id="signup">Registrarme</a></div>
                </form>
            </div>

            <!-- Formulario de registro -->
            <div class="form signup_form">
                <form action="<?php echo URL_ROUTE; ?>/inicio/registrar" method="POST">
                    <h2>Registro</h2>
                    <div class="input_box">
                        <input
                            type="text"
                            name="register_first_name"
                            placeholder="Ingresa tu nombre"
                            maxlength="50"
                            required
                            value="<?php echo $data["register_first_name"]; ?>"
                        >
                        <i class='bx bx-user-circle user_first_name'></i>
                    </div>
                    <div class="input_box">
                        <input
                            type="test"
                            name="register_last_name"
                            placeholder="Ingresa tu apellido"
                            maxlength="50"
                            required
                            value="<?php echo $data["register_last_name"]; ?>"
                        >
                        <i class='bx bx-user user_last_name'></i>
                    </div>
                    <div class="input_box duplicate_email">
                        <input
                            type="email"
                            name="register_email"
                            placeholder="Ingresa tu correo"
                            maxlength="100"
                            required
                            value="<?php echo $data["register_email"]; ?>"
                        >
                        <i class='bx bx-envelope email'></i>
                        <span>
                        <?php
                        if(isset($_SESSION["duplicate_email"])){
                            echo '<script>document.addEventListener("DOMContentLoaded", function() {
                                        document.querySelector(".page").classList.add("show");
                                        document.querySelector(".login_form_container").classList.add("active");
                                        document.body.style.overflow = "hidden";
                                    });
                                </script>';
                            
                            echo 'Este usuario ya está registrado';
                            session_unset();
                            session_destroy();
                        }
                        ?>
                        </span>
                    </div>
					<div class="input_box">
                        <input
                            type="number"
                            name="register_phone"
                            placeholder="Ingresa tu teléfono"
                            min="00000000"
                            max="99999999"
                            required
                            value="<?php echo $data["register_phone"]; ?>"
                        >
                        <i class='bx bx-phone phone'></i>
                    </div>
					<div class="input_box">
                        <input
                            type="text"
                            name="register_address"
                            placeholder="Ingresa tu dirección"
                            maxlength="100"
                            required value="<?php echo $data["register_address"]; ?>"
                        >
						<i class='bx bx-map direction'></i>
                    </div>
                    <div class="input_box">
                        <input
                            type="password"
                            name="register_password"
                            placeholder="Ingresa tu contraseña"
                            minlength="8"
                            pattern="(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}"
                            title="Debe contener al menos un número, un carácter especial [!@#$%^&*], una letra mayúscula, una letra minúscula y al menos 8 caracteres en total."
                            required
                            value="<?php echo $data["register_password"]; ?>">
                        <i class='bx bx-lock-alt password'></i>
						<i class="bx bx-show pw_hide"></i>
                    </div>
                    <div class="input_box">
                        <input
                            type="password"
                            name="register_confirm_password"
                            placeholder="Confirmar contraseña"
                            minlength="8"
                            pattern="(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z]).{8,}"
                            title="Debe contener al menos un número, un carácter especial [!@#$%^&*], una letra mayúscula, una letra minúscula y al menos 8 caracteres en total."
                            required
                            value="<?php echo $data["register_confirm_password"]; ?>">
                        <i class='bx bx-lock-alt password'></i>
						<i class="bx bx-show pw_hide"></i>
                    </div>
                    <div class="distinct_password">
                        <span>
                        <?php
                        if(isset($_SESSION["distinct_password"])){
                                echo '<script>document.addEventListener("DOMContentLoaded", function() {
                                        document.querySelector(".home").classList.add("show");
                                        document.querySelector(".login_form_container").classList.add("active");
                                        document.body.style.overflow = "hidden";
                                    });
                                </script>';

                            echo 'Las contraseñas no coinciden';
                            session_unset();
                            session_destroy();
                        }
                        ?>
                        </span>
                    </div>
                    <button class="button">Registrarme</button>
                    <div class="login_signup">¿Tienes una cuenta? <a href="#" id="login">Iniciar Sesión</a></div>
                </form>
            </div>
        </div>
    </section>