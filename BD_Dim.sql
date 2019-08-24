Create view DimStaff
as
select *from staff
go
create view DimRental
as
select *from rental
go
create view DimCustomer
as
select *from customer
go
create view DimDate
as
select distinct pmt.payment_date,
datepart(year, pmt.payment_date) as Año,
datepart(month, pmt.payment_date) as Mes,
datepart(day, pmt.payment_date) as Día,
datepart(QUARTER, pmt.payment_date) as Cuatrimenstre,
datename(month, pmt.payment_date) as NombreMes,
datename(weekday, pmt.payment_date) as NombreDía 
from payment pmt
go
create View FactPayment
as
Select 
pmt.customer_id,
pmt.rental_id,
pmt.staff_id,
pmt.payment_date,
sum(pmt.amount) as MontoTotal,
sum(fm.replacement_cost) as TotalCostoReemplazo,
sum(fm.[length]) as TotalDuracion,
sum(fm.rental_rate) as TotalTasaRenta,
sum(fm.rental_duration) as TotalDuracionRenta
from payment pmt
inner join rental rent
on rent.rental_id=pmt.rental_id
inner join inventory inv
on inv.inventory_id=rent.inventory_id
inner join film fm
on fm.film_id=inv.film_id
group by 
pmt.customer_id,
pmt.rental_id,
pmt.staff_id,
pmt.payment_date



/*Select distinct soh.OrderDate,
datepart(year, soh.OrderDate) as Año,
datepart(month, soh.OrderDate) as Mes,
datepart(day, soh.OrderDate) as Día,
datepart(QUARTER, soh.OrderDate) as Cuatrimenstre,
datename(month, soh.OrderDate) as NombreMes,
datename(weekday, soh.OrderDate) as NombreDía 
inner join inventory inv
on inv.inventory_id=ren.inventory_id*/


