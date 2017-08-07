# onceamonth
Choose a deterministic weekday to have lunch once a month

	$ for i in $(seq 8 12); do ./getweekday.sh $i; done
	Thu 2017-08-31
	Thu 2017-09-21
	Fri 2017-10-06
	Fri 2017-11-10
	Fri 2017-12-01
	$ for i in $(seq 1 6); do ./getweekday.sh $i 2018; done
	Tue 2018-01-23
	Tue 2018-02-13
	Thu 2018-03-08
	Sat 2018-04-07
	Thu 2018-05-17
	Sat 2018-06-09