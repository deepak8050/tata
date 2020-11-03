/* --------------------------------PART-1------------------------------------------------- */

/* Forming library */

LIBNAME ass5 '/folders/myfolders/assgnmnt';

/* Importing data */

PROC IMPORT datafile= '/folders/myfolders/assgnmnt/grocery_coupons.xls'
     DBMS=xls replace
     OUT = ass5.Grocery_coupons;
     GETNAMES= Yes;
     GUESSINGROWS= 100;
RUN;

/* Finfing intervals */

/* from today's date */

/* month */

Data month;
  set ass5.grocery_coupons (keep= couponexpiry);
  months= intck('month', couponexpiry, today());
Run; 

/* week */

Data week;
  set ass5.grocery_coupons (keep= couponexpiry);
  weeks= intck('week', couponexpiry, today());
Run;  

/* days */

Data Day;
  set ass5.grocery_coupons (keep= couponexpiry);
  days= intck('day', couponexpiry, today());
Run; 

/* from 31mar14 */

/* month */

Data month_2;
  set ass5.grocery_coupons (keep= couponexpiry);
  months= intck('month', couponexpiry, '31mar14'd);
Run; 

/* week */

Data week_2;
  set ass5.grocery_coupons (keep= couponexpiry);
  weeks= intck('week', couponexpiry, '31mar14'd);
Run; 

/* days */

Data day_2;
  set ass5.grocery_coupons (keep= couponexpiry);
  days= intck('day', couponexpiry, '31mar14'd);
Run;

/* finding issuance date of coupon  */

Data issuance;
  set ass5.grocery_coupons (keep= couponexpiry);
  issuancedate= intnx('month', couponexpiry, 3);
Run; 

/* number of days between couponexpiry and 30sep14 */

Data datedif;
  set ass5.grocery_coupons (keep= couponexpiry);
  days= datdif(couponexpiry,  '30sep14'd , 30/360);
Run;  

/* getting whole number dollar values */

/* by getting integer value */

Data estimatedamount;
  set ass5.grocery_coupons (keep= storeid amtspent);
  estimated_amount = INT(amtspent);
Run;

/* by rounding off  */


Data estimatedamount2;
  set work.estimatedamount;
  rounded_amount = round(amtspent);
Run;

/* It's clearly visible that by rounding off the amount we can get more profit */


/* ------------------------------PART-2--------------------------------- */

/* Importing data  */

PROC IMPORT datafile= '/folders/myfolders/assgnmnt/department.csv'
     DBMS= csv replace
     OUT = work.department;
     GETNAMES= Yes;
     GUESSINGROWS= 100;
RUN;

/* Creating variable last name */

DATA lastname (keep= department name Last_name);
   set work.department;
   Last_name = Scan(name , 1 , ",");
RUN;  

/* Starting position of first name  */


DATA postion (keep= department name First_name_position);
   set work.department;
   First_name_position = Index(name , ',')+2;
RUN;  

/* Creating variable first name */


DATA firstname (keep= department name first_name);
   set work.department;
   first_name = Substr(name , Index(name , ',')+2 , length(name)-2-Index(name , ',')-1) ;
RUN;  

/* ------------------------------------------------------------------------------------------------ */
