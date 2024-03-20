use olympics;
select * from athlete_events;

# How many olympics games have been held?
select count(distinct games) as total_olympic_games
from athlete_events;

# List down all Olympics games held so far. 
select distinct oly.year,oly.season,oly.city
from athlete_events oly
order by year;
