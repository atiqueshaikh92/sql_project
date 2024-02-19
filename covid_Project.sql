
-- Check All The Data

select * from covid_vaccine_statewise;
-- to check table created
desc covid_vaccine_statewise;

-- Check for a particular State
select * from covid_vaccine_statewise
where state = 'Assam';

-- Check Excluding a Place
select * from covid_vaccine_statewise
where state <> 'India';
 -- Check for place with Vaccine greater than 1500
select * from covid_vaccine_statewise where Total_Individuals_Vaccinated > 1500;

-- Check for place with Vaccine Lesser than 1500
select * from covid_vaccine_statewise where Total_Individuals_Vaccinated < 1500;


select State, Malevaccinated, FemaleVaccinated, Total_Individuals_Vaccinated 
from covid_vaccine_statewise where Total_Individuals_Vaccinated > 1500;

-- Check for combined doses
select State, sum(FirstDose+SecondDose) as ALL_DOSES FROM covid_vaccine_statewise
group by State;

-- Check for State with MAximum Vaccine
select State, max(FirstDose+SecondDose) as MAXDOSES FROM covid_vaccine_statewise
group by State
order by MAXDOSES desc;

-- check for triple vaccine doses
select State, sum(Covaxin_Doses) as COVAX, sum(CoviShield_Doses) as COVISHIELD, sum(Sputnik_V_Doses) as SPUT, 
sum(Covaxin_Doses+CoviShield_Doses+Sputnik_V_Doses) AS Triple_vaccine
from covid_vaccine_statewise
group by State
ORDER BY Triple_vaccine
desc;

-- check for 5 state with maximum triple doses
select State, sum(Covaxin_Doses) as COVAX, sum(CoviShield_Doses) as COVISHIELD, sum(Sputnik_V_Doses) as SPUT, 
sum(Covaxin_Doses+CoviShield_Doses+Sputnik_V_Doses) AS Triple_vaccine
from covid_vaccine_statewise
group by State
ORDER BY Triple_vaccine
desc limit 5;

-- check for top 5 state with two doses having value greater than average
select State, sum(FirstDose+SecondDose) as ALL_DOSES FROM covid_vaccine_statewise
group by State
having ALL_DOSES > avg(FirstDose+SecondDose)
ORDER BY ALL_DOSES
desc limit 5;

-- Select for particular state
select * from covid_vaccine_statewise
where State in ('Assam', 'Bihar', 'Chandigarh');

-- Select for State with Vaccine count between 1000 - 2000
select * from covid_vaccine_statewise
where Total_Individuals_Vaccinated between 1000 and 2000;

-- Select the state with second letter A
select * from covid_vaccine_statewise where State LIKE '_a%';

-- Select the state with first letter B
select * from covid_vaccine_statewise where State LIKE 'B%';

-- count the number rows in table orders
select count(*) from covid_vaccine_statewise;
-- Date and time function
select now();

select year(now()) as currentyear;
 select length ('Sputnik_V_Doses');
 Select upper ('Bihar');
Select lower ('Andaman and Nicobar');

select * from covid_vaccine_agewise;

-- joining two table
select covid_vaccine_statewise.State, covid_vaccine_statewise.Total_Individuals_Vaccinated, 
covid_vaccine_agewise.Vaccinated45to60Years, covid_vaccine_agewise.Vaccinated18to44Years, covid_vaccine_agewise.Vaccinated60above
from covid_vaccine_statewise
inner join covid_vaccine_agewise
on covid_vaccine_statewise.State = covid_vaccine_agewise.State;

-- left outer join
select s.Total_Individuals_Vaccinated ,a.MaleVaccinated, a.FemaleVaccinated, s.State, s.UpdatedOn
from covid_vaccine_agewise a 
left join covid_vaccine_statewise s
on a.Total_Individuals_Vaccinated = s.Total_Individuals_Vaccinated
order by s.Total_Individuals_Vaccinated desc; 

-- right outer join
select s.Total_Individuals_Vaccinated ,a.MaleVaccinated, a.FemaleVaccinated, s.State, s.UpdatedOn
from covid_vaccine_agewise a 
right join covid_vaccine_statewise s
on a.Total_Individuals_Vaccinated = s.Total_Individuals_Vaccinated
order by s.Total_Individuals_Vaccinated desc; 

select * from covid_vaccine_genderwise;

-- joining three table
select s.State, s.FirstDose, s.SecondDose, a.Vaccinated18to44Years, a.Vaccinated45to60Years, a.Vaccinated60above,
c.Malevaccinated, c.FemaleVaccinated, c.Total_Individuals_Vaccinated as total
from covid_vaccine_statewise s
inner join covid_vaccine_agewise a
on s.State = a.State
inner join covid_vaccine_genderwise c
on a.Total_Doses = c.Total_Individuals_Vaccinated
order by total desc;
-- limit 3;

-- Creating new table
create table Covid_bkp(Total_Doses int,State varchar(50),FirstDose int, SecondDose int);
desc covid_bkp;

-- Inserting Data into table
insert into covid_bkp
select Total_Doses, State, FirstDose, SecondDose from covid_vaccine_statewise;
select * from covid_bkp;

-- Seelecting State with count of days of vaccine more than 100
select State, count(Vaccinated18to44Years)
from covid_vaccine_agewise
group by State
having count(Vaccinated18to44Years)>=100;

