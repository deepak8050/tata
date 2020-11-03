libname class1 'C:\Users\yatin\Downloads\Compressed';

proc import datafile = 'C:\Users\yatin\Downloads\Compressed\car_sales.csv'
dbms = csv replace
out = class1.car_sales;
getnames = yes;
guessingrows= 200;
run;

data class1.car_sales_missing;
set class1.car_sales;
if Price_in_thousands = . then delete ;
if __year_resale_value = . then delete;
run;

DATA class1.usd15 class1.usd15_20 class1.usd20_30 class1.usd30_40 class1.usd40 ;


SET class1.car_sales;

if price_in_thousands <= 15 then output class1.usd15;
if price_in_thousands > 15 and price_in_thousands <= 20 then output class1.usd15_20;
if price_in_thousands >  20 and price_in_thousands <= 30 then output class1.usd20_30;
if price_in_thousands > 30 and price_in_thousands <= 40 then output class1.usd30_40;
if price_in_thousands > 40  then output class1.usd40;


RUN;


data class1.MMSP;

Set class1.car_sales;
keep manufacturer model price_in_thousands sales_in_thousands;
run;


data class1.vehicles;

Set class1.car_sales;
where Vehicle_type = "Passenger";
if Latest_Launch > '01OCT2014'D ;

run;
