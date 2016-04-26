INSERT INTO plaza (id_plaza,id_estado,fecha_inicio)
    VALUES (1,1,'2016-04-19'),
            (2,3,'2016-03-10');
INSERT INTO plaza_media_plaza (id_plaza,id_media_plaza,fecha_inicio)
    VALUES (1,1,'2016-03-30');
    
INSERT INTO trabajador (id_trabajador,id_plaza,fecha_inicio)
    VALUES (1,1,'2016-03-10');

INSERT INTO historico_plaza_estado (id_plaza,id_estado,fecha_inicio,fecha_fin)
    VALUES (1,1,'2015-12-31','2016-01-29'),
            (1,2,'2016-01-30','2016-02-08'),
            (1,1,'2016-02-09','2016-02-28'),
            (1,2,'2016-02-29','2016-03-09'),
            (1,3,'2016-03-10','2016-04-08'),
            (1,4,'2016-04-09','2016-04-18'),
            (2,2,'2015-12-31','2016-01-29'),
            (2,1,'2016-01-30','2016-03-09');
            
INSERT INTO historico_plaza_media_plaza (id_plaza,id_media_plaza,fecha_inicio,fecha_fin)
    VALUES (1,1,'2016-01-10','2016-02-08'),
            (1,2,'2016-02-19','2016-03-29');
            
INSERT INTO historico_plaza_trabajador (id_plaza,id_trabajador,fecha_inicio,fecha_fin)
    VALUES (1,1,'2015-12-31','2016-01-29'),
            (2,1,'2016-01-30','2016-03-09');
/*
    Al realizar la vista conjunta, se desea que tenga las siguientes tuplas:
    (vacante es 0) ordenada for fecha_inicio, fecha_fin
    plaza | estado | media_plaza | trabajador | fecha_inicio | fecha_fin
      1       1         null           1        2015-12-31     2016-01-09
    null      0           1          null       2015-12-31     2016-01-09
      2       2         null         null       2015-12-31     2016-01-29
    null      0           2          null       2015-12-31     2016-02-18
      1       1           1            1        2016-01-10     2016-01-29
      1       2           1          null       2016-01-30     2016-02-08
      2       1         null           1        2016-01-30     2016-03-09
      1       1         null         null       2016-02-09     2016-02-18
    null      0           1          null       2016-02-09     2016-03-29
      1       1           2          null       2016-02-19     2016-02-28
      1       2           2          null       2016-02-29     2016-03-09
      1       3           2            1        2016-03-10     2016-03-29
      1       3           1            1        2016-03-30     2016-04-08
      1       4           1            1        2016-04-09     2016-04-18

*/