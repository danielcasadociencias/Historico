-- Consulta para obtener un listado de movimientos para un trabajador
--
-- La consulta regresa tuplas con una cadena describiendo el
-- movimiento y la fecha en la que se realizó dicho cambio
create or replace function movimientos(v_id_trabajador int)
returns table (movimiento text , realizado_en date) as $$
  with
    plazas as (
      select pt.id_plaza
             , case
                 when (pt.fecha_inicio = pe.fecha_inicio) then 'Alta de la plaza ' || pt.id_plaza
                 else 'Cambio de estado a ' || pe.id_estado
               end as movimiento
             , pe.fecha_inicio
             , pe.fecha_fin
      from historico_plaza_trabajador pt
        join historico_plaza_estado pe on (pe.id_plaza = pt.id_plaza)
      where id_trabajador = v_id_trabajador)
    , medias_altas as (
        select 'Alta media plaza ' || id_media_plaza as movimiento
               , mp.fecha_inicio as realizado_en
        from plazas
          join historico_plaza_media_plaza mp on (plazas.id_plaza = mp.id_media_plaza
                                                  and (mp.fecha_inicio between plazas.fecha_inicio and plazas.fecha_fin))
    )
    , medias_bajas as (
        select 'Baja media plaza ' || id_media_plaza as movimiento
               , mp.fecha_fin as realizado_en
        from plazas
          join historico_plaza_media_plaza mp on (plazas.id_plaza = mp.id_media_plaza
                                                  and (mp.fecha_inicio between plazas.fecha_inicio and plazas.fecha_fin))
    )
  select movimiento, fecha_inicio as realizado_en
  from plazas
  union
  select * from medias_bajas
  union
  select * from medias_altas
  order by realizado_en;
$$ language sql;
