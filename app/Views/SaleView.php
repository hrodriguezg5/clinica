<?php require_once APP_ROUTE."/Views/Template/Header.php"; ?>
            <!-- Contenido de la Página Inicio -->
            <div id="content">
                <!-- Modal de Insertar Habitación Inicio -->
                <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="insertTitle">Agregar Habitación</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- <form id="insertForm" data-info=""> -->

                                    <div class="row">
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModName" class="form-label mb-0">Nombre</label>
                                            <input type="text" class="form-control" id="insModName" pattern="[0-9]{3}" placeholder="Ej: 001, 002" required>
                                        </div>
                                        <!-- <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModBranch" class="form-label mb-0">Sucursal</label>
                                            <select name="insModBranch" class="form-control form-select" id="insModBranch" required>
                                            </select>
                                        </div> -->
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModStatus" class="form-label mb-0">Estado</label>
                                            <select name="insModStatus" class="form-control form-select" id="insModStatus" required>
                                                <option value="1">Activo</option>
                                                <option value="0">Inactivo</option>
                                            </select>
                                        </div>
                                    </div>
                                <!-- </form> -->
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-primary" form="insertForm">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" >Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal de Insertar Habitación Fin -->


                <!-- Modal de Actualizar Habitación Inicio -->
                <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="updateTitle">Actualizar Empleado</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateForm" data-info="">

                                    <div class="row">
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModName" class="form-label mb-0">Nombre</label>
                                            <input type="text" class="form-control" id="updModName" pattern="[0-9]{3}" placeholder="Ej: 001, 002" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModBranch" class="form-label mb-0">Sucursal</label>
                                            <select name="updModBranch" class="form-control form-select" id="updModBranch" required>
                                            </select>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModStatus" class="form-label mb-0">Estado</label>
                                            <select name="updModStatus" class="form-control form-select" id="updModStatus" required>
                                                <option value="1">Activo</option>
                                                <option value="0">Inactivo</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-primary" form="updateForm">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal de Actualizar Habitación Fin -->
                
                
                <!-- Modal de Eliminar Habitación Inicio -->
                <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="deleteTitle">Eliminar Empleado</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="deleteForm">
                                    <div class="row">
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Nombre: </span><span id="delModName"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Sucursal: </span><span id="delModBranch"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Estado: </span><span id="delModStatus"></span>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-danger" form="deleteForm">Eliminar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal de Eliminar Habitación Fin -->

                <!-- Titulo del Módulo Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row">
                        <div id="iconClassTitle">
                            <div class="bg-transparent rounded d-flex align-items-center px-2">
                                <i id="moduleIcon"></i>
                                <h4 id="moduleTitle" class="mb-0"></h4>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Titulo del Módulo Fin -->


                <!-- Ventas Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Nueva Venta</h6>
                        </div>

                        <form id="addForm" data-info="" class="mb-3">
                            <div class="row justify-content-center justify-content-md-start">
                            <div class="mb-3 px-4 col-9 col-sm-5 col-md-3 col-lg-3 col-xl-3 col-xxl-2">
                                    <label for="addDate" class="form-label mb-0">Fecha:</label>
                                    <input type="date" class="form-control" id="addDate" required>
                                </div>
                                <div class="mb-3 px-4 col-9 col-sm-5 col-md-5 col-lg-5 col-xl-4 col-xxl-3">
                                    <label for="addCustomer" class="form-label mb-0">Cliente:</label>
                                    <input type="text" class="form-control" id="addCustomer" required>
                                </div>
                                <div class="mb-3 px-4 col-9 col-sm-5 col-md-3 col-lg-3 col-xl-3 col-xxl-2">
                                    <label for="addBranch" class="form-label mb-0">Sucursal:</label>
                                    <select name="addBranch" class="form-control form-select" id="addBranch" required>
                                    </select>
                                </div>
                                <div class="mb-3 px-4 col-9 col-sm-5 col-md-4 col-lg-4 col-xl-4 col-xxl-3">
                                    <label for="addMedicine" class="form-label mb-0">Medicina:</label>
                                    <select name="addMedicine" class="form-control form-select" id="addMedicine" required>
                                    </select>
                                </div>
                                <div class="mb-3 px-4 col-9 col-sm-5 col-md-3 col-lg-3 col-xl-2 col-xxl-2">
                                    <label for="addSalePrice" class="form-label mb-0">Precio:</label>
                                    <input type="text" class="form-control" id="addSalePrice" disabled>
                                </div>
                                <div class="mb-3 px-4 col-9 col-sm-5 col-md-3 col-lg-3 col-xl-2 col-xxl-2">
                                    <label for="addStock" class="form-label mb-0">Existencias:</label>
                                    <input type="text" class="form-control" id="addStock" disabled>
                                </div>
                                <div class="mb-3 px-4 col-9 col-sm-5 col-md-3 col-lg-3 col-xl-2 col-xxl-2">
                                    <label for="addQuantity" class="form-label mb-0">Cantidad:</label>
                                    <input type="number" class="form-control" id="addQuantity" step="1" min="1" required>
                                </div>
                            </div>
                            <div class="mt-4 text-center">
                                <button type="button" class="btn btn-primary" id="resetButton">
                                    <i class="bi bi-arrow-repeat me-1"></i>Nuevo
                                </button>
                                <button type="submit" class="btn btn-success" form="addForm">
                                    <i class="bi bi-file-earmark-plus me-1"></i>Agregar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- Ventas Fin -->


                <!-- Productos Ingresados Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Productos Registrados</h6>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-start table-bordered table-hover mb-0">
                                <thead id="tableHead">
                                    <tr class="text-dark align-middle">
                                        <th scope="col">Producto</th>
                                        <th scope="col">Cantidad</th>
                                        <th scope="col">Precio</th>
                                        <th scope="col">Total</th>
                                        <th scope="col">Acción</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody"></tbody>
                                <tfoot id="totalRow" style="display: none;">
                                    <tr>
                                        <td colspan="3" class="text-start"><strong>Total</strong></td>
                                        <td id="totalAmount">Q0.00</td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <button id="finalizeButton" class="btn btn-success mt-5" style="display: none;">Finalizar Venta</button>
                    </div>
                </div>
                <!-- Productos Ingresados Fin -->
            </div>
            <!-- Contenido de la Página Fin -->
<?php require_once APP_ROUTE."/Views/Template/Footer.php"; ?>