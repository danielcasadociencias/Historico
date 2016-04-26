INSERT INTO plaza (id_plaza,id_estado,fecha_inicio)
    VALUES (1,4,'2016-04-29'),
            (2,1,'2016-04-29');
INSERT INTO trabajador (id_trabajador,id_plaza,fecha_inicio)
    VALUES (1,2,'2016-04-29');

INSERT INTO historico_plaza_estado (id_plaza,id_estado,fecha_inicio,fecha_fin)
    VALUES (1,1,'2015-12-31','2016-02-18'),
            (1,2,'2016-02-19','2016-03-19'),
            (1,3,'2016-03-20','2016-04-28');
            
INSERT INTO historico_plaza_media_plaza (id_plaza,id_media_plaza,fecha_inicio,fecha_fin)
    VALUES (1,1,'2016-01-10','2016-02-08'),
            (1,1,'2016-03-10','2016-04-08');
            
INSERT INTO historico_plaza_trabajador (id_plaza,id_trabajador,fecha_inicio,fecha_fin)
    VALUES (1,1,'2015-12-31','2016-04-28');
    
/*
    En la aplicacion, al consultar el historico detallado del trabajador 1, tendríamos que obtener lo siguiente:
    
    Ocupó la plaza 1 en el estado 1, sin media plaza en el 31-01-2015
    Ocupando la plaza 1, en el estado 1, se asoció a la media plaza 1 en el 10-01-2016
    Ocupando la plaza 1, en el estado 1, se desasoció de la media plaza 1 en el 09-02-2016
    Ocupando la plaza 1 cambió de estado al 2, sin media plaza en el 19-02-2016
    Ocupando la plaza 1, en el estado 2, se asoció a la media plaza 1 en el 10-03-2016
    Ocupando la plaza 1, cambió de estado al 3, con la media plaza 1 en el 20-03-2016
    Ocupando la plaza 1, en el estado 3, se desasoció de la media plaza 1 en el 09-04-2016
    Ocupó su plaza actual 2, en el estado X, con media plaza Y en el 29-04-2016
    
    Al consultar el historico detallado de la plaza 1, tendríamos que obtener:
    
    Inició el estado 1, sin media plaza, y fue ocupada por el trabajador 1 en el 31-12-2016
    En el estado 1, se asoció a la media plaza 1, ocupada por el trabajador 1 en el 10-01-2016
    En el estado 1, se desasoció de su media plaza, ocupada por el trabajador 1 en el 09-02-2016
    Cambió al estado 2, sin media plaza, ocupada por el trabajador 1 en el 19-02-2016
    En el estado 2, se asoció a la media plaza 1, ocupada por el trabajador 1 en el 10-03-2016
    Cambió al estado 3, con la media plaza 1, ocupada por el trabajador 1 en el 20-03-2016
    En el estado 3, se desasoció de su media plaza, ocupada por el trabajador 1 en el 09-04-2016
    Cambió a su estado actual 4, sin media plaza, ocupada por el trabajador 1 en el 29-04-2016
    
    Al consultar el historico detallado de la media plaza 1, tendríamos que obtener:
    (0 es vacante)

    Inició el estado 0, sin plaza entera y desocupada en el 31-12-2015 (Para esta fecha quizá necesitemos considerar la fecha_creacion de la media plaza)
    Cambió al estado 1, se asoció a la plaza 1 y fue ocupada por el trabajador 1 en el 10-01-2016
    Cambió al estado 0, se desasoció de su plaza entera y fue desocupada en el 09-02-2016
    Cambió al estado 2, se asoció a la plaza 1 y fue ocupada por el trabajador 1 en el 10-03-2016
    Cambió al estado 2, asociada a la plaza 1 y ocupada por el trabajador 1 en el 20-03-2016
    Cambió al estado 0, se desasoció de su plaza entera y fue desocupada en el 09-04-2016
    (Si se hubiera asociado a algo después y aún no se desasociara, se incluiría ese evento aquí)

*/