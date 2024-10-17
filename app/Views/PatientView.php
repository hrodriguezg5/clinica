<?php require_once APP_ROUTE."/Views/Template/Header.php"; ?>
            <!-- Contenido de la Página Inicio -->
            <div id="content">
                <!-- Modal de Actualizar Reservaciòn -->
                <div class="modal fade" id="updateReservationModal" tabindex="-1" aria-labelledby="updateReservationModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="updateReservationModalLabel">Actualizar Paciente</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateReservationForm">
                                    <input type="hidden" id="upModReservationId">

                                    <div class="row">
                                        <div class="mb-1 mb-sm-3 col-6">
                                            <label for="upModFirstName" class="form-label mb-0 mb-sm-1">Nombre</label>
                                            <input type="text" class="form-control" id="upModFirstName" maxlength="50" required>
                                        </div>
                                        <div class="mb-1 mb-sm-3 col-6">
                                            <label for="upModLastName" class="form-label mb-0 mb-sm-1">Apellido</label>
                                            <input type="text" class="form-control" id="upModLastName" maxlength="50" required>
                                        </div>
                                        <div class="mb-1 mb-sm-3 col-6">
                                            <label for="upModEmail" class="form-label mb-0 mb-sm-1">Correo</label>
                                            <input type="email" class="form-control" id="upModEmail" maxlength="100" required>
                                        </div>
                                        <div class="mb-1 mb-sm-3 col-6">
                                            <label for="upModPhoneNumber" class="form-label mb-0 mb-sm-1">Teléfono</label>
                                            <input type="tel" class="form-control" id="upModPhoneNumber" pattern="[0-9]{8}" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 col-6">
                                            <label for="upModProduct" class="form-label mb-0 mb-sm-1">Dispositivo</label>
                                            <select name="upModProduct" class="form-control" id="upModProduct" required>
                                            </select>
                                        </div>
                                        <div class="mb-2 mb-sm-3 col-6">
                                            <label for="upModProductQuantity" class="form-label mb-0 mb-sm-1">Cantidad</label>
                                            <select name="upModProductQuantity" class="form-control" id="upModProductQuantity" required>
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>
                                        <div class="mb-2 mb-sm-3 col-12">
                                            <label for="upModAddress" class="form-label mb-0 mb-sm-1">Dirección</label>
                                            <input type="text" class="form-control" id="upModAddress" maxlength="100" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 col-6">
                                            <label for="upModDate" class="form-label mb-0 mb-sm-1">Fecha</label>
                                            <input type="date" class="form-control" id="upModDate" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 col-6">
                                            <label for="upModHour" class="form-label mb-0 mb-sm-1">Hora</label>
                                            <select name="update_hour" class="form-control" id="upModHour" required>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-primary" form="updateReservationForm">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                
                <!-- Modal de Eliminar Reservaciòn -->
                <div class="modal fade" id="deleteReservationModal" tabindex="-1" aria-labelledby="deleteReservationModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="deleteReservationModalLabel">Eliminar Paciente</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="deleteReservationForm">
                                    <input type="hidden" id="delModReservationId">
                                    <div class="row">
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Nombre: </span><span id="delModFirstName"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Apellido: </span><span id="delModLastName"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Correo: </span><span id="delModEmail"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Teléfono: </span><span id="delModPhoneNumber"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Dirección: </span><span id="delModAddress"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Dispositivo: </span><span id="delModProduct"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Cantidad: </span><span id="delModProductQuantity"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Hora: </span><span id="delModHour"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Fecha: </span><span id="delModDate"></span>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-danger" form="deleteReservationForm">Eliminar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- Titulo del Módulo Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row">
                        <div class="col-6">
                            <div class="bg-transparent rounded d-flex align-items-center px-4">
                                <i id="moduleIcon"></i>
                                <h4 id="moduleTitle" class="mb-0 ms-3"></h4>
                            </div>
                        </div>
                        <div class="col-6">
                            <div id="buttonAdd" class="rounded d-flex justify-content-end">
                                <button type="button" class="btn btn-primary">
                                    <i class="bi bi-plus-circle me-1"></i>Agregar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Titulo del Módulo Fin -->


                <!-- Citas Realizadas Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Pacientes Registrados</h6>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-start align-middle table-bordered table-hover mb-0" id="dataTable">
                                <thead>
                                    <tr class="text-dark">
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Correo</th>
                                        <th scope="col">Teléfono</th>
                                        <th scope="col">Dirección</th>
                                        <th scope="col">Producto</th>
                                        <th scope="col">Cantidad</th>
                                        <th scope="col">Hora</th>
                                        <th scope="col">Fecha</th>
                                        <th scope="col">Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- Citas Realizadas Fin -->
            </div>
            <!-- Contenido de la Página Fin -->
<?php require_once APP_ROUTE."/Views/Template/Footer.php"; ?>