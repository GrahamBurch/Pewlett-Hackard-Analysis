# Pewlett-Hackard-Analysis

## Overview
Pewlett-Hackard will soon have a significant number of employees retiring at once. We've been asked to determine how many total employees will be retiring, which departments have the most coming retirees and to determine whether Pewlett-Hackard has enough remaining employees to provide mentorships for new employees.

## Results
-- Our first query returned an initial total list of all upcoming retiring employees, unseparated by departments. This first result was quickly improved, however, by eliminating duplicate rows. When we run:

``` 
SELECT * FROM public.retirement_info 
```

The following list of employees is our cleaned first result: 

![""](Photos/table1.PNG)


-- Next, we needed to determine the counts for each of the titles held by the upcoming retirees. First we created a table containing all employee titles named retirement_titles. Next, we used a DISTINCT-ON query to create a table of only unique employee titles called unique_titles. Finally, when we run:

```
-- Make the retiring_titles table
SELECT COUNT(first_name), ut.title
INTO retiring_titles
FROM unique_titles as ut 
GROUP BY (ut.title)
ORDER BY COUNT(first_name) DESC;
```

The following table counting the number of employees that will be leaving by their titles is produced:

![""](Photos/table2.PNG)

