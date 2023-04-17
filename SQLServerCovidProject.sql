-- The following project is to demonstrate some of my skills in SQL
-- I used the CovidDeaths and CovidVaccinations datasets for analysis.

-- Selecting the data that will be used

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Where continent is not null 
order by 1,2


-- Looking at Total Deaths vs Population

Select Location, MAX(total_deaths) total_deaths, MAX(population) population, ROUND(MAX(total_deaths)/MAX(population)*100,2) AS PercentageTotalDeaths
From CovidDeaths
Where continent is not null
GROUP BY location
order by ROUND(MAX(total_deaths)/MAX(population)*100,2) DESC


-- Looking at Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
ORDER BY 1,2

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
and continent is not null 
order by 1,2

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
and continent is not null 
order by DeathPercentage DESC

Select Location, date, total_cases,total_deaths, ROUND((total_deaths/total_cases)*100,2) as DeathPercentage
From CovidDeaths
Where location like 'Portugal'
and continent is not null 
order by 1,2


--Total Cases vs Population
-- Percentage of population infected with Covid

Select Location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
order by 1,2


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  ROUND(Max((total_cases/population))*100,2) as PercentPopulationInfected
From CovidDeaths
Group by Location, Population
Order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population

Select Location, MAX(Total_deaths) as TotalDeathCount
From CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc


-- Continents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


-- Global Numbers

SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/NULLIF(SUM(new_cases),0)*100 AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, ROUND(SUM(new_deaths)/SUM(new_cases)*100,2) AS DeathPercentage
From CovidDeaths
WHERE continent is not null 
ORDER BY 1,2


--Total Population vs Vaccinations

SELECT * FROM CovidDeaths DEA
JOIN CovidVaccinations VAC
On dea.location = vac.location
AND dea.date = vac.date


-- Looking at Total Population vs Vaccinations

SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	On dea.location = vac.location
	AND dea.date = vac.date
Where dea.continent is not null
Order by 2,3

SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, vac.new_vaccinations))
	OVER(Partition by dea.location
	ORDER BY dea.location, dea.date)
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	On dea.location = vac.location
	AND dea.date = vac.date
Where dea.continent is not null
Order by 2,3


-- Shows Percentage of Population that has received at least one Covid Vaccine

SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int, vac.new_vaccinations))
	OVER(Partition by dea.location
	ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
	On dea.location = vac.location
	AND dea.date = vac.date
AND dea.new_vaccinations is not null
Order by 2,3


-- Using Common Table Expression (CTE) to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
AND dea.new_vaccinations IS NOT NULL
)
Select *, ROUND((RollingPeopleVaccinated/Population)*100,3) AS PercentPopulationVaccinated
From PopvsVac


-- Using Temporary Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated (
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	and dea.new_vaccinations is not null

Select *, (RollingPeopleVaccinated/Population)*100 as PercentPopulationVaccinated
From #PercentPopulationVaccinated

-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
