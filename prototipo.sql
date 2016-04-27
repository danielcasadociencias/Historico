-- Consulta para obtener un listado de movimientos para un trabajador
--
-- La consulta regresa tuplas con una cadena describiendo el
-- movimiento y la fecha en la que se realizó dicho cambio
create or replace function movimientos(v_id_trabajador int)
returns table (movimiento text , realizado_en date) as $$
with    
     hpt_artificial as(
                select *
                from historico_plaza_trabajador
                union
                (select * , current_date as fecha_fin
                from trabajador
                where id_trabajador = v_id_trabajador)            
             )    
     ,hpe_artificial as(
               select *
               from historico_plaza_estado
               union
               (select * , current_date as fecha_fin
               from plaza 
               where id_plaza = (select id_plaza
                              from trabajador
                              where id_trabajador = v_id_trabajador))            
              )    
     ,hpm_artificial as(
               select *
               from historico_plaza_media_plaza
               union
               (select * , current_date as fecha_fin
               from plaza_media_plaza 
               where id_plaza in (select id_plaza
                                from hpt_artificial
                                where id_trabajador = v_id_trabajador))            
             )    
    ,plazas as (
           select pt.id_plaza
             , case
                 when (pt.fecha_inicio = pe.fecha_inicio) then 'Ocupa la plaza ' || pt.id_plaza
                 else 'Plaza '|| pt.id_plaza || ' cambia de estado  a ' || pe.id_estado
               end as movimiento
             , pe.fecha_inicio
             , pe.fecha_fin
      from hpt_artificial pt
        join hpe_artificial pe
        on (pe.id_plaza = pt.id_plaza
            and (pe.fecha_inicio between pt.fecha_inicio and pt.fecha_fin))
       where id_trabajador = v_id_trabajador
             )
    , medias_altas as (
        select 'Plaza '|| plazas.id_plaza||' ocupa media plaza ' || id_media_plaza as movimiento
               , mp.fecha_inicio as realizado_en
        from plazas
          join hpm_artificial mp
          on (plazas.id_plaza = mp.id_plaza
              and (mp.fecha_inicio between plazas.fecha_inicio and plazas.fecha_fin))
              )
    , medias as (
        select ' media plaza ' || id_media_plaza as movimiento
               , hpt.fecha_inicio as realizado_en
        from hpt_artificial as hpt
          join hpm_artificial mp
          on (hpt.id_plaza = mp.id_plaza
              and (hpt.fecha_inicio between mp.fecha_inicio and mp.fecha_fin))
              )
    , medias_bajas as (
        select 'Baja media plaza ' || id_media_plaza as movimiento
               , mp.fecha_fin as realizado_en
        from hpt_artificial  as plazas
          join hpm_artificial mp
          on (plazas.id_plaza = mp.id_plaza
             and (mp.fecha_fin between plazas.fecha_inicio and plazas.fecha_fin)
             and mp.fecha_fin < plazas.fecha_fin)
             )
  select movimiento, fecha_inicio as realizado_en
  from plazas
  union
  select * from medias_bajas
  union
  select * from medias
  union
  select * from medias_altas
  order by realizado_en;
$$ language sql;

---------------------------------------------------
