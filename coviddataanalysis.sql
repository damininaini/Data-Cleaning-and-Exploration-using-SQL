use portfolio_project;

select * from `latest covid-19 india status`;

#Data Cleaning - Let's begin with data cleaning\

#Renaming the table name to coviddeaths to make it more easy to use.
Alter table `latest covid-19 india status` rename to coviddeaths;

select * from coviddeaths;

#Altering the table and renaming the columns to make the names less complicated.

alter table coviddeaths rename column `State/UTs` to state;
alter table coviddeaths rename column `Total Cases` to total_cases;
alter table coviddeaths rename column Active to active_cases;
alter table coviddeaths rename column Discharged to recovered;
alter table coviddeaths rename column Deaths to total_deaths;

#Adding an ID column 

alter table coviddeaths
add id int primary key auto_increment;

#Renaming 'Telengana' to its correct spelling 'Telangana'

update coviddeaths
set state = 'Telangana'
where id=32;

select state,total_cases,active_cases,total_deaths,population
from coviddeaths
order by state;

# Percentage of deaths in each state

select state,total_cases,total_deaths,round((total_deaths/total_cases)*100,2) as death_percentage
from coviddeaths;

# Percentage of cases in each state

select state,total_cases,total_deaths,round((total_cases/population)*100,2) as cases_percentage
from coviddeaths;

#Percentage of recoveries in each state

select state,total_cases,total_deaths,round((recovered/total_cases)*100,2) as recovery_rate
from coviddeaths;

#Top 5 states that recorded highest number of deaths

select state,total_cases,total_deaths
from coviddeaths
order by total_deaths desc limit 5;

#The states with highest number of deaths are 'Maharastra','Kerala','Karnataka','Tamil Nadu','Delhi'

#Top 5 states with hightest recovery rate

select state,total_cases,recovered,round((recovered/total_cases)*100,2) as recovery_rate
from coviddeaths
order by recovery_rate desc limit 5;

#The states with highest recovery rate are 'Dadra and Nagar Haveli and Daman and Diu','Lakshadweep','Andhra Pradesh','Mizoram','Arunachal Pradesh'

#Percentage of infected population in each state

select state,total_cases,population,round((total_cases/population)*100,2) as percentage_of_affected_population
from coviddeaths
order by percentage_of_affected_population desc;

#Top 10 states with highest total cases

select state,total_cases
from coviddeaths
order by total_cases desc limit 10;

#Top 10 states with highest percentage of active cases

select state,active_cases, round((active_cases/total_cases)*100 ,2) as percentage_of_active_cases
from coviddeaths
order by percentage_of_active_cases desc limit 10;

# What are the total cases, active cases and recovered cases in the state Maharastra

select state,active_cases,total_cases 
from coviddeaths
where state like '%Maharashtra%';

#What are the total cases, active cases and recovered cases in Maharastra,Delhi and Tamil nadu

select state,total_cases,active_cases,recovered 
from coviddeaths
where state in ('Maharashtra','Delhi','Tamil nadu');

#What is the average recovery rate of Telangana and Andhra Pradesh combined

select avg(recovered) as average_recovery_rate
from coviddeaths
where state in ('telangana','Andhra Pradesh');

#Percentage of people currently infected

select state,(active_cases/population)*100 as currently_infected
from coviddeaths
order by currently_infected;

#Find the state with 3rd highest death rate

select state,total_deaths from(
select state,total_deaths,dense_rank() over( order by total_deaths desc) nth from coviddeaths) t1
where nth = 3;

#Find the state with 2nd highest recovery rate

select state,recovered from(
select state,recovered,dense_rank() over(order by recovered desc) nth from coviddeaths) t1
where nth = 2;

# Avg recovery rate and avg death rate in South India

select avg(recovered/total_cases)*100 as avg_recovery_rate, avg(total_deaths/total_cases)*100 as average_death_rate from coviddeaths
where state in ('andhra pradesh','telangana','tamil nadu','kerala','karnataka');















