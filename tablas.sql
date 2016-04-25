/*
    Tabla con información actual de las plazas.
    Guarda el estado que tienen actualmente cada
    plaza y desde cuándo comenzaron con este estado
*/
CREATE TABLE plaza (
    id_plaza integer PRIMARY KEY,
    id_estado integer NOT NULL,
    fecha_inicio date NOT NULL
);
/*
    Tabla con información actual de la relacion
    entre una plaza regular y una media plaza
    Guarda la fecha cuando iniciaron las plazas
    a estar relacionadas
*/
CREATE TABLE plaza_media_plaza (,
    id_plaza integer NOT NULL REFERENCES plaza ON id_plaza,
    id_media_plaza integer NOT NULL,
    fecha_inicio date NOT NULL
);
/*
    Tabla con información actual de los trabajadores.
    Guarda la plaza que ocupa actualmente el trabajador
    y la fecha desde cuándo empezó a ocupar esa plaza
*/
CREATE TABLE trabajador (
    id_trabajador integer PRIMARY KEY,
    id_plaza integer NOT NULL REFERENCES plaza ON id_plaza,
    fecha_inicio date NOT NULL
);
/*
    Histórico de los estados de las plazas.
    Describe qué plaza estaba en qué estado
    en qué periodo de tiempo
    
    Los periodos de tiempo son "continuos" para la misma plaza.
    Si una plaza empezó un estado en la fecha A y acabó en la 
    fecha B, el siguiente estado empezó en la fecha B+1 y así...
*/
CREATE TABLE historico_plaza_estado (
    id_plaza integer NOT NULL REFERENCES plaza ON id_plaza,
    id_estado integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL
);

/*
    Histórico de las asociaciones entre plaza y media plaza
    Describe qué plaza estaba asociada a qué media plaza
    en qué periodo de tiempo
    
    Estos periodos no necesariamente son continuos 
    para la misma plaza o media plaza, ya que ambas
    pueden existir fuera de una asociación por un
    periodo de tiempo
*/
CREATE TABLE historico_plaza_media_plaza (
    id_plaza integer NOT NULL REFERENCES plaza ON id_plaza,
    id_media_plaza integer NOT NULL REFERENCES media_plaza ON id_media_plaza,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL
);

/*
    Histórico de las plazas que ocupan los trabajadores.
    Describe qué trabajador ocupaba qué plaza
    en qué periodo de tiempo
    
    Los periodos de tiempo son "continuos" para el mismo trabajador.
    Si un trabajador empezó a ocupar una plaza en la fecha A y acabó en la 
    fecha B, el empezó a ocupar la siguiente plaza en la fecha B+1 y así...
    
    Los periodos no son continuos para la misma plaza, ya que 
    una plaza puede estar vacante por un periodo de tiempo
*/
CREATE TABLE historico_plaza_trabajador (
    id_plaza integer NOT NULL REFERENCES plaza ON id_plaza,
    id_trabajador integer NOT NULL REFERENCES trabajador ON id_trabajador,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL
);