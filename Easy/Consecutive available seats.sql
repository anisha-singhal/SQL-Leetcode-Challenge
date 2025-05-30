-- Question 37
-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
-- | seat_id | free |
-- |---------|------|
-- | 1       | 1    |
-- | 2       | 0    |
-- | 3       | 1    |
-- | 4       | 1    |
-- | 5       | 1    |
 

-- Your query should return the following result for the sample case above.
 

-- | seat_id |
-- |---------|
-- | 3       |
-- | 4       |
-- | 5       |
-- Note:
-- The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
-- Consecutive available seats are more than 2(inclusive) seats consecutively available.

--My Solution

//METHOD 1
SELECT DISTINCT c1.seat_id
FROM cinema c1
JOIN cinema c2 ON ABS(c1.seat_id - c2.seat_id) = 1
Where c1.free = 1 AND c2.free = 1

//METHOD 2
SELECT c1.seat_id
 FROM cinema c1
 JOIN cinema c2 on c1.seat_id = c2.seat_id - 1
 where c1.free = 1 AND c2.free = 1
 
UNION
 
SELECT c2.seat_id
 FROM cinema c1
 JOIN cinema c2 on  c1.seat_id = c2.seat_id + 1
 where c1.free = 1 AND c2.free = 1

-- Solution
Select seat_id
from(
select seat_id, free,
lead(free,1) over() as next,
lag(free,1) over() as prev
from cinema) a
where a.free=True and (next = True or prev=True)
order by seat_id
