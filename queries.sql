-- Consultas do desafio de SQL

-- 1. Escreva uma consulta MySQL para calcular o preço médio do m² dos imóveis com aumento de preço em 2016 que tenham uma área do metro quadrado > 200 (área construída ou usada).
use desafio_atlantico;
select * from price_changes;
select * from built_used_area;

select cast(avg((pc.new_price/bua.built_area)) as decimal(10,2)) as Preço_médio_do_m²_dos_imóveis_com_aumento_em_2016_que_tem_área_maior_que_200m²
from price_changes pc
inner join built_used_area bua
on (pc.listing_id = bua.listing_id)
where pc.new_price > pc.old_price and bua.built_area > 200 and pc.change_date between '2016-01-01' and '2016-12-31';

-- Contar o número de imóveis que tiveram aumento de preço em 2016 e o aumento médio do percentual de preço/m² desses imóveis;
use desafio_atlantico;

select
count(pc.listing_id) as Número_de_imóveis_com_aumento_de_preço_em_2016,
cast(avg((((pc.new_price-pc.old_price)/pc.old_price)/bua.built_area)*100) as decimal(10,2)) as Percentual_médio_de_aumento_de_preço_por_m²_desses_imóveis
from price_changes pc
inner join built_used_area bua
on (pc.listing_id = bua.listing_id)
where pc.new_price > pc.old_price and pc.change_date between '2016-01-01' and '2016-12-31';

-- ********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************

-- Contar o número de imóveis que tiveram um decréscimo de preço em 2016 e a diminuição média da porcentagem de preço/m2 desses imóveis;
use desafio_atlantico;

select
count(pc.listing_id) as Número_de_imóveis_com_redução_de_preço_em_2016,
cast(avg((((pc.old_price-pc.new_price)/pc.old_price)/bua.built_area)*100) as decimal(10,2)) as Percentual_médio_de_redução_de_preço_por_m²_desses_imóveis
from price_changes pc
inner join built_used_area bua
on (pc.listing_id = bua.listing_id)
where pc.new_price < pc.old_price and pc.change_date between '2016-01-01' and '2016-12-31';
