# Historico

------------- Resumen del Modelo -------------

El sistema guarda históricos de los siguientes periodos de tiempo:

- Una plaza se encontraba en cierto estado
- Un trabajador estaba ocupando una plaza
- Una plaza estaba asociada a una media plaza

Los periodos del estado de las plazas y qué trabajador ocupaba qué plaza, son continuos. Es decir, que si una plaza acabó un estadoen la fecha A, empezó su estado siguiente en la fecha A+1. Igual con el trabajador ocupando una plaza.

Por lo tanto una plaza siempre tiene un estado y un trabajador siempre ocupa una plaza.

Por otra parte, una plaza o media plaza no siempre está asociada a una media plaza o plaza entera, respectivamente

El "estado" de una media plaza es igual al estado en el que se encuentra la plaza entera a la que está asociada. Si no está asociada a ninguna, se encuntra Vacante.

Cuando un trabajador ocupa o desocupa una plaza, esta cambia de estado (ocupada->vacante, vacante->ocupada por ejemplo)

------------- Problema -------------

Nos interesa poder obtener historicos detallados de cada plaza, media plaza y trabajador individualmente:

Para un cierto trabajador nos interesa saber cuándo empezó a ocupar cada plaza que haya ocupado a lo largo de su tiempo en el sistema y qué plaza empezó a ocupar. Para cada plaza que ocupó, si la plaza cambió de estado mientras el trabajador la estaba ocupando, también nos interesa saber cuándo cambió de estado y qué estado era. De igual manera, si una plaza se empezó o terminó su asociación con alguna media plaza mientras estaba ocupada por este trabajador, nos interesa saber estas fechas y a qué media plaza estaba asociada.

Para una cierta plaza nos interesa saber todos los estados por los cuales ha pasado a lo largo de su tiempo en el sistema y cuándo los empezó a tener. Para cada media plaza con la que la plaza entera se ha asociado, nos interesa saber qué media plaza fue, cuándo empezó esa asociación y cuando terminó (si es que ya terminó). También nos interesan las fechas de cada vez que ocuparon o desocuparon la plaza y quién fue quien la ocupó.

Para una cierta media plaza nos interesa saber todas las plazas enteras a las cuales estuvo asociada, cuándo empezó esa asociación y cuándo terminó (si es que ya terminó). Para cada plaza entera con la media plaza se ha asociado, si la plaza cambió de estado mientras estaba asociada a la media plaza, nos interesa a qué estado cambió y cuándo. De igual manera, si la plaza entera se ocupó o desocupó mientras la media estaba asociada a ella, nos interesa saber quién la ocupó y cuándo 

Para lograr esto, es necesario combinar los tres históricos mencionados anteriormente para poder sacar las fechas compuestas por varios intervalos intersectados: por ejemplo

edo_plaza: >|----------------||----------------||----------------|>
m_plaza:         >|-----|                |-----------|>

detalle:   >|----||-----||---||---------||-----||----||----------|>

------------- Implementación actual -------------

La solución que está implementada en este momento en producción está manejada en PHP.

La función recibe el número de plaza, media plaza o trabajador del que se necesita el historico detallado. Se buscan los historicos pertenecientes a ese número.

Se extraen las fechas a los historicos que nos interesan (por ejemplo, si estamos viendo el histórico detallado de un trabajador, solo nos interesan las fechas de los cambios de estado de las plazas que ocupó MIENTRAS las haya ocupado) y se insertan a un arreglo. Este arreglo luego se ordena

Después se recorre el arreglo y se extraen los intervalos entre cada una de las fechas. O sea se extraen los intervalos de los historicos combinados (vease la ilustración). Esos intervalos se guardan en otro arreglo

Se recorre el arreglo de intervalos y se busca en los historicos que obtuvimos de la base (búsqueda líneal) qué había pasado durante ese intervalo (qué plaza ocupaba el trabajador, qué estado tenía, qué media plaza estaba relacionada)

Se adjunta esa información a los intervalos y se regresa para que se despliegue en la vista.

Esta solución es correcta en base a las pruebas que hemos hecho. No es muy eficiente y seguramente una solución en el modelo relacional sea más eficiente.