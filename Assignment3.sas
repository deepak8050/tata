/* Forming library */

LIBNAME ass3_sas '/folders/myfolders/assgnmnt';

/* Importing Datafile */

Proc Import datafile = '/folders/myfolders/assgnmnt/Car_sales.csv'
     DBMS = csv replace
     OUT  = ass3_sas.Car_sales;
     GETNAMES = YES;
     GUESSINGROWS = Max;
Run;

/* Getting names of unique manufacturers      */

Proc Freq data = ass3_sas.car_sales;
    tables manufacturer/ nocol nocum nofreq nopercent norow;
Run; 

/* Creating new variable to provide origin of manufacturer    */

Data ass3_sas.Car_origin (keep= Manufacturer Model Origin);
Set  ass3_sas.car_sales;
Length Origin $20;
Select (Manufacturer);
    When ("Acura") Origin="Japan";
    When ("Audi") Origin="Germany";
    When ("BMW") Origin="Germany";
    When ("Buick") Origin="USA";
    When ("Cadillac") Origin="USA";
    When ("Chevrolet") Origin="USA";
    When ("chrysler") Origin="USA";
    When ("Dodge") Origin="USA";
    When ("Ford") Origin="USA";
    When ("Honda") Origin="Japan";
    When ("Hyundai") Origin="South Korea";
    When ("Infiniti") Origin="Japan";
    When ("Jaguar") Origin="UK";
    When ("Jeep") Origin="USA";
    When ("Lexus") Origin="Japan";
    When ("Lincoln") Origin="USA";
    When ("Mercedes-Benz") Origin="Germany";
    When ("Mercury") Origin="USA";
    When ("Mitsubishi") Origin="Japan";
    When ("Nissan") Origin="Japan";
    When ("Oldsmobile") Origin="USA";
    When ("Plymouth") Origin="USA";
    When ("Pontiac") Origin="USA";
    When ("Porsche") Origin="Germany";
    When ("Saab") Origin="Sweden";
    When ("Saturn") Origin="USA";
    When ("Subaru") Origin="Japan";
    When ("Toyota") Origin="Japan";
    When ("Volkswagen") Origin="Germany";
    When ("Volvo") Origin="Sweden";
    Otherwise Origin="Other";
    End;
Run;    

/* Creating unique ID */

Data ass3_sas.car_sales;
   Set ass3_sas.car_sales;
   Unique_ID = Trim(Manufacturer)||""||Trim(Model);
Run;

/* Making separate datasets */

/* Dataset 1 */

Data ass3_sas.car_sales_1;
   Set ass3_sas.car_sales;
   Keep Manufacturer Model Unique_ID Sales_in_thousands Price_in_thousands _4_year_resale_value Latest_launch;
Run;   

/* Dataset 2 */

Data ass3_sas.car_sales_2;
   Set ass3_sas.car_sales;
   Drop Manufacturer Model Sales_in_thousands Price_in_thousands _4_year_resale_value Latest_launch;
Run;  

/* Creating Hyundai datafile  */

Data ass3_sas.Hyundai;
   Input Manufacturer$ Model$ Sales_in_thousands _4_year_resale_value Latest_launch date9.;
   Datalines;
   
   Hyundai Tuscon   16.919 16.36  2Feb12
   Hyundai i45      39.384 19.875 3Jun11
   Hyundai Verna    14.114 18.225 4Jan12
   Hyundai Terracan 08.588 29.725 10Mar11
   ;
Run; 

Data ass3_sas.Hyundai;
  Set ass3_sas.hyundai; 
  Unique_ID = Trim(Manufacturer)||""||Trim(Model);
Run;

/* Creating new file total_sales   */

Data ass3_sas.Total_sales;
   Set ass3_sas.car_sales_1 ass3_sas.hyundai;
Run;  

/* Creating new data set after merging  */

/* step 1 - sorting */

Proc sort data = ass3_sas.Total_sales;
   By Unique_ID;
Run; 

Proc sort data= ass3_sas.car_sales_2;
   By Unique_ID;
Run;   
/* step 2 - merging   */

Data ass3_sas.merged;
    Merge ass3_sas.total_sales ass3_sas.car_sales_2;
    By Unique_ID;
Run;   

/* Merging data sets to get common fields  */

/* step 1 - sorting */

Proc sort data = ass3_sas.Total_sales;
   By Unique_ID;
Run; 

Proc sort data= ass3_sas.car_sales_2;
   By Unique_ID;
Run;  

/* step 2 - merging   */

Data ass3_sas.merged_2;
    Merge ass3_sas.total_sales (IN=T)
          ass3_sas.car_sales_2 (IN=S);
    By Unique_ID;
    
    IF T and S;
Run;   
 
 
/*  --------------------------------------------------------------------------------------------- */