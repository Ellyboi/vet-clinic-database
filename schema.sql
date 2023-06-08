/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;
USE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL,
    species VARCHAR
);