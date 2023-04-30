# Insert Person
insert into People (personKey, alias, name, birthdate, mainLocation, educationLevel, profilePicKey)
values ();

#get Person
SELECT * from People where name = "Lukas Pohn";

#get aliases
SELECT name from People;

# Create Table
CREATE TABLE People (
    personKey int,
    alias varchar(128),
    name varchar(255),
    birthdate date,
    mainLocation varchar(255),
    educationLevel varchar(128),
    profilePicKey int,
    PRIMARY KEY (personKey)
);

# Example
insert into People (alias, name, birthdate)
values ("Goldener Schuss","Lukas Pohn","1996-05-14");

insert into People (alias, name, educationLevel)
values ("Waldo","Walter Variu", "Hauptschule");

insert into People (alias, name, educationLevel)
values ("Binder","Christian Günther Binder", "Fachschule");

insert into People (alias, name, birthdate, educationLevel)
values ("Buttergolem","Rainer Winkler", "1989-08-02", "Sonderschule");