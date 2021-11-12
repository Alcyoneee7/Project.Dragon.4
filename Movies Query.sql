--Checking Information
select * 
from AeonianCentral..Movies

--Distinct 

select distinct Title, count(title)
from AeonianCentral..Movies
group by title 
order by count(title) desc
---------------------------------------Problem ,    --Duplicates In Title(1) $


select distinct Year, count(Year)
from AeonianCentral..Movies
group by Year 
order by count(Year) desc
---------------------------------------Problem ,    --We Only Need 2018-2020(2) $


select distinct Genre1, count(Genre1)
from AeonianCentral..Movies
group by Genre1 
order by count(Genre1) desc

select distinct Genre2, count(Genre2)
from AeonianCentral..Movies
group by Genre2 
order by count(Genre2) desc


select distinct Genre3, count(Genre3)
from AeonianCentral..Movies
group by Genre3
order by count(Genre3) desc




select distinct Votes, count(Votes)
from AeonianCentral..Movies
group by Votes 
order by count(Votes) desc
---------------------------------------Problem, I Only Notice When i Want To Visualize it
--So In Votes Column, There Are Value Like 5,32 . 
--It Actualy Is 5320 . But Since It Is Float. The Zero Is Removed
--So When i Sort It. There Problems
-- If I try To Change To Int, 
-- it Will Become 532 from 5,32
-- Messing Up Data
-------------------------------------------------Add Behind A Zero To A Value That The Row Behind Comma Is Only 2 Values (5) $

select *
from AeonianCentral..Movies
Where Votes is null

---------------------------------------Problem ,    --Votes Null Only One (3) $


select distinct gross, count(Gross)
from AeonianCentral..Movies
group by Gross
order by count(gross) desc

---------------------------------------Problem ,    --Gross Have $ And M , Which Will Interfere With Coding Later (4) $

select distinct [Avg Ratings] , count([Avg Ratings])
from AeonianCentral..Movies
group by [Avg Ratings]
order by count([Avg Ratings]) desc


--(1)   Delete Duplicate In Sql
-- I Normally Do It In Excel Because It Much Easier


with BBBB as 
(
Select *, ROW_NUMBER() Over(PARTITION BY TItle order by title) as LLL
from AeonianCentral..Movies
)
select * From BBBB where LLL > 1

select distinct Title, count(title)
from AeonianCentral..Movies
group by title 
order by count(title) desc



--(2)  Delete Movie Out Of Range(2018-2020)
--I Do It Manual Since Only A Few
-- Normally, I Just Make A Temporary Table That Only Have Value In Range
-- Or Delete Value That Not 2018-2020 


select distinct Year, count(Year)
from AeonianCentral..Movies
group by Year 
order by count(Year) desc


delete 
from AeonianCentral..Movies
Where Year = 2021

--Just Change The Year To 2016,2017,2028 , Etc


--(3) Remove Null Values
Select *
from AeonianCentral..Movies
where votes is null

Delete 
from AeonianCentral..Movies
where votes is null


--(4)  Trim Some Letter From Gross Column


select gross, REPLACE(gross , '$' , '') as HH
from AeonianCentral..Movies

update AeonianCentral..Movies
set gross = REPLACE(gross , '$' , '')

select gross, REPLACE(gross , 'M' , '') as HH
from AeonianCentral..Movies

update AeonianCentral..Movies
set gross = REPLACE(gross , 'M' , '')

--(5) .Updating Votes Column

ALTER TABLE AeonianCentral..Movies
ADD VotesNew nvarchar(255)

select * 
from AeonianCentral..Movies

UPDATE AeonianCentral..Movies
SET VotesNew = Votes

----------------------------------------------------------------------------------------------------
-- Information To Visualize
--Further Edit In Excel

--Genre , Most Movie Have, All Data [1]
--Bar Chart

--Which Genre, Receive Most Gross [2]
--Select Top 100 Gross Since There Are Null In Gross
--Pie Chart

--Which Genre, Receive Most Votes [3]
--Select Top 100 Votes Since There Are Null In Votes
--Pie Chart

--Top 10 Movies , That Have 0 Null [4]
--Sort It By Votes,Gross,Ratings
--List

select * 
from AeonianCentral..Movies


--[1] ^^
--Overall Movie Genre
SELECT Genre, Count(*) as Numbers
FROM
(
  SELECT genre1 as Genre
  FROM AeonianCentral..Movies
  UNION ALL
  SELECT genre2 
  FROM AeonianCentral..Movies
  UNION ALL
  Select genre3 
  from AeonianCentral..Movies
) sub
GROUP BY genre
order by Numbers desc

--[2] ^^
--Popular Genre By Gross

select * 
from AeonianCentral..Movies
where gross > 77
order by gross desc



SELECT Genre, Count(*) as Numbers 
FROM
( SELECT genre1 as Genre
  FROM AeonianCentral..Movies
  where gross > 77
  UNION ALL
  SELECT genre2 
  FROM AeonianCentral..Movies
  where gross > 77
  UNION ALL
  Select genre3 
  from AeonianCentral..Movies
  where gross > 77
) sub
GROUP BY Genre
order by numbers desc



--[3] ^^
--Cleaning The Gross Column


select *
from AeonianCentral..Movies
order by votes desc


select title, votesnew, SUBSTRING(votesnew, CHARINDEX('.' , Votesnew) + 1, len(votesnew))
from AeonianCentral..Movies
order by 3 desc


select bil from
(
select title, votesnew, SUBSTRING(votesnew, CHARINDEX('.' , Votesnew) + 1, len(votesnew)) as Bil
from AeonianCentral..Movies
)sub


with blabla as
(
select title, votesnew, SUBSTRING(votesnew, CHARINDEX('.' , Votesnew) + 1, len(votesnew)) as Bil
from AeonianCentral..Movies
--order by 3 desc
)
--select bil
--,	case when len(bil) = 2 then '00'
--	 when len(bil) = 1 then '0'
--	 else bil
--	 end as aa
--from blabla
update blabla
set votesnew = case when len(bil) = 2 then '00'
	 when len(bil) = 1 then '0'
	 else bil
	 end

select * from AeonianCentral..movies


select votes,votesnew, votes + '0'
from AeonianCentral..movies
where VotesNew = '00'

select votes,votesnew, votes + '00'
from AeonianCentral..movies
where VotesNew = '0'


select votes,votesnew
	,case when votesnew = '00' then votes + '0'
	when votesnew = '0' then votes + '00'
	else Votes
	end
from aeoniancentral..Movies
order by 2

update AeonianCentral..Movies
set votes = case when votesnew = '00' then votes + '0'
	when votesnew = '0' then votes + '00'
	else Votes
	end


--Changing Data Type [Votes] To Int
select * 
from AeonianCentral..Movies
order by votes


select votes, REPLACE(votes , '.' , '') as HH
from AeonianCentral..Movies
order  by 2

update AeonianCentral..Movies
set votes = REPLACE(votes , '.' , '')

--[3] ^^
--Data To Visualize

select * 
from AeonianCentral..Movies
order by votes desc


SELECT Genre, Count(*) as Numbers 
FROM
( SELECT genre1 as Genre
  FROM AeonianCentral..Movies
  where votes > 78000
  UNION ALL
  SELECT genre2 
  FROM AeonianCentral..Movies
  where votes > 78000
  UNION ALL
  Select genre3 
  from AeonianCentral..Movies
  where votes > 78000
) sub
GROUP BY Genre
order by numbers desc


--[4] ^^
--Limit 14

select title,genre1,genre2,votes,gross,[Avg Ratings]
from AeonianCentral..Movies
where [avg ratings] is not null
order by votes desc ,gross desc


