select d.deptname, hour(a.slotstart) as appointmenthour, count(a.appointmentid) as totalappointments
from appointments a
join doctors doc on a.doctorid = doc.doctorid
join departments d on doc.deptid = d.deptid
group by d.deptname, hour(a.slotstart)
order by totalappointments desc;

select doc.docname,
	count(a.appointmentid) as totalbooked,
	sum(case when a.statuss = 'completed' then 1 else 0 end) as completedappointments,
    round(sum(case when a.statuss = 'no-show' then 1 else 0 end)*100.0/count(*),2) as noshowpct
from doctors doc
left join appointments a on doc.doctorid = a.doctorid
group by doc.doctorid, doc.docname;

select d.deptname, sum(b.amount) as totalrevenue
from bills b
join appointments a on b.appointmentid = a.appointmentid
join doctors doc on a.doctorid = doc.doctorid
join departments d on doc.deptid = d.deptid
where b.paymentstatus = 'paid'
group by d.deptname;

select diagnosis, diagnosiscount
from (
	select diagnosis, count(*) as diagnosiscount
    from appointments
    where diagnosis is not null
    group by diagnosis
) as diagnosissummary
order by diagnosiscount desc
limit 5;