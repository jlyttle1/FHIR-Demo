-- Databricks notebook source
select
  count(*) as PatientCount
from
  fhir.Patient

-- COMMAND ----------

-- DBTITLE 1,Show the raw data
select * from fhir.Patient LIMIT 100

-- COMMAND ----------

-- DBTITLE 1,Query based on fields
SELECT gender, count(*)
FROM fhir.Patient
GROUP BY gender

-- COMMAND ----------

-- DBTITLE 1,Query that infers JSON structure
select count(*), maritalStatus.coding.display as MaritalStatus
from fhir.Patient
GROUP BY maritalStatus.coding.display 

-- COMMAND ----------

-- DBTITLE 1,Joining of tables
select code.coding.code, code.coding.display, count(*) as ConditionCount from fhir.condition c
INNER JOIN fhir.patient p on concat('urn:uuid:', p.id) = c.subject.reference  -- note:  the urn:uuid is a result of how synthea generates records and should not occur as long as the ids match
GROUP BY code.coding.code, code.coding.display
order by count(*) desc


-- COMMAND ----------

-- DBTITLE 1,A query can be used to create a table.  Query cleans display and code as single item arrays, cleans join key
DROP TABLE IF EXISTS fhir.PatientCondition;

CREATE TABLE IF NOT EXISTS fhir.PatientCondition
select code.coding.code[0] as Code, code.coding.display[0] as Display, count(*) as ConditionCount from fhir.condition c
INNER JOIN fhir.patient p on concat('urn:uuid:', p.id) = c.subject.reference  -- note:  the urn:uuid is a result of how synthea generates records and should not occur as long as the ids match
GROUP BY code.coding.code[0], code.coding.display[0]

-- COMMAND ----------

-- DBTITLE 1,Using the new table
select * from fhir.PatientCondition
ORDER BY ConditionCount desc

-- COMMAND ----------

-- DBTITLE 1,Place aggregation logic in a table (could also be a temp table or view)
DROP TABLE IF EXISTS fhir.PatientAgeBucket;

CREATE TABLE IF NOT EXISTS fhir.PatientAgeBucket
SELECT Id,
       CASE WHEN floor(datediff(current_date(), to_date(birthdate))/365) < 18 THEN 'Under 18'
       WHEN floor(datediff(current_date(), to_date(birthdate))/365) < 30 THEN '18-29'
       WHEN floor(datediff(current_date(), to_date(birthdate))/365) < 40 THEN '30-39'
       WHEN floor(datediff(current_date(), to_date(birthdate))/365) < 50 THEN '40-49'
       WHEN floor(datediff(current_date(), to_date(birthdate))/365) < 60 THEN '50-59'
       ELSE '60 and Over'
       END as Age
FROM fhir.Patient;

-- COMMAND ----------

select * from fhir.PatientAgeBucket
LIMIT 100

-- COMMAND ----------

-- DBTITLE 1,Aggregated table joined with a regular table
select p.Age, count(*) as FluVaccineCount
from fhir.PatientAgeBucket p
INNER JOIN fhir.immunization i ON concat('urn:uuid:', p.id) = i.patient.reference
where i.vaccineCode.coding[0].code = "140" -- flu
GROUP BY p.Age

