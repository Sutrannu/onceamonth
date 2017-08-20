use std::env;
extern crate chrono;
use chrono::prelude::*;

fn usage() {
    println!("\nERROR: Usage: ./getweekday-rs <MONTH> <YEAR>");
}

fn main() {
    let args: Vec<String> = env::args().collect();
    match args.len() {
        3 => {
            let m = &args[1];
            let y = &args[2];

            let month:u32 = match m.parse() {
                Ok(n)  => {
                    n
                },
                Err(_) => {
                    usage();
                    return;
                }
            };

            let year:i32 = match y.parse() {
                Ok(n)  => {
                    n
                },
                Err(_) => {
                    usage();
                    return;
                },
            };

            let mut d = NaiveDate::from_ymd(year, month, 1);
            let mut wds = Vec::new();
            for _ in 0..days_in_month(d.year(), d.month()) {
                if d.weekday().number_from_monday() <= 5 {
                    wds.push(d);
                }
                d = d.succ();
            }

            let num_wd = wds.len() as u32;
            let p:f64 = (year as f64 / month as f64) as f64;
            let q:f64 = p % (num_wd as f64);

            // awk's %0.f does banker rounding, or rounds all ties to
            // closet even number, rust's round function uses llvm's
            // intrinsics, away from zero, so we must roll our own

            let frac = q - q.trunc();
            let index:usize =
                if (frac == 0.5) && (q.trunc() as u32 % 2 == 0) {
                    q.trunc() as usize
                } else {
                    q.round() as usize
                };

            println!("{}", wds[index].format("%a %Y-%m-%d").to_string());
        },
        _ => {
            usage();
        },
    }
}

fn days_in_month(year: i32, month: u32) -> u32 {
    let (y, m) = if month == 12 {
        (year + 1, 1)
    } else {
        (year, month + 1)
    };
    let d = NaiveDate::from_ymd(y, m, 1);
    d.pred().day()
}
