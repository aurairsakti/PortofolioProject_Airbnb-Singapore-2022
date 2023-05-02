use PortfolioAirbnb1

--View datasets
select *
from PortfolioAirbnb1..listings

select *
from PortfolioAirbnb1..neighbourhood

select *
from PortfolioAirbnb1..reviews

--JOIN ALL DATASET
select *
from PortfolioAirbnb1..listings as pl
join PortfolioAirbnb1..neighbourhood as pn
on pl.neighbourhood = pn.neighbourhood

create view listing_neighbourhood as
select pl.id, pl.name, pl.host_id, pl.host_name, pl.neighbourhood, pn.neighbourhood_group, pl.room_type, pl.price, pl.minimum_nights, pl.availability_365, pl.latitude, pl.longitude
from PortfolioAirbnb1..listings as pl
join PortfolioAirbnb1..neighbourhood as pn
on pl.neighbourhood = pn.neighbourhood

select *
from listing_neighbourhood as ln
join PortfolioAirbnb1..reviews as pr
on ln.id = pr.listing_id

select ln.id, ln.name, ln.host_id, ln.host_name, ln.neighbourhood, ln.neighbourhood_group, ln.room_type, ln.price, ln.minimum_nights, ln.availability_365, ln.latitude, ln.longitude, pr.date
from listing_neighbourhood as ln
join PortfolioAirbnb1..reviews as pr
on ln.id = pr.listing_id

create view datasets_airbnb as
select ln.id, ln.name, ln.host_id, ln.host_name, ln.neighbourhood, ln.neighbourhood_group, ln.room_type, ln.price, ln.minimum_nights, ln.availability_365, ln.latitude, ln.longitude, pr.date
from listing_neighbourhood as ln
join PortfolioAirbnb1..reviews as pr
on ln.id = pr.listing_id

select *
from datasets_airbnb

--JUMLAH PROPERTY
--Mengetahui pemilik property terbanyak
select host_name, count(id) as number_of_room
from PortfolioAirbnb1..listings
group by host_name
order by number_of_room desc

--Mengetahui jumlah Room tertinggi dalam Neighbourhood_group
select pn.neighbourhood_group, pn.neighbourhood, count(pl.id) as Num_Of_Room
from PortfolioAirbnb1..listings as pl
join PortfolioAirbnb1..neighbourhood as pn
on pl.neighbourhood = pn.neighbourhood
group by pn.neighbourhood_group, pn.neighbourhood
order by pn.neighbourhood_group desc

--Mengetahui jumlah Room tiap neighbourhood_group
select pn.neighbourhood_group, count(pl.id) as Num_Of_Room
from PortfolioAirbnb1..listings as pl
join PortfolioAirbnb1..neighbourhood as pn
on pl.neighbourhood = pn.neighbourhood
group by pn.neighbourhood_group
order by Num_Of_Room desc


--HARGA
--Harga tertinggi listing di singapore
select id, name, neighbourhood, price
from PortfolioAirbnb1..listings
order by price desc

--Mengetahui rata-rata harga seluruh listing
select avg(price) as Harga_Rata2, 
from PortfolioAirbnb1..listings


--Mengetahui Rata-Rata harga tertinggi dalam Neighbourhood
select neighbourhood, count(id) as Jumlah_Room, avg(price) as Avg_Price
from PortfolioAirbnb1..listings
group by neighbourhood
order by Avg_Price desc

--Mengetahui pengaruh room_type pada harga
select name, neighbourhood, room_type, price
from PortfolioAirbnb1..listings
order by price desc


--Harga pada neighbourhood
select neighbourhood, price, count(id) as Jumlah_Room
from dataset_airbnb
group by neighbourhood, price
order by neighbourhood

--Harga pada room type
select room_type, price, count(id) as Jumlah_Room
from dataset_airbnb
group by room_type, price
order by room_type


--TREND JUMLAH LISTING
--Trend penyewaan secara tanggal 01-01-2018 sampai dengan 22-09-2022
select pr.date, count(listing_id) as banyak_sewa
from PortfolioAirbnb1..listings as pl
join PortfolioAirbnb1..reviews as pr
on pl.id = pr.listing_id
group by pr.date
order by pr.date 

--Penyewaan harian
select date, count(date) as jumlah
from datasets_airbnb
group by date
order by date

--Mencari nilai MAX, MIN, MEDIAN, AVG
select max(price) as nilai_MAX, min(price) as nilai_MIN, (max(price)+min(price))/2 as nilai_tengah, avg(price) as rata_rata
from datasets_airbnb


--Mencari pemilik listing terbanyak
select host_id, host_name, count(id) as jumlah_property
from datasets_airbnb
group by host_id, host_name
order by jumlah_property desc


--Listing per date
select date, count(date) as jumlah_review
from datasets_airbnb
group by date
order by date desc

--ID Name terbanyak review
select id, name, price, neighbourhood, neighbourhood_group, count(date) as review
from datasets_airbnb
group by id, name, price, neighbourhood, neighbourhood_group
order by review desc


--Rata-rata harga listing per neighbourhood group
select neighbourhood_group, avg(price) as Rata_Rata_Harga
from datasets_airbnb
group by neighbourhood_group


--Pengaruh room type pada jumlah review
select room_type, count(date) as jumlah_review
from datasets_airbnb
group by room_type

--Aktivitas penyewaan di neighbourhood
--Harga listing termahalnya
select neighbourhood, count(date) as jumlah_review, max(price) as harga_listing_termahal
from datasets_airbnb
group by neighbourhood
order by jumlah_review desc

--Region mana yang memiliki aktivitas tertinggi (number of reviews) ? Bagaimana
--hubungannya dengan number of listing tiap region?
select neighbourhood_group, count(date) as jumlah_review, count(Distinct id) as jumlah_listing
from datasets_airbnb
group by neighbourhood_group
order by jumlah_review desc


select neighbourhood_group, neighbourhood, count(date) as jumlah_review, max(price) as harga_listing_termahal
from datasets_airbnb
group by neighbourhood_group, neighbourhood
order by jumlah_review desc


--Rentang harga north region - woodlands
select id, neighbourhood, price
from dataset_airbnb
where neighbourhood = 'Woodlands'
group by id, neighbourhood, price
order by price

--revenue
select date, sum(price) as rev
from datasets_airbnb
group by date
order by date