libname class1 'C:\Users\yatin\Downloads\Compressed';



PROC IMPORT DATAFILE='C:\Users\yatin\Downloads\Compressed\Grocery_coupons.xls'
	
	
DBMS=xls replace
OUT=groceryvalue; 
GETNAMES=YES; 
guessingrows=100;
RUN;

Data groceryvalue;
set groceryvalue;
rename
size	=Size_of_store  org =	Store_organization style=	Shopping_style coupval=	Value_of_coupon;
run;

proc format lib= work;
value healthfoodstore
0='no'
1='yes';
value storesize
1 = 'Small'	
2= 'Medium'	
3 ='Large';
value storeorganization
1 = 'Emphasizes produce'
2 = 'Emphasizes deli'	
3  ='Emphasizes bakery'	
4  ='No emphasis';
value Gender	
0=  'Male'
1 = 'Female';

value Whoshoppingfor	
1  ='Self'	
2  ='Self and spouse'	
3  ='Self and family';
value Vegetarian	
0  ='No	'
1 ='Yes';
value Shoppingstyle
 1 = 'Biweekly; in bulk'	
2 = 'Weekly; similar items'	
3  ='Often; whats on sale';
value Usecoupons	
1 = 'No'	
2  ='From newspaper'	
3  ='From mailings	'
4  ='From both';
value Carryover
0 = 'First period'
1  ='No coupon	'
2  ='5 percent	'
3  ='15 percent	'
4  ='25 percent';
value Valueofcoupon
1 = 'No value'	
2  ='5 percent'	
3  ='15 percent'	
4  ='25 percent';
run;

data groceryvalue;

set groceryvalue;

format	hlthfood	Healthfoodstore.	;
format	Size_of_store	storesize.	;
format	Store_organization	Storeorganization.	;
format	gender	Gender.	;
format	shopfor	Whoshoppingfor.	;
format	veg	Vegetarian.	;
format	Shopping_style	Shoppingstyle.	;
format	usecoup	Usecoupons.	;
format	carry	Carryover.	;
format	Value_of_coupon	Valueofcoupon.	;
run;





PROC IMPORT DATAFILE='C:\Users\yatin\Downloads\Compressed\Grocery_coupons.xls'
	
	
DBMS=xls replace
OUT=class1.grocery; 
GETNAMES=YES; 
guessingrows=100;
RUN;

Data class1.grocery;
set class1.grocery;
rename
size	=Size_of_store  org =	Store_organization style=	Shopping_style coupval=	Value_of_coupon;
run;
proc freq data = class1.grocery;
 
tables Shopping_style Value_of_coupon;

 run;

  proc sort data = class1.grocery;
by gender;
run;

 proc freq data = class1.grocery;
 by gender;
tables Shopping_style Value_of_coupon;

 run;



proc freq data = class1.grocery;

tables Size_of_store*Store_organization/norow nocol nocum nopercent;

 run;

 proc freq data = class1.grocery;

tables Size_of_store*Store_organization/norow nocol nocum nofreq;

 run;

 proc means data = class1.grocery min max mean sum var maxdec=2 nway  ;
 class Size_of_store Store_organization;
 run;

