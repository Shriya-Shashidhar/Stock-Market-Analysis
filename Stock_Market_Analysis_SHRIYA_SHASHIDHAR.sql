-- Creating a Schema named 'Assignment'
Create schema Assignment;

-- Using the 'Assignment' schema
Use Assignment;

-- All the csv files were imported using Table Data Import Wizard

/*	PART 1 : Create a new table named 'bajaj1' containing the date, close price, 
			 20 Day MA and 50 Day MA. (This has to be done for all 6 stocks)       */

-- CREATING TABLE BAJAJ1
-- Using MySQL function STR_TO_DATE to convert Date from text to Date format.

CREATE TABLE assignment.bajaj1 
SELECT str_to_date(Date, '%d-%M-%Y') as `Date`,`Close Price`,
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 19 PRECEDING) AS `20 Day MA`, #Calculating 20 day moving average
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 49 PRECEDING) AS `50 Day MA`  #Calculating 50 day moving average
FROM bajaj;

Select * from Bajaj1; #Displaying Bajaj1 Table 

-- CREATING EICHER1
CREATE TABLE assignment.eicher1 
SELECT str_to_date(Date, '%d-%M-%Y') as `Date`,`Close Price`,
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 19 PRECEDING) AS `20 Day MA`, #Calculating 20 day moving average
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 49 PRECEDING) AS `50 Day MA`  #Calculating 50 day moving average
FROM eicher;

Select * from Eicher1; #Displaying Eicher1 Table 

-- CREATING HERO1
CREATE TABLE assignment.hero1 
SELECT str_to_date(Date, '%d-%M-%Y') as `Date`,`Close Price`,
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 19 PRECEDING) AS `20 Day MA`, #Calculating 20 day moving average
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 49 PRECEDING) AS `50 Day MA`  #Calculating 50 day moving average
FROM hero;

Select * from hero1; #Displaying Hero1 Table

-- CREATING INFOSYS1
CREATE TABLE assignment.infosys1 
SELECT str_to_date(Date, '%d-%M-%Y') as `Date`,`Close Price`,
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 19 PRECEDING) AS `20 Day MA`, #Calculating 20 day moving average
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 49 PRECEDING) AS `50 Day MA`  #Calculating 50 day moving average
FROM infosys;

Select * from Infosys1; #Displaying Infosys1 Table

-- CREATING TCS1
CREATE TABLE assignment.tcs1 
SELECT str_to_date(Date, '%d-%M-%Y') as `Date`,`Close Price`,
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 19 PRECEDING) AS `20 Day MA`, #Calculating 20 day moving average
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 49 PRECEDING) AS `50 Day MA`  #Calculating 50 day moving average
FROM tcs;

Select * from Tcs1; #Displaying Tcs1 Table

-- CREATING TVS1
CREATE TABLE assignment.tvs1 
SELECT str_to_date(Date, '%d-%M-%Y') as `Date`,`Close Price`,
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 19 PRECEDING) AS `20 Day MA`, #Calculating 20 day moving average
		AVG(`Close Price`) OVER (ORDER BY STR_TO_DATE(Date, '%d-%M-%Y') ASC ROWS 49 PRECEDING) AS `50 Day MA`  #Calculating 50 day moving average
FROM tvs;

Select * from Tvs1; #Displaying Tvs1 Table

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- PART 2 : Create a master table containing the date and close price of all the six stocks.
             
-- Creating Master Table
CREATE TABLE assignment.MASTER_TABLE
SELECT b.date as Date, b.`Close Price` as Bajaj, 
t.`Close Price` as TCS, v.`Close Price` as TVS,
i.`Close Price` as Infosys, e.`Close Price` as Eicher,
h.`Close Price` as Hero
FROM bajaj1 as b
    INNER JOIN eicher1 as e ON b.Date = e.Date             #Using Inner join on 'Date' to create master table
    INNER JOIN hero1 as h ON e.Date  = h.Date
    INNER JOIN infosys1 as i ON h.Date = i.Date
    INNER JOIN tcs1 as t ON i.Date = t.Date
    INNER JOIN tvs1 as v ON t.Date = v.Date;
    
    select * from Master_Table; #Displaying Master Table
    
-- ------------------------------------------------------------------------------------------------------------------------------------------------

/*	 PART 3: Use the table created in Part(1) to generate buy and sell signal. 
			 Store this in another table named 'bajaj2'. Perform this operation for all stocks. */
             
-- CREATING BAJAJ2
CREATE TABLE Bajaj2
SELECT Date, `Close Price`,
CASE
	WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER W <= LAG(`50 Day MA`,1) OVER W THEN 'BUY'
    WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER W >= LAG(`50 Day MA`,1) OVER W THEN 'SELL'
    ELSE 'HOLD'
END AS `Signal`
FROM Bajaj1
WINDOW W AS (ORDER BY Date);

select * from bajaj2; #Displaying Bajaj2 table


-- CREATING EICHER2
CREATE TABLE eicher2
SELECT Date, `Close Price`,
CASE
	WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER W <= LAG(`50 Day MA`,1) OVER W THEN 'BUY'
    WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER W >= LAG(`50 Day MA`,1) OVER W THEN 'SELL'
    ELSE 'HOLD'
END AS `Signal`
FROM eicher1
WINDOW W AS (ORDER BY Date);

Select * from Eicher2; #Displaying Eicher2 table

-- CREATING HERO2
CREATE TABLE hero2
SELECT Date, `Close Price`,
CASE
	WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER W <= LAG(`50 Day MA`,1) OVER W THEN 'BUY'
    WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER W >= LAG(`50 Day MA`,1) OVER W THEN 'SELL'
    ELSE 'HOLD'
END AS `Signal`
FROM hero1
WINDOW W AS (ORDER BY Date);

Select * from hero2; #Displaying hero2 table

-- CREATING INFOSYS2
CREATE TABLE infosys2
SELECT Date, `Close Price`,
CASE
	WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER W <= LAG(`50 Day MA`,1) OVER W THEN 'BUY'
    WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER W >= LAG(`50 Day MA`,1) OVER W THEN 'SELL'
    ELSE 'HOLD'
END AS `Signal`
FROM infosys1
WINDOW W AS (ORDER BY Date);

Select * from infosys2; #Displaying infosys2 table

-- CREATING TCS2
CREATE TABLE tcs2
SELECT Date, `Close Price`,
CASE
	WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER W <= LAG(`50 Day MA`,1) OVER W THEN 'BUY'
    WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER W >= LAG(`50 Day MA`,1) OVER W THEN 'SELL'
    ELSE 'HOLD'
END AS `Signal`
FROM tcs1
WINDOW W AS (ORDER BY Date);

Select * from tcs2; #Displaying tcs2 table

-- CREATING TVS2
CREATE TABLE tvs2
SELECT Date, `Close Price`,
CASE
	WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`,1) OVER W <= LAG(`50 Day MA`,1) OVER W THEN 'BUY'
    WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`,1) OVER W >= LAG(`50 Day MA`,1) OVER W THEN 'SELL'
    ELSE 'HOLD'
END AS `Signal`
FROM tvs1
WINDOW W AS (ORDER BY Date);

Select * from tvs2; #Displaying tvs2 table

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- PART 4: CREATING A USER DEFINED FUNCTION TO TAKE DATE AS THE INPUT AND RETURN THE SIGNAL FOR THE PARTICULAR DAY. 

DELIMITER $$

CREATE FUNCTION signal_for_day(`input_date` text) RETURNS VARCHAR(10) 
    DETERMINISTIC
BEGIN
RETURN (select `Signal` from bajaj2  where `date`=`input_date`);
 END $$
