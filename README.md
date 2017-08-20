# onceamonth
Choose a deterministic weekday to have lunch once a month

	$ for i in $(seq 8 12); do ./getweekday.sh $i; done
	Thu 2017-08-31
	Thu 2017-09-21
	Fri 2017-10-06
	Fri 2017-11-10
	Fri 2017-12-01
	$ for i in $(seq 1 6); do ./getweekday.sh $i 2018; done
	Wed 2018-01-24
	Wed 2018-02-14
	Tue 2018-03-20
	Mon 2018-04-02
	Fri 2018-05-18
	Fri 2018-06-01


To build and run the rust version:

        $ cd getweekday-rs
        $ cargo build --release
	$ for i in $(seq 1 6); do ./target/release/getweekday-rs $i 2018; done
        Wed 2018-01-24
        Wed 2018-02-14
        Tue 2018-03-20
        Mon 2018-04-02
        Fri 2018-05-18
        Fri 2018-06-01

