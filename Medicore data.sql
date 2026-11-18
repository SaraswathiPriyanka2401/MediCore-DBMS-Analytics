insert into departments(deptname, floorno) values
('cardiology', 2),
('orthopedics', 3),
('neurology', 4);

insert into doctors(docname, specialization, deptid, consultationfee) values
('dr.rao', 'cardiologist', 1, 800.00),
('dr.menon', 'orthopedic surgeon', 2, 700.00),
('dr.sharma', 'neurologist', 3, 900.00);

insert into patients(fname, gender, phoneno) values
('aarav','male','8977636345'),
('diya','female', '7673647637');

insert into appointments (patientid, doctorid, appointmentdate, slotstart, actualstart, statuss, diagnosis) VALUES
(1, 1, '2026-11-17', '09:30:00', '09:42:00', 'completed', 'arrhythmia'),
(2, 2, '2026-11-17', '10:30:00', '10:50:00', 'completed', 'knee pain'),
(1, 2, '2026-11-18', '11:00:00', '11:10:00', 'completed', 'fracture follow-up'),
(2, 3, '2026-11-18', '12:00:00', '12:05:00', 'completed', 'viral fever');
insert into bills(appointmentid, amount, paymentstatus) values
(1, 800.00, 'paid');

update appointments set slotstart = '14:00:00' where appointmentid = 2;

update appointments set statuss ='cancelled' where appointmentid = 2;