	<section class="reservation" id="reservation">
        <div class="reservation_title">
            <h1>Agendar Cita</h1>
        </div>

		<div class="reservation_form_container">
			<form  action="<?php echo URL_ROUTE; ?>/inicio/agendar" method="POST" class="reservation_form">
				<div class="reservation_form_column">
					<div class="reservation_form_input_box">
						<label>Nombre</label>
						<input type="text" name="reservation_first_name" placeholder="Ingresa tu nombre" maxlength="50" required>
					</div>

					<div class="reservation_form_input_box">
						<label>Apellido</label>
						<input type="text" name="reservation_last_name" placeholder="Ingresa tu apellido" maxlength="50" required>
					</div>
				</div>
					
				<div class="reservation_form_column">
					<div class="reservation_form_input_box">
						<label>Correo Electrónico</label>
						<input type="email" name="reservation_email" placeholder="Ingresa tu correo electrónico" maxlength="100" required>
					</div>

					<div class="reservation_form_input_box">
						<label>Número de Teléfono</label>
						<input type="number" name="reservation_phone_number" placeholder="Ingresa tu número de teléfono" min="00000000" max="99999999" required>
					</div>
				</div>
				<div class="reservation_form_column">
					<div class="reservation_form_input_box">
						<label>Dispositivo</label>
						<div class="reservation_form_select_box">
							<select name="reservation_product" required>
								<option value="" hidden>Escoge el dispositivo a adquirir</option>
								<option>GPS3G</option>
								<option>GPS4G</option>
								<option>GPS4G Motocicleta</option>
							</select>
						</div>
					</div>

					<div class="reservation_form_input_box">
						<label>Cantidad</label>
						<div class="reservation_form_select_box">
							<select id="reservation_product_quantity" name="reservation_product_quantity" required>
								<option hidden value="">Escoge la cantidad de dispositivos</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
							</select>
						</div>
					</div>
				</div>

				<div class="reservation_form_input_box">
					<label>Dirección</label>
					<input type="text" name="reservation_address" placeholder="Ingresa la dirección de instalación" maxlength="100" required>
				</div>

				<div class="reservation_form_column">
					<div class="reservation_form_input_box">
						<label>Fecha a Reservar</label>
						<input type="date" id="reservation_date" name="reservation_date" min="<?= date("Y-m-d");?>" required>
					</div>

					<div class="reservation_form_input_box">
						<label>Hora</label>
						<div class="reservation_form_select_box">
							<select id="reservation_hour" name="reservation_hour" required>
								<option hidden value="">Escoge la hora de la cita</option>
							</select>
						</div>
					</div>
				</div>

				<div class="reservation_form_button">
					<button type="submit">Enviar</button>
				</div>
			</form>
		</div>	
	</section>