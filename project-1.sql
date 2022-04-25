Select *
From [portfolio-project-1]..Cdeaths
Order by 1

--Select *
--From [portfolio-project-1]..Cactive
--Order by 1

Select Country, total_confirmed, total_deaths, total_recovered, population
From [portfolio-project-1]..Cdeaths
Order by 1

--Looking for total deaths vs total cases confirmed
Select Country, total_confirmed, total_deaths, (total_deaths/total_confirmed)*100 as deathpercentage
From [portfolio-project-1]..Cdeaths
Where country like '%India%'
Order by 1

--Looking for population vs total cases 

Select Country, total_confirmed, population, (total_confirmed/population)*100 as casespercentage
From [portfolio-project-1]..Cdeaths
Where country like '%India%'
Order by 1

--looking at the countries with high infection rate compared to population
Select Country, MAX(total_confirmed) as highestinfectcount, population, MAX((total_confirmed/population))*100 as casespercentage
From [portfolio-project-1]..Cdeaths
Group by population, Country
--Where country like '%India%'
Order by casespercentage desc

--Showing countries with highest death count

Select country, MAX(cast(total_deaths as int)) as totaldeathcount
From [portfolio-project-1]..Cdeaths
Group by country 
Order by  totaldeathcount desc

--highest deathcount  continent wise
Select continent, MAX(cast(total_deaths as int)) as totaldeathcount
From [portfolio-project-1]..Cdeaths
Group by continent 
Order by  totaldeathcount desc

--global numbers
Select SUM(total_confirmed) as total_cases, SUM(cast(total_deaths as int)) as total_deaths, SUM(cast(total_deaths as int))/SUM(total_confirmed)*100 as deathpercentage
From [portfolio-project-1]..Cdeaths
--Group by country 
Order by  deathpercentage desc

--join Cative and Cdeaths tables
--total population vs total tests

Select dea.continent, dea.country, dea.population, act.total_tests, (dea.population/act.total_tests)*100 as tests_conducted
From [portfolio-project-1]..Cdeaths dea
join [portfolio-project-1]..Cactive act
	on dea.country = act.country
	and dea.continent = act.continent
Order by continent



--Temp Table

Drop table if exists #tests_conducted
Create Table #tests_conducted
(
continent nvarchar(255),
country nvarchar(255),
population numeric,
total_tests numeric,
tests_conducted numeric
)
Select dea.continent, dea.country, dea.population, act.total_tests, (dea.population/act.total_tests)*100 as tests_conducted
From [portfolio-project-1]..Cdeaths dea
join [portfolio-project-1]..Cactive act
	on dea.country = act.country
	and dea.continent = act.continent
Order by continent

--data visualization

Create View tests_conducted as

Select dea.continent, dea.country, dea.population, act.total_tests, (dea.population/act.total_tests)*100 as tests_conducted
From [portfolio-project-1]..Cdeaths dea
join [portfolio-project-1]..Cactive act
	on dea.country = act.country
	and dea.continent = act.continent