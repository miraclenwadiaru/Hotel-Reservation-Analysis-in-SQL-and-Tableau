select *
from Hotels..hotel_bookings

-- Growth of revenue by year

select sum((hotel_bookings.stays_in_week_nights + hotel_bookings.stays_in_week_nights)*hotel_bookings.adr) as revenue,
hotel_bookings.arrival_date_year
from Hotels..hotel_bookings
where hotel_bookings.reservation_status not like 'canceled'
group by arrival_date_year
order by  arrival_date_year


--Is there growth in the revenue of the two hotels yearly

select sum((hotel_bookings.stays_in_week_nights + hotel_bookings.stays_in_week_nights)*hotel_bookings.adr) as revenue,
hotel_bookings.arrival_date_year, hotel
from Hotels..hotel_bookings
where hotel_bookings.reservation_status not like 'canceled'
group by arrival_date_year, hotel
order by  arrival_date_year


--Number of total people visiting each hotel

select sum(adults+children+babies) as visitors,arrival_date_year, arrival_date_month, hotel
from Hotels..hotel_bookings
where hotel_bookings.reservation_status not like 'canceled'
group by arrival_date_year, arrival_date_month, hotel

--Is there an increase in demand for parking spaces by the year

select sum(required_car_parking_spaces) as parking_space, arrival_date_year, hotel
from Hotels..hotel_bookings
where hotel_bookings.reservation_status not like 'canceled'
group by arrival_date_year, hotel


-- To identify the most popular room type

select reserved_room_type, count(*) AS reservations_count
from Hotels..hotel_bookings
group by reserved_room_type
order by reservations_count desc

--which distribution is mostly used

select distribution_channel, count(*) AS distribution_channel_count
from Hotels..hotel_bookings
where distribution_channel not like 'undefined'
group by distribution_channel
order by distribution_channel_count desc

--Average daily rate per room type

select assigned_room_type, AVG(adr) as avg_adr
from Hotels..hotel_bookings
group by assigned_room_type
order by avg_adr desc

--reservation status over time

SELECT
    arrival_date_month,
    reservation_status,
    count(*) as reservation_count
FROM Hotels..hotel_bookings
GROUP BY arrival_date_month, reservation_status
ORDER BY arrival_date_month, reservation_count desc

--Analyze cancellations
select reservation_status, count(*) as reservation_status_count, arrival_date_year
from Hotels..hotel_bookings
where reservation_status = 'Canceled'
group by reservation_status, arrival_date_year
order by arrival_date_year desc

--calculate total special request by customer type
select customer_type, sum(total_of_special_requests) as total_special_requests
from Hotels..hotel_bookings
group by customer_type