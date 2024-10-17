<?php require_once APP_ROUTE."/Views/Template/Header.php"; ?>
            <!-- Contenido de la Página Inicio -->
            <div id="content">
                <!-- Modal de Permisos Inicio -->
                <div class="modal fade" id="permissionRoleModal" tabindex="-1" aria-labelledby="permissionModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="permissionModalTitle"></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="permissionForm">
                                    <div class="px-3">
                                        <table class="table table-bordered text-center align-middle">
                                            <thead>
                                                <tr>
                                                    <th>Módulo</th>
                                                    <th>Ver</th>
                                                    <th>Crear</th>
                                                    <th>Actualizar</th>
                                                    <th>Eliminar</th>
                                                </tr>
                                            </thead>
                                            <tbody id="permmissionTableBody">
                                            </tbody>
                                        </table>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-primary" form="permissionForm">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal de Permisos Fin -->


                <!-- Modal de Actualizar Rol Inicio -->
                <div class="modal fade" id="updateRoleModal" tabindex="-1" aria-labelledby="updateRoleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="updateRoleTitle">Actualizar Rol</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="updateRoleForm" data-info="">

                                    <div class="row">
                                        <div class="mb-3 px-4">
                                            <label for="upModName" class="form-label mb-0">Nombre</label>
                                            <input type="upModName" class="form-control" id="upModName" maxlength="50" required>
                                        </div>
                                        <div class="mb-3 px-4">
                                            <label for="upModDescription" class="form-label mb-0">Descripción</label>
                                            <textarea class="form-control" id="upModDescription""></textarea>
                                        </div>
                                        <div class="mb-3 px-4">
                                            <label for="upModStatus" class="form-label mb-0">Estado</label>
                                            <select name="upModStatus" class="form-control" id="upModStatus" required>
                                                <option>Activo</option>
                                                <option>Inactivo</option>
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-primary" form="updateRoleForm">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal de Actualizar Rol Fin -->
                
                
                <!-- Modal de Eliminar Rol Inicio -->
                <div class="modal fade" id="deleteRoleModal" tabindex="-1" aria-labelledby="deleteRoleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title w-100 text-center" id="deleteRoleTitle">Eliminar Rol</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="deleteRoleForm">
                                    <div class="row">
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Nombre: </span><span id="delModName"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Descripción: </span><span id="delModDescription"></span>
                                        </div>
                                        <div class="mb-0 mb-sm-1 col-12">
                                            <span>Estado: </span><span id="delModStatus"></span>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer justify-content-center">
                                <button type="submit" class="btn btn-danger" form="deleteRoleForm">Eliminar</button>
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
                                <h4 id="moduleTitle" class="mb-0 ms-3"></h4>
                            </div>
                        </div>
                        <div id="buttonClassTitle" class="col-12 col-sm-7 d-flex align-items-center justify-content-start justify-content-sm-end">
                            <div class="bg-transparent rounded d-flex">
                                <div class="rounded pe-2">
                                    <input type="text" class="form-control" id="searchInput" placeholder="Buscar">
                                </div>
                                <div class="rounded ps-2">
                                    <button type="button" class="btn btn-sm btn-primary fw-bold">Agregar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Titulo del Módulo Fin -->

                <!-- Citas Realizadas Inicio -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Roles Registrados</h6>
                        </div>
                        <div class="table-responsive">
                            <table class="table text-start align-middle table-bordered table-hover mb-0">
                                <thead>
                                    <tr class="text-dark">
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Descripción</th>
                                        <th scope="col">Estado</th>
                                        <th scope="col">Acción</th>
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