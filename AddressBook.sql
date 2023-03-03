/* UC1 */
create database AddressBookService;
use AddressBookService;

/* UC2 */
create table AddressBook
(
firstName Varchar(255),
lastName varchar(255),
address varchar(255),
city char(255),
state char(255),
zip INT,
phoneNumber BIGINT,
email NVARCHAR(255)
);
SELECT * FROM AddressBook;

/* UC3 */
INSERT INTO AddressBook VALUES('Riyas','Khan', 'pondy', 'pondicherry','puducherry',605001,1234567890,'riyas@gmail.com');
INSERT INTO AddressBook VALUES('Prince','Princee', 'madras', 'chennai','tamilnadu',605002,9876543210,'prince@gmail.com');
INSERT INTO AddressBook VALUES('Princess','Ts', 'tsPrincess', 'madurai','tamilnadu',605003,9486846336,'princess@gmail.com');
INSERT INTO AddressBook VALUES('Uma','Princess','annanagar ','chennai','singapore',605005,7891234568,'umaprincess@gmail.com');

SELECT * FROM AddressBook;

/* UC4 */
Update AddressBook SET address = 'madras' WHERE firstName = 'Prince';
SELECT * FROM AddressBook;
Alter table AddressBook Drop column phoneNumber;
Alter table AddressBook Add phoneNumber BIGINT;

Drop table AddressBook;

Update AddressBook SET firstName = 'Princess' where email = 'princess@gmail.com';
Update AddressBook SET address = 'madurai' where email = 'princess@gmail.com';
Update AddressBook SET city = 'chennai' where email = 'princess@gmail.com';
Update AddressBook SET state = 'singaporeUK' where email = 'princess@gmail.com';
SELECT * FROM AddressBook;

/* UC5 */
INSERT INTO AddressBook VALUES('Anusha nanjappa','', 'vijayawada', 'guntur','andhra',513468,9548621458,'anushananjappa123@gmail.com');
DELETE FROM AddressBook WHERE firstName = 'Anushananjappa';
SELECT * FROM AddressBook;

/* UC6 */
SELECT firstName, lastName, address, state, zip, phoneNumber, email from AddressBook where city = 'chennai';
SELECT firstName, lastName, address, city, zip, phoneNumber, email from AddressBook where state = 'andra';

/* UC7 */
SELECT city, count(city) from AddressBook Group BY city;
SELECT state, count(state) from AddressBook Group BY state;

/* UC8 */
SELECT firstName, lastName, address, city, state, zip, phoneNumber, email from AddressBook where city = 'chennai' ORDER BY firstName;

/* UC9 */
alter table AddressBook Add Type VARCHAR(255);
SELECT * from AddressBook;

Update AddressBook SET Type = 'Professional' WHERE firstName = 'Riyas';
Update AddressBook SET Type = 'Family' WHERE firstName = 'Prince';
Update AddressBook SET Type = 'Friend' WHERE firstName = 'Princess';
Update AddressBook SET Type = 'Friend' WHERE firstName = 'uma';

/* UC10 */
SELECT Type, COUNT(Type) FROM AddressBook Group BY Type;  

/* UC11 */
INSERT INTO AddressBook VALUES('Vijay','thalapathy', 'tamilnadu', 'india','world',123456,983436373,'viay@gmail.com', 'Family');
INSERT INTO AddressBook VALUES('Ajith','thala', 'tamilnadu', 'india','world',654321,9537834375,'vijayakalmurugan485@gmail.com', 'Hero');
SELECT * FROM AddressBook;
/* UC 12 */
create table AddressBookTable
(
AddressBookID int identity(1,1) primary key,
AddressBookName varchar(255)
);

INSERT INTO AddressBookTable values
('Engineers'),('Doctors');

SELECT * FROM AddressBookTable;

create table PersonType
(
PersonID int identity(1,1) primary key,
PersonType varchar(255)
);

INSERT INTO PersonType values
('Family'),('Friend'),('Profession'),('Hero');

SELECT * FROM PersonType;

create table Person
(
PersonID int identity(1,1) primary key,
AddressBookID int,
PersonType varchar(255),
FirstName varchar(255),
LastName varchar(255),
Address varchar(255),
City varchar(255),
State varchar(255),
Zipcode int,
PhoneNumber bigint,
Email varchar(256)
foreign key (AddressBookID) references AddressBookTable(AddressBookID)
);

INSERT INTO Person values
(1,'Friend','Suriya','king','coimba','coimbatore','tamil',124773,1234567898,'suriya123@gmail.com'),
(2,'Family','karthick','raj','asdd','zcsd','bangalore',683838,27267363663,'karthick@gmail.com'),
(1,'Professional','Raja','ghr','addfy','cuddalore','TN',954862,15984263,'raja@gmail.com');

SELECT * FROM Person;

create table PersonTypeFully
(
PersonID int foreign key references Person(PersonID),
PersonTypeID int foreign key references PersonType(PersonID)
);

INSERT INTO PersonTypeFully values (1,1),(2,2),(3,3),(2,1);

SELECT * FROM PersonTypeFully;

/* UC 13 */
/* UC 6 */
select p.PersonID,concat(p.FirstName,p.LastName)as Name,concat(p.Address,',',p.City,',',p.State,',',p.ZipCode) as Address,
p.PhoneNumber,p.Email,pt.PersonID,pt.PersonType,ab.AddressBookID ,ab.AddressBookName
from AddressBookTable ab,Person p,PersonType pt,PersonTypeFully ptf
where (ab.AddressBookID=p.AddressBookID  and p.PersonID=ptf.PersonID and ptf.PersonTypeID=pt.PersonID) and (City='coimbatore' or State='tamil') ;

/* UC 7 */
select count(*),State from Person 
inner join AddressBookTable on Person.AddressBookID= AddressBookTable.AddressBookID group by State;

select count(*),City
from Person 
inner join AddressBookTable on Person.AddressBookID= AddressBookTable.AddressBookID group by City;

/* UC 8*/
select p.PersonID,concat(p.FirstName,p.LastName)as Name,
concat(p.Address,',',p.City,',',p.State,',',p.ZipCode) as Address,p.PhoneNumber,p.Email,
pt.PersonID,pt.PersonType,ab.AddressBookID ,ab.AddressBookName
from AddressBookTable ab,Person p,PersonType pt,PersonTypeFully ptf
where (ab.AddressBookID=p.AddressBookID  and p.PersonID=ptf.PersonID and ptf.PersonID=pt.PersonID) and (State='TN') order by FirstName;

/* UC 10 */
SELECT COUNT(*),pt.PersonType FROM
PersonTypeFully AS ptf 
inner join PersonType as pt On pt.PersonId = ptf.PersonId
inner join Person as p on p.PersonId = ptf.PersonId GROUP BY pt.PersonType;