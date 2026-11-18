create database medicore;
use medicore;

create table departments(
deptid int primary key auto_increment,
deptname varchar(50) not null unique,
floorno int check(floorno between 1 and 10)
);

create table doctors(
doctorid int primary key auto_increment,
docname varchar(100) not null,
specialization varchar(100) not null,
deptid int not null,
consultationfee decimal(8,2) not null check(consultationfee >0),
foreign key(deptid) references departments(deptid)
);

create table patients(
patientid int primary key auto_increment,
fname varchar(100) not null,
gender enum('male', 'female', 'others') not null,
phoneno varchar(15) unique not null
);

create table appointments(
appointmentid int primary key auto_increment,
patientid int not null,
doctorid int not null,
appointmentdate date not null,
slotstart time not null check(slotstart between '00:00:00' and '20:00:00'), #slot booked time
actualstart time null, #when it actually starts
#for example maths class is schedule at 10:20am but it actually starts at 10:30am after sir comes to the class
statuss enum('scheduled', 'completed', 'cancelled', 'no-show') 
default 'scheduled',
diagnosis varchar(150),
foreign key (patientid) references patients(patientid),
foreign key(doctorid) references doctors(doctorid)
);

create table prescriptions(
billid int primary key auto_increment,
appointmentid int unique not null,
medicinename varchar(100) not null,
dosage varchar(50) not null,
durationdays int check(durationdays>0),
foreign key(appointmentid) references appointments(appointmentid)
on delete cascade
);

create table bills(
billid int primary key auto_increment,
appointmentid int unique not null,
amount decimal(10,2) not null check(amount > 0),
paymentstatus enum('paid', 'pending') 
default 'pending',
foreign key(appointmentid) references appointments(appointmentid)
);

#TRIGGERS-to prevent double booking for same doctor,date and slot

delimiter $$
create trigger preventdoublebooking
before insert on appointments
for each row
begin
if exists(
select 1 from appointments
where doctorid = new.doctorid
and appointmentdate = new.appointmentdate
and slotstart = new.slotstart
and statuss in('scheduled', 'completed')
) then
signal sqlstate '45000'
set message_text = 'error: doctor is already booked for this slot';
end if;
end$$
delimiter ;