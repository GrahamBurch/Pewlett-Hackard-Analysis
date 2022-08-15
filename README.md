# Pewlett-Hackard-Analysis

## Overview
Pewlett-Hackard will soon have a significant number of employees retiring at once. We've been asked to determine how many total employees will be retiring, which departments have the most coming retirees and to determine whether Pewlett-Hackard has enough remaining employees to provide mentorships for new employees.

## Results
-- Our first query returned an initial total list of all upcoming retiring employees, unseparated by departments. This first result was quickly improved, however, by eliminating duplicate rows. When we run:

``` 
SELECT * FROM public.retirement_info 
```

The following list of employees is our first result: 

