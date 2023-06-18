# Q1:- Create a table "Station" to store information about weather observation stations:

use world;
create table station(
Id int primary key,
City char(20),
State char(20),
Lat_N real,
Long_W real
);


# Q2:- Inserting the following records into table Staion:

insert into Station values("13","PHOENIX","AZ","33","112");
insert into Station values("44","DENEVER","CO","40","105");
insert into Station values("66","CARIBOU","ME","47","68");

# Q3:- Execute a query to look at table Station in undefined order:

select * from Station;


# Q4:- Execute a query to select Northern stations (NOrthern latitude > 39.7):

select Id, City, State from Station
where Lat_N>39.7;


# Q5:- Create another table "Stats" to store normalised temperature and precipitation data:

create table Stats(
Id int references Station(Id),
Month int check(Month between 1 and 12),
Temp_F real check(Temp_F between -80 and 150),
Rain_I real check (Rain_I between 0 and 100),
primary key(Id,Month));

# Q6:- Populate the table Stats with some Statistics for January and July:

insert into Stats values ("13","1","57.4","0.31");
insert into Stats values ("13","7","91.7","5.15");
insert into Stats values ("44","1","27.3","0.18");
insert into Stats values ("44","7","74.8","2.11");
insert into Stats values ("66","1","6.7","2.10");
insert into Stats values ("66","7","65.8","4.52");

select * from Stats;

# Q7:- Execute a query to display temperature Stats (from Stats table) for each city (from Station table):

select Station.City, Stats.Temp_F from Station, Stats
where Station.Id=Stats.Id;

# Q8:- Execute a query to look at the table stats , ordered by month and greatest rainfall with column rearranged. It should also show the corresponding cities:

select Month, Id, rain_I, Temp_F
from Stats
order by Month, Rain_I desc;

# Q9:- Execute a query to look at temperature of July from table Stats, lower temperature first, picking up city name and latitude:

select Lat_N, City, Temp_F
from Stats, Station
where Month=7
and Stats.Id=Station.Id
order by Temp_F;


# Q10:- Execute a query to shaow Max and Min temperature as well as average rainfall for each city.

select Max(Temp_F), Min(Temp_F),avg(Rain_I),Id
from Stats
group by Id;

# Q11:- Execute a query to display each city's monthly temperature in Celcius and rainfall in centimetre.

create view metric_Stats (Id,Month,Temp_C,Rain_C) as 
select Id,Month,(Temp_F-32)*5/9,Rain_I*0.3937 from Stats;

select * from metric_Stats;


# Q12:- Update all rows of table Stats to compensate for faulty rain gauges known to read 0.01 inches low.

Update Stats set Rain_I = Rain_I + 0.01;
select * from Stats;

# Q13:- update Denever's July temperature reading as 74.9.

update Stats set Temp_F = 74.9
where Id = 44
and month = 7;

select * from Stats;
