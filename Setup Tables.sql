-- Databricks notebook source
-- DBTITLE 1,Drop tables if they exist
DROP TABLE IF EXISTS fhir.PatientAdls;
DROP TABLE IF EXISTS fhir.Patient;
DROP TABLE IF EXISTS fhir.Claim;
DROP TABLE IF EXISTS fhir.Procedure;
DROP TABLE IF EXISTS fhir.Encounter;
DROP TABLE IF EXISTS fhir.Condition;
DROP TABLE IF EXiSTS fhir.Allergy;
DROP TABLE IF EXISTS fhir.CarePlan;
DROP TABLE IF EXISTS fhir.Goal;
DROP TABLE IF EXISTS fhir.DiagnosticReport;

DROP TABLE IF EXISTS fhir.ExplanationOfBenefits;
DROP TABLE IF EXISTS fhir.ImagingStudy;
DROP TABLE IF EXISTS fhir.Immunization;
DROP TABLE IF EXISTS fhir.MedicationRequest;
DROP TABLE IF EXISTS fhir.Observation;
DROP TABLE IF EXISTS fhir.Practitioner;

-- COMMAND ----------

-- DBTITLE 1,Setup tables

CREATE TABLE fhir.PatientLocal
USING JSON
LOCATION '/FileStore/tables/fhir/patients/*/Patient.ndjson';

CREATE TABLE fhir.Patient
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/patient/{*}/Patient.ndjson';

CREATE TABLE fhir.Claim
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/claims/{*}/Claim.ndjson';

CREATE TABLE fhir.Procedure
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/procedure/{*}/procedure.ndjson';

CREATE TABLE fhir.Encounter
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/encounters/{*}/Encounter.ndjson';

CREATE TABLE fhir.Condition
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/condition/{*}/condition.ndjson';

CREATE TABLE fhir.Allergy
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/allergyintolerance/{*}/AllergyIntolerance.ndjson';

CREATE TABLE fhir.CarePlan
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/careplan/{*}/careplan.ndjson';

CREATE TABLE fhir.Goal
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/goal/{*}/goal.ndjson';

CREATE TABLE fhir.DiagnosticReport
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/diagnosticreport/{*}/diagnosticreport.ndjson';

CREATE TABLE fhir.ExplanationOfBenefits
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/ExplanationOfBenefit/{*}/ExplanationOfBenefit.ndjson';

CREATE TABLE fhir.ImagingStudy
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/imagingstudy/{*}/imagingstudy.ndjson';

CREATE TABLE fhir.Immunization
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/immunization/{*}/immunization.ndjson';

CREATE TABLE fhir.MedicationRequest
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/medicationrequest/{*}/medicationrequest.ndjson';

CREATE TABLE fhir.Observation
USING JSON
LOCATION 'dbfs:/mnt/fhir/raw/observation/{*}/Observation.ndjson';
