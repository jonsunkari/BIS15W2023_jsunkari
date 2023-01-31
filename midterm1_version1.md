---
title: "Midterm 1"
author: "Jonathan Sunkari"
date: "2023-01-31"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above.  

After the first 50 minutes, please upload your code (5 points). During the second 50 minutes, you may get help from each other- but no copy/paste. Upload the last version at the end of this time, but be sure to indicate it as final. If you finish early, you are free to leave.

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean! Use the tidyverse and pipes unless otherwise indicated. This exam is worth a total of 35 points. 

Please load the following libraries.

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
## ✔ ggplot2 3.4.0      ✔ purrr   1.0.0 
## ✔ tibble  3.1.8      ✔ dplyr   1.0.10
## ✔ tidyr   1.2.1      ✔ stringr 1.5.0 
## ✔ readr   2.1.3      ✔ forcats 0.5.2 
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
library(janitor)
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

```r
library(skimr)
```

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ecs21351-sup-0003-SupplementS1.csv`. These data are from Soykan, C. U., J. Sauer, J. G. Schuetz, G. S. LeBaron, K. Dale, and G. M. Langham. 2016. Population trends for North American winter birds based on hierarchical models. Ecosphere 7(5):e01351. 10.1002/ecs2.1351.  

Please load these data as a new object called `ecosphere`. In this step, I am providing the code to load the data, clean the variable names, and remove a footer that the authors used as part of the original publication.

```r
ecosphere <- read_csv("data/ecs21351-sup-0003-SupplementS1.csv", skip=2) %>% 
  clean_names() %>%
  slice(1:(n() - 18)) # this removes the footer
```

Problem 1. (1 point) Let's start with some data exploration. What are the variable names?

```r
names(ecosphere)
```

```
##  [1] "order"                       "family"                     
##  [3] "common_name"                 "scientific_name"            
##  [5] "diet"                        "life_expectancy"            
##  [7] "habitat"                     "urban_affiliate"            
##  [9] "migratory_strategy"          "log10_mass"                 
## [11] "mean_eggs_per_clutch"        "mean_age_at_sexual_maturity"
## [13] "population_size"             "winter_range_area"          
## [15] "range_in_cbc"                "strata"                     
## [17] "circles"                     "feeder_bird"                
## [19] "median_trend"                "lower_95_percent_ci"        
## [21] "upper_95_percent_ci"
```

Problem 2. (1 point) Use the function of your choice to summarize the data.

```r
summary(ecosphere)
```

```
##     order              family          common_name        scientific_name   
##  Length:551         Length:551         Length:551         Length:551        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##      diet           life_expectancy      habitat          urban_affiliate   
##  Length:551         Length:551         Length:551         Length:551        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  migratory_strategy   log10_mass    mean_eggs_per_clutch
##  Length:551         Min.   :0.480   Min.   : 1.000      
##  Class :character   1st Qu.:1.365   1st Qu.: 3.000      
##  Mode  :character   Median :1.890   Median : 4.000      
##                     Mean   :2.012   Mean   : 4.527      
##                     3rd Qu.:2.685   3rd Qu.: 5.000      
##                     Max.   :4.040   Max.   :17.000      
##                                                         
##  mean_age_at_sexual_maturity population_size     winter_range_area  
##  Min.   : 0.200              Min.   :    15000   Min.   :       11  
##  1st Qu.: 1.000              1st Qu.:  1100000   1st Qu.:   819357  
##  Median : 1.000              Median :  4900000   Median :  2189639  
##  Mean   : 1.592              Mean   : 18446745   Mean   :  5051047  
##  3rd Qu.: 2.000              3rd Qu.: 18000000   3rd Qu.:  6778598  
##  Max.   :12.500              Max.   :300000000   Max.   :185968946  
##                              NA's   :273                            
##   range_in_cbc        strata          circles       feeder_bird       
##  Min.   :  0.00   Min.   :  1.00   Min.   :   2.0   Length:551        
##  1st Qu.:  2.35   1st Qu.:  3.00   1st Qu.:  46.5   Class :character  
##  Median : 30.30   Median : 11.00   Median : 184.0   Mode  :character  
##  Mean   : 38.48   Mean   : 32.43   Mean   : 558.9                     
##  3rd Qu.: 72.95   3rd Qu.: 42.00   3rd Qu.: 661.0                     
##  Max.   :100.00   Max.   :159.00   Max.   :3202.0                     
##                                                                       
##   median_trend   lower_95_percent_ci upper_95_percent_ci
##  Min.   :0.739   Min.   :0.5780      Min.   :    0.798  
##  1st Qu.:0.993   1st Qu.:0.9675      1st Qu.:    1.011  
##  Median :1.009   Median :0.9930      Median :    1.027  
##  Mean   :1.016   Mean   :0.9857      Mean   :   33.709  
##  3rd Qu.:1.030   3rd Qu.:1.0140      3rd Qu.:    1.055  
##  Max.   :1.396   Max.   :1.3080      Max.   :18000.000  
## 
```

Problem 3. (2 points) How many distinct orders of birds are represented in the data?

```r
skim(ecosphere)
```


Table: Data summary

|                         |          |
|:------------------------|:---------|
|Name                     |ecosphere |
|Number of rows           |551       |
|Number of columns        |21        |
|_______________________  |          |
|Column type frequency:   |          |
|character                |10        |
|numeric                  |11        |
|________________________ |          |
|Group variables          |None      |


**Variable type: character**

|skim_variable      | n_missing| complete_rate| min| max| empty| n_unique| whitespace|
|:------------------|---------:|-------------:|---:|---:|-----:|--------:|----------:|
|order              |         0|          1.00|  10|  17|     0|       19|          0|
|family             |         0|          1.00|   7|  17|     0|       74|          0|
|common_name        |         0|          1.00|   4|  36|     0|      551|          0|
|scientific_name    |         0|          1.00|   9|  52|     0|      551|          0|
|diet               |         0|          1.00|   4|  13|     0|        7|          0|
|life_expectancy    |         0|          1.00|   4|   6|     0|        3|          0|
|habitat            |        14|          0.97|   5|   9|     0|        6|          0|
|urban_affiliate    |         0|          1.00|   2|   3|     0|        2|          0|
|migratory_strategy |         0|          1.00|   4|  10|     0|        6|          0|
|feeder_bird        |         0|          1.00|   2|  13|     0|        3|          0|


**Variable type: numeric**

|skim_variable               | n_missing| complete_rate|        mean|          sd|      p0|        p25|        p50|         p75|         p100|hist  |
|:---------------------------|---------:|-------------:|-----------:|-----------:|-------:|----------:|----------:|-----------:|------------:|:-----|
|log10_mass                  |         0|           1.0|        2.01|        0.79| 4.8e-01|       1.37|       1.89|        2.68|         4.04|▅▇▅▆▁ |
|mean_eggs_per_clutch        |         0|           1.0|        4.53|        2.40| 1.0e+00|       3.00|       4.00|        5.00|        17.00|▇▅▁▁▁ |
|mean_age_at_sexual_maturity |         0|           1.0|        1.59|        1.24| 2.0e-01|       1.00|       1.00|        2.00|        12.50|▇▁▁▁▁ |
|population_size             |       273|           0.5| 18446744.60| 36062656.12| 1.5e+04| 1100000.00| 4900000.00| 18000000.00| 300000000.00|▇▁▁▁▁ |
|winter_range_area           |         0|           1.0|  5051047.13| 10533393.51| 1.1e+01|  819357.00| 2189639.00|  6778598.00| 185968946.00|▇▁▁▁▁ |
|range_in_cbc                |         0|           1.0|       38.48|       36.31| 0.0e+00|       2.35|      30.30|       72.95|       100.00|▇▂▂▂▃ |
|strata                      |         0|           1.0|       32.43|       43.06| 1.0e+00|       3.00|      11.00|       42.00|       159.00|▇▁▁▁▁ |
|circles                     |         0|           1.0|      558.87|      787.55| 2.0e+00|      46.50|     184.00|      661.00|      3202.00|▇▁▁▁▁ |
|median_trend                |         0|           1.0|        1.02|        0.05| 7.4e-01|       0.99|       1.01|        1.03|         1.40|▁▅▇▁▁ |
|lower_95_percent_ci         |         0|           1.0|        0.99|        0.06| 5.8e-01|       0.97|       0.99|        1.01|         1.31|▁▁▇▂▁ |
|upper_95_percent_ci         |         0|           1.0|       33.71|      766.78| 8.0e-01|       1.01|       1.03|        1.05|     18000.00|▇▁▁▁▁ |
19 (n_unique for the order variable)

Problem 4. (2 points) Which habitat has the highest diversity (number of species) in the data?

```r
#ecosphere %>%
  #select(order, habitat) %>%
  #which(habitat == max(length(ecosphere$order)))
```

Run the code below to learn about the `slice` function. Look specifically at the examples (at the bottom) for `slice_max()` and `slice_min()`. If you are still unsure, try looking up examples online (https://rpubs.com/techanswers88/dplyr-slice). Use this new function to answer question 5 below.

```r
?slice_max
```

Problem 5. (4 points) Using the `slice_max()` or `slice_min()` function described above which species has the largest and smallest winter range?

```r
slice_max(ecosphere, winter_range_area)
```

```
## # A tibble: 1 × 21
##   order     family commo…¹ scien…² diet  life_…³ habitat urban…⁴ migra…⁵ log10…⁶
##   <chr>     <chr>  <chr>   <chr>   <chr> <chr>   <chr>   <chr>   <chr>     <dbl>
## 1 Procella… Proce… Sooty … Puffin… Vert… Long    Ocean   No      Long        2.9
## # … with 11 more variables: mean_eggs_per_clutch <dbl>,
## #   mean_age_at_sexual_maturity <dbl>, population_size <dbl>,
## #   winter_range_area <dbl>, range_in_cbc <dbl>, strata <dbl>, circles <dbl>,
## #   feeder_bird <chr>, median_trend <dbl>, lower_95_percent_ci <dbl>,
## #   upper_95_percent_ci <dbl>, and abbreviated variable names ¹​common_name,
## #   ²​scientific_name, ³​life_expectancy, ⁴​urban_affiliate, ⁵​migratory_strategy,
## #   ⁶​log10_mass
```


```r
slice_min(ecosphere, winter_range_area)
```

```
## # A tibble: 1 × 21
##   order     family commo…¹ scien…² diet  life_…³ habitat urban…⁴ migra…⁵ log10…⁶
##   <chr>     <chr>  <chr>   <chr>   <chr> <chr>   <chr>   <chr>   <chr>     <dbl>
## 1 Passerif… Alaud… Skylark Alauda… Seed  Short   Grassl… No      Reside…    1.57
## # … with 11 more variables: mean_eggs_per_clutch <dbl>,
## #   mean_age_at_sexual_maturity <dbl>, population_size <dbl>,
## #   winter_range_area <dbl>, range_in_cbc <dbl>, strata <dbl>, circles <dbl>,
## #   feeder_bird <chr>, median_trend <dbl>, lower_95_percent_ci <dbl>,
## #   upper_95_percent_ci <dbl>, and abbreviated variable names ¹​common_name,
## #   ²​scientific_name, ³​life_expectancy, ⁴​urban_affiliate, ⁵​migratory_strategy,
## #   ⁶​log10_mass
```

Largest: Puffinus griseus
Smallest: Alauda arvensis


Problem 6. (2 points) The family Anatidae includes ducks, geese, and swans. Make a new object `ducks` that only includes species in the family Anatidae. Restrict this new dataframe to include all variables except order and family.

```r
ducks <- ecosphere %>%
  filter(family == "Anatidae") %>%
  select(common_name:upper_95_percent_ci)

ducks
```

```
## # A tibble: 44 × 19
##    commo…¹ scien…² diet  life_…³ habitat urban…⁴ migra…⁵ log10…⁶ mean_…⁷ mean_…⁸
##    <chr>   <chr>   <chr> <chr>   <chr>   <chr>   <chr>     <dbl>   <dbl>   <dbl>
##  1 "Ameri… Anas r… Vege… Long    Wetland No      Short      3.09     9       1  
##  2 "Ameri… Anas a… Vege… Middle  Wetland No      Short      2.88     7.5     1  
##  3 "Barro… Buceph… Inve… Middle  Wetland No      Modera…    2.96    10.5     3  
##  4 "Black… Branta… Vege… Long    Wetland No      Modera…    3.11     3.5     2.5
##  5 "Black… Melani… Inve… Middle  Wetland No      Modera…    3.02     9.5     2  
##  6 "Black… Dendro… Vege… Short   Wetland No      Withdr…    2.88    13.5     1  
##  7 "Blue-… Anas d… Vege… Middle  Wetland No      Modera…    2.56    10       0.6
##  8 "Buffl… Buceph… Inve… Middle  Wetland No      Short      2.6      8.5     2  
##  9 "Cackl… Branta… Vege… Middle  Wetland Yes     Short      3.45     5       1  
## 10 "Canva… Aythya… Vege… Middle  Wetland No      Short      3.08     8       1  
## # … with 34 more rows, 9 more variables: population_size <dbl>,
## #   winter_range_area <dbl>, range_in_cbc <dbl>, strata <dbl>, circles <dbl>,
## #   feeder_bird <chr>, median_trend <dbl>, lower_95_percent_ci <dbl>,
## #   upper_95_percent_ci <dbl>, and abbreviated variable names ¹​common_name,
## #   ²​scientific_name, ³​life_expectancy, ⁴​urban_affiliate, ⁵​migratory_strategy,
## #   ⁶​log10_mass, ⁷​mean_eggs_per_clutch, ⁸​mean_age_at_sexual_maturity
```

Problem 7. (2 points) We might assume that all ducks live in wetland habitat. Is this true for the ducks in these data? If there are exceptions, list the species below.

```r
ducks %>%
  filter(habitat != "Wetland")
```

```
## # A tibble: 1 × 19
##   common…¹ scien…² diet  life_…³ habitat urban…⁴ migra…⁵ log10…⁶ mean_…⁷ mean_…⁸
##   <chr>    <chr>   <chr> <chr>   <chr>   <chr>   <chr>     <dbl>   <dbl>   <dbl>
## 1 Common … Somate… Inve… Middle  Ocean   No      Short      3.31       5     2.5
## # … with 9 more variables: population_size <dbl>, winter_range_area <dbl>,
## #   range_in_cbc <dbl>, strata <dbl>, circles <dbl>, feeder_bird <chr>,
## #   median_trend <dbl>, lower_95_percent_ci <dbl>, upper_95_percent_ci <dbl>,
## #   and abbreviated variable names ¹​common_name, ²​scientific_name,
## #   ³​life_expectancy, ⁴​urban_affiliate, ⁵​migratory_strategy, ⁶​log10_mass,
## #   ⁷​mean_eggs_per_clutch, ⁸​mean_age_at_sexual_maturity
```
Somateria mollissima lives in the ocean habitat. 

Problem 8. (4 points) In ducks, how is mean body mass associated with migratory strategy? Do the ducks that migrate long distances have high or low average body mass?

```r
long <- filter(ducks, ducks$migratory_strategy == "Long")
mean(long$log10_mass)
```

```
## [1] 2.87
```

```r
Mid <- filter(ducks, ducks$migratory_strategy == "Moderate")
mean(Mid$log10_mass)
```

```
## [1] 3.108824
```

```r
Short <- filter(ducks, ducks$migratory_strategy == "Short")
mean(Short$log10_mass)
```

```
## [1] 2.977143
```

```r
With <- filter(ducks, ducks$migratory_strategy == "Withdrawal")
mean(With$log10_mass)
```

```
## [1] 2.916667
```
Longer migratory ducks had the lowest average mass. 

They have lower average body mass, compared to birds that migrate moderate distances. 

Problem 9. (2 points) Accipitridae is the family that includes eagles, hawks, kites, and osprey. First, make a new object `eagles` that only includes species in the family Accipitridae. Next, restrict these data to only include the variables common_name, scientific_name, and population_size.

```r
eagles <- ecosphere %>%
  filter(family == "Accipitridae") %>%
  select(common_name, scientific_name, population_size)
```

Problem 10. (4 points) In the eagles data, any species with a population size less than 250,000 individuals is threatened. Make a new column `conservation_status` that shows whether or not a species is threatened.

```r
eagles <- mutate(eagles, `conservation_status` = population_size<250000)
```
Note: False = not threatened, True = threatened

Problem 11. (2 points) Consider the results from questions 9 and 10. Are there any species for which their threatened status needs further study? How do you know?

```r
str(eagles)
```

```
## tibble [20 × 4] (S3: tbl_df/tbl/data.frame)
##  $ common_name        : chr [1:20] "Bald Eagle" "Broad-winged Hawk" "Cooper's Hawk" "Ferruginous Hawk" ...
##  $ scientific_name    : chr [1:20] "Haliaeetus leucocephalus" "Buteo platypterus" "Accipiter cooperii" "Buteo regalis" ...
##  $ population_size    : num [1:20] NA 1700000 700000 80000 130000 NA 50000 NA 200000 700000 ...
##  $ conservation_status: logi [1:20] NA FALSE FALSE TRUE TRUE NA ...
```
Yes, a few species of eagles do not have a population size and thus do not have a conservation status (the species that have an "na" in those variables).

Problem 12. (4 points) Use the `ecosphere` data to perform one exploratory analysis of your choice. The analysis must have a minimum of three lines and two functions. You must also clearly state the question you are attempting to answer.

```r
short <- filter(ecosphere, ecosphere$life_expectancy == "Short")
middle <- filter (ecosphere, ecosphere$life_expectancy == "Middle")
long <- filter(ecosphere, ecosphere$life_expectancy == "Long")

mean(short$mean_age_at_sexual_maturity)
```

```
## [1] 1.156226
```

```r
mean(middle$mean_age_at_sexual_maturity)
```

```
## [1] 1.679916
```

```r
mean(long$mean_age_at_sexual_maturity)
```

```
## [1] 3.604255
```
Question: Is longer life expectancy associated with mean age at sexual maturity?
Answer: Yes, it seems that species that had a longer life expectancy had a greater mean age at sexual maturity. 

Please provide the names of the students you have worked with with during the exam:

```r
#Darren Duong
```

Please be 100% sure your exam is saved, knitted, and pushed to your github repository. No need to submit a link on canvas, we will find your exam in your repository.
