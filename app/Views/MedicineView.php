<?php require_once APP_ROUTE."/Views/Template/Header.php"; ?>
            <!-- Contenido de la Página Inicio -->
            <div id="content">
                <!-- Modal de Insertar Rol Inicio -->
                <div class="modal fade" id="insertModal" tabindex="-1" aria-labelledby="insertModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="insertTitle">Agregar Medicina</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="insertForm" data-info="">

                                    <div class="row">
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModName" class="form-label mb-0">Nombre</label>
                                            <input type="text" class="form-control" id="insModName" maxlength="50" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModDescription" class="form-label mb-0">Descripción</label>
                                            <textarea class="form-control" id="insModDescription""></textarea>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModPurchasePrice" class="form-label mb-0">Precio Compra</label>
                                            <input type="number" class="form-control" id="insModPurchasePrice" step="0.01" min="0" maxlength="50" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModSellingPrice" class="form-label mb-0">Precio Venta</label>
                                            <input type="number" class="form-control" id="insModSellingPrice" step="0.01" min="0" maxlength="50" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModBrand" class="form-label mb-0">Marca</label>
                                            <input type="text" class="form-control" id="insModBrand" maxlength="50" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="insModStatus" class="form-label mb-0">Estado</label>
                                            <select name="insModStatus" class="form-control form-select" id="insModStatus" required>
                                                <option value="1">Activo</option>
                                                <option value="0">Inactivo</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-primary" form="insertForm">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal de Insertar Rol Fin -->


                <!-- Modal de Actualizar Rol Inicio -->
                <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="updateTitle">Actualizar Medicina</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateForm" data-info="">

                                    <div class="row">
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModName" class="form-label mb-0">Nombre</label>
                                            <input type="text" class="form-control" id="updModName" maxlength="50" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModDescription" class="form-label mb-0">Descripción</label>
                                            <textarea class="form-control" id="updModDescription""></textarea>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModPurchasePrice" class="form-label mb-0">Precio Compra</label>
                                            <input type="number" class="form-control" id="updModPurchasePrice" step="0.01" min="0" maxlength="50" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModSellingPrice" class="form-label mb-0">Precio Venta</label>
                                            <input type="number" class="form-control" id="updModSellingPrice" step="0.01" min="0" maxlength="50" required>
                                        </div>
                                        <div class="mb-2 mb-sm-3 px-4">
                                            <label for="updModBrand" class="form-label mb-0">Marca</label>
                                            <input type="text" class="form-control" id="updModBrand" maxlength="50" required>
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
                <!-- Modal de Actualizar Rol Fin -->
                
                
                <!-- Modal de Eliminar Rol Inicio -->
                <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="deleteTitle">Eliminar Medicina</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="deleteForm">
                                    <div class="row">
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Nombre: </span><span id="delModName"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Descripción: </span><span id="delModDescription"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Precio Compra: </span><span id="delModPurchasePrice"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Precio Venta: </span><span id="delModSellingPrice"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Marca: </span><span id="delModBrand"></span>
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
                <!-- Modal de Eliminar Rol Fin -->


                <!-- Titulo del Módulo Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row">
                        <div id="iconClassTitle" class="col-12 col-sm-5 mb-0">
                            <div class="bg-transparent rounded d-flex align-items-center px-2">
                                <i id="moduleIcon"></i>
                                <h4 id="moduleTitle" class="mb-0 ms-2"></h4>
                            </div>
                        </div>
                        <div id="buttonClassTitle" class="col-12 col-sm-7 d-flex align-items-center justify-content-start justify-content-sm-end">
                            <div class="bg-transparent rounded d-flex">
                                <div class="rounded">
                                    <input type="text" class="form-control" id="searchInput" placeholder="Buscar">
                                </div>
                                <div id="addButton"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Titulo del Módulo Fin -->

                <!-- Citas Realizadas Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Medicamentos Registrados</h6>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-start align-middle table-bordered table-hover mb-0">
                                <thead id="tableHead">
                                    <tr class="text-dark">
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Descripción</th>
                                        <th scope="col">Precio Compra</th>
                                        <th scope="col">Precio Venta</th>
                                        <th scope="col">Marca</th>
                                        <th scope="col">Estado</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- Citas Realizadas Fin -->
            </div>
            <!-- Contenido de la Página Fin -->
<?php require_once APP_ROUTE."/Views/Template/Footer.php"; ?>