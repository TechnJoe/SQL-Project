--  MOVIE STORE ACQUISITION INFORMATION REQUESTS

-- Question 1
/*My partner and I want to come by each of the stores in person and
 meet the managers. Please send over the managers’ names at each store,
 with the full address of each property (street address, district, city, and country please).
 */
-- select * from store;
-- select * from staff;
-- select * from address;
-- select * from city;
-- select * from country; 
 
/*SELECT 
    store.manager_staff_id,
    store.store_id,
    address.address,
    address.district,
    city.city,
    country.country,
    staff.first_name,
    staff.last_name
FROM
    staff
        INNER JOIN
    store ON staff.store_id = store.store_id
        AND staff.staff_id = store.manager_staff_id
        INNER JOIN
    address ON staff.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
        INNER JOIN
    country ON city.country_id = country.country_id
 */
 
-- Question 2 
/*I would like to get a better understanding of all of the inventory
 that would come along with the business. Please pull together a list of each 
 inventory item you have stocked, including the store_idnumber, the inventory_id,
 the name of the film, the film’s rating, its rental rate and replacement cost. */
 
 -- select *from inventory;
 -- select *from film;
 /*
 select inventory.inventory_id, inventory.store_id, film.title, film.rental_rate, film.replacement_cost,film.rating
 from film
 join inventory
 on film.film_id = inventory.film_id*/


 -- Question 3
 /*From the same list of films you just pulled, please roll that data up and provide a
 summary level overview of your inventory. We would like to know how many inventory 
 items you have with each rating at each store*/

-- select *from inventory;
-- select *from film;
-- select *from store;

/*
SELECT 
    COUNT(inventory_id) AS inventory_count,
    film.rating,
    inventory.store_id
FROM
    film
     inner JOIN
    inventory ON film.film_id = inventory.film_id
GROUP BY rating, store_id
*/
 
  
 -- Question 4
 /*Similarly, we want to understand how diversified the inventory is in terms
 of replacement cost. We want to see how big of a hit it would be if a certain
 category of film became unpopular at a certain store.We would like to see the number of
 films, as well as the average replacement cost, and total replacement cost, 
 sliced by store and film category.
 */
-- select *from film
-- select *from film_category
-- select *from category
-- select *from store
-- select *from inventory

/*
Select inventory.store_id, category.name AS 'Category Name', 
count(film.film_id) AS 'Number of Films',
Round(Avg(film.replacement_cost), 2) AS 'Average Replacement Cost',
Sum(film.replacement_cost) AS 'Total replacement Cost'
FROM film
inner join inventory on inventory.film_id = film.film_id
inner join film_category on film_category.category_id = inventory.film_id
inner join category on category.category_id = film_category.category_id
group by inventory.store_id, category.name
order by category.name asc
*/

-- Question 5
/* We want to make sure you folks have a good handle on who your
 customers are. Please provide a list of all customer names, which store they go to,
 whether or not they are currently active,  and their full addresses –street address, city, and country.
 */
 
 -- select * from customer
 -- select * from address;
 -- select * from city;
 -- select * from country
 -- select * from store
 
 /*
SELECT 
     customer.first_name,
    customer.last_name,
    CONCAT(customer.first_name,
            ' ',
            customer.last_name) AS 'Customer Name',
    customer.store_id,
    address.address,
    city.city,
    country.country,
    CASE
        WHEN customer.active = 1 THEN 'active'
        ELSE 'Inactive'
    END AS 'Customer Status'
FROM
    customer
        INNER JOIN
    address ON customer.address_id = address.address_id
        INNER JOIN
    city ON city.city_id = address.city_id
        INNER JOIN
    country ON country.country_id = city.country_id
ORDER BY customer.active;
*/
 
 
 -- Question 6
 /*We would like to understand how much your customers are spending with you,
 and also to know who your most valuable customers are. Please pull together a list of customer names,
 their total lifetime rentals, and the sum of all payments you have collected from them.
 It would be great to see this ordered on total lifetime value, with the most valuable customers at the top of the list.
 */
  
 -- select *from customer;
 -- select *from payment,
 -- select * from rental
 /* 
  SELECT 
    -- customer.first_name,
    -- customer.last_name,
    CONCAT(customer.first_name,        -- (after concactinating, I removed the 2 customer name columns for presentation) 
            ' ',
            customer.last_name) AS 'Customer Name',
    COUNT(rental.rental_id) AS 'Total Rentals to-date',
    SUM(payment.amount) AS 'Total Payments to-date'
FROM
    customer
        INNER JOIN
    rental ON customer.customer_id = rental.customer_id
        INNER JOIN
    payment ON rental.rental_id = payment.rental_id
GROUP BY customer.first_name , customer.last_name
ORDER BY SUM(payment.amount) DESC 
*/
--  I ordered by payment amount coz I figured that valuable customer is he who spends most money
 -- in the store as this is what accounts to profitability versus most renting customers who
 -- might be mostly renting cheap movies. I would ask for more specificity on this request who they consider valuable. 
            
 
 
 -- Question 7
 /*My partner and I would like to get to know your board of advisors and any current investors.
 Could you please provide a list of advisor and investor names in one table? Could you please 
 note whether they are an investor or an advisor, and for the investors, it would be good to include which 
 company they work with*/
 -- the 2 tables cannot be joined but since the same number of columns, I used union.
 
 -- select * from advisor;
 -- select * from investor
/*
 SELECT 
    -- advisor.first_name,
     -- advisor.last_name,
    CONCAT(advisor.first_name,
            '  ',
            advisor.last_name) AS 'Full Name',
    'Advisor' AS 'Position',   -- CREATED PLACEHOLDER COLUMN CALLED POSITION
    'Not Applicable' AS Company
FROM
    advisor 
UNION SELECT 
    -- investor.first_name,
    -- investor.last_name,
    CONCAT(investor.first_name,
            '  ',
            investor.last_name) AS 'Full Name',
    'Investor',
    company_name
FROM
    investor
    */
 
 
 --  Question 8
 /*We're interested in how well you have covered the most-awarded actors.
 Of all the actors with three types of awards, for what % of them do we carry a film?
 And how about for actors with two types of awards? Same questions. Finally, how about actors with just one award? */
 
 
-- select * from actor_award; -- blank "actor id" means that the stores dont carry a film for that actor/actress.
--  select * from actor;
 -- select * from inventory;
 -- select * from actor;
 -- select * from actor;
 -- select * from film_actor;
 -- use case statement to create a new column that will help identify actors with X number of awards.as
 -- count of actor id / count of actor award id  for percentage
 
 /*
 SELECT  
        CASE
        WHEN awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN awards IN ('Emmy, Oscar' , 'Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
        WHEN awards IN ('Emmy' , 'Oscar', 'Tony') THEN '1 award'
    END AS 'awards won',
     round((count(actor_id) / count(actor_award_id))*100, 2) AS '% of actors we carry'
FROM
    actor_award
    group by
    case
        WHEN awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
        WHEN awards IN ('Emmy, Oscar' , 'Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
        WHEN awards IN ('Emmy' , 'Oscar', 'Tony') THEN '1 award'
	    end;
select count(actor_award_id) AS 'total actors with award',
       count(actor_id) AS 'total actors we carry'
       from actor_award
       end
   */    