data Interest;
     do year=1 to 25;
     Capital=500000;
     
     do month = 1 to 12;
     
     Interest=capital*(.07/12); 
     capital+interest;      
     Output;
     
     end;
     end;
run;

data Interest;
     do year=1 to 25;
     Capital=500000;
     
     Interest=capital*(.07); 
     capital+interest;      
     Output;
     
     end;
run;

/* Car distance problem */

Data Car_distance;
   Mileage= 20;
   Do  gallon = 1 to 10;
   Distance = gallon * mileage;
   
   output;
  
   end;
Run;   
   
   
   