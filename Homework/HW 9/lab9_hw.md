---
title: "Lab 9 Homework"
author: "Please Add Your Name Here"
date: "2023-02-12"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

For this homework, we will take a departure from biological data and use data about California colleges. These data are a subset of the national college scorecard (https://collegescorecard.ed.gov/data/). Load the `ca_college_data.csv` as a new object called `colleges`.

```r
colleges <- readr::read_csv("ca_college_data.csv")
```

```
## Rows: 341 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): INSTNM, CITY, STABBR, ZIP
## dbl (6): ADM_RATE, SAT_AVG, PCIP26, COSTT4_A, C150_4_POOLED, PFTFTUG1_EF
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

The variables are a bit hard to decipher, here is a key:  

INSTNM: Institution name  
CITY: California city  
STABBR: Location state  
ZIP: Zip code  
ADM_RATE: Admission rate  
SAT_AVG: SAT average score  
PCIP26: Percentage of degrees awarded in Biological And Biomedical Sciences  
COSTT4_A: Annual cost of attendance  
C150_4_POOLED: 4-year completion rate  
PFTFTUG1_EF: Percentage of undergraduate students who are first-time, full-time degree/certificate-seeking undergraduate students  

1. Use your preferred function(s) to have a look at the data and get an idea of its structure. Make sure you summarize NA's and determine whether or not the data are tidy. You may also consider dealing with any naming issues.

```r
head(colleges)
```

```
## # A tibble: 6 × 10
##   INSTNM       CITY  STABBR ZIP   ADM_R…¹ SAT_AVG PCIP26 COSTT…² C150_…³ PFTFT…⁴
##   <chr>        <chr> <chr>  <chr>   <dbl>   <dbl>  <dbl>   <dbl>   <dbl>   <dbl>
## 1 Grossmont C… El C… CA     9202…      NA      NA 0.0016    7956      NA   0.355
## 2 College of … Visa… CA     9327…      NA      NA 0.0066    8109      NA   0.541
## 3 College of … San … CA     9440…      NA      NA 0.0038    8278      NA   0.357
## 4 Ventura Col… Vent… CA     9300…      NA      NA 0.0035    8407      NA   0.382
## 5 Oxnard Coll… Oxna… CA     9303…      NA      NA 0.0085    8516      NA   0.275
## 6 Moorpark Co… Moor… CA     9302…      NA      NA 0.0151    8577      NA   0.429
## # … with abbreviated variable names ¹​ADM_RATE, ²​COSTT4_A, ³​C150_4_POOLED,
## #   ⁴​PFTFTUG1_EF
```


```r
is.na(colleges)
```

```
##        INSTNM  CITY STABBR   ZIP ADM_RATE SAT_AVG PCIP26 COSTT4_A C150_4_POOLED
##   [1,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##   [2,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##   [3,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##   [4,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##   [5,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##   [6,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##   [7,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##   [8,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##   [9,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [10,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [11,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [12,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [13,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [14,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [15,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [16,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [17,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [18,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [19,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [20,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [21,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [22,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [23,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [24,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [25,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [26,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [27,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [28,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [29,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [30,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [31,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [32,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [33,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [34,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [35,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [36,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [37,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [38,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [39,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [40,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [41,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [42,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [43,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [44,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [45,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [46,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [47,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [48,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [49,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [50,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [51,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [52,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [53,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [54,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [55,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [56,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [57,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [58,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [59,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
##  [60,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [61,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [62,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [63,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [64,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
##  [65,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [66,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [67,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [68,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [69,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
##  [70,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [71,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [72,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [73,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [74,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [75,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [76,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [77,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [78,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [79,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [80,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [81,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [82,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [83,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [84,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
##  [85,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [86,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [87,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [88,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [89,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [90,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [91,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [92,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [93,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [94,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [95,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [96,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [97,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [98,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
##  [99,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [100,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [101,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [102,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [103,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [104,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [105,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [106,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [107,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [108,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [109,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [110,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [111,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [112,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [113,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [114,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [115,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [116,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [117,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [118,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [119,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [120,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [121,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [122,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [123,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [124,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [125,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [126,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [127,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [128,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [129,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [130,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [131,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [132,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [133,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [134,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [135,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [136,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [137,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [138,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [139,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [140,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [141,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE          TRUE
## [142,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [143,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [144,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [145,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [146,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [147,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [148,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [149,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [150,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [151,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [152,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [153,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [154,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [155,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [156,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [157,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [158,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [159,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [160,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [161,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [162,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [163,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [164,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [165,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE          TRUE
## [166,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [167,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [168,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [169,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [170,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [171,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [172,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [173,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [174,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [175,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [176,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [177,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [178,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [179,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE          TRUE
## [180,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [181,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [182,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [183,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [184,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [185,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [186,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [187,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [188,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE          TRUE
## [189,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [190,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [191,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [192,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [193,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [194,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [195,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [196,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [197,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [198,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [199,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [200,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [201,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [202,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [203,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [204,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [205,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [206,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [207,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [208,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [209,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [210,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE    FALSE         FALSE
## [211,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [212,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [213,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [214,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [215,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [216,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE    FALSE         FALSE
## [217,]  FALSE FALSE  FALSE FALSE    FALSE   FALSE  FALSE    FALSE         FALSE
## [218,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [219,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [220,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [221,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [222,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [223,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [224,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [225,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [226,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [227,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [228,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [229,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [230,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [231,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [232,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [233,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [234,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [235,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [236,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [237,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [238,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [239,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [240,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [241,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [242,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [243,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [244,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [245,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [246,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE         FALSE
## [247,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [248,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [249,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [250,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [251,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [252,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [253,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [254,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [255,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [256,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [257,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [258,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [259,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE         FALSE
## [260,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [261,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [262,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [263,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [264,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [265,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [266,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [267,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [268,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [269,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [270,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [271,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [272,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [273,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [274,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [275,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [276,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [277,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [278,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [279,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [280,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [281,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [282,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [283,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [284,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [285,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [286,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [287,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [288,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [289,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [290,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [291,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [292,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [293,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [294,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [295,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [296,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [297,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [298,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [299,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [300,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [301,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [302,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [303,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [304,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [305,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [306,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [307,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [308,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [309,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [310,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [311,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [312,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE         FALSE
## [313,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [314,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [315,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [316,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [317,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [318,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [319,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [320,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [321,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [322,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [323,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [324,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [325,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [326,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [327,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [328,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [329,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [330,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [331,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [332,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [333,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [334,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [335,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE         FALSE
## [336,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE  FALSE     TRUE          TRUE
## [337,]  FALSE FALSE  FALSE FALSE    FALSE    TRUE  FALSE     TRUE          TRUE
## [338,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [339,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [340,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
## [341,]  FALSE FALSE  FALSE FALSE     TRUE    TRUE   TRUE     TRUE          TRUE
##        PFTFTUG1_EF
##   [1,]       FALSE
##   [2,]       FALSE
##   [3,]       FALSE
##   [4,]       FALSE
##   [5,]       FALSE
##   [6,]       FALSE
##   [7,]       FALSE
##   [8,]       FALSE
##   [9,]       FALSE
##  [10,]       FALSE
##  [11,]       FALSE
##  [12,]       FALSE
##  [13,]       FALSE
##  [14,]       FALSE
##  [15,]       FALSE
##  [16,]       FALSE
##  [17,]       FALSE
##  [18,]       FALSE
##  [19,]       FALSE
##  [20,]       FALSE
##  [21,]       FALSE
##  [22,]       FALSE
##  [23,]       FALSE
##  [24,]       FALSE
##  [25,]       FALSE
##  [26,]       FALSE
##  [27,]       FALSE
##  [28,]       FALSE
##  [29,]       FALSE
##  [30,]       FALSE
##  [31,]       FALSE
##  [32,]       FALSE
##  [33,]       FALSE
##  [34,]       FALSE
##  [35,]       FALSE
##  [36,]       FALSE
##  [37,]       FALSE
##  [38,]       FALSE
##  [39,]       FALSE
##  [40,]       FALSE
##  [41,]       FALSE
##  [42,]       FALSE
##  [43,]       FALSE
##  [44,]       FALSE
##  [45,]       FALSE
##  [46,]       FALSE
##  [47,]       FALSE
##  [48,]       FALSE
##  [49,]       FALSE
##  [50,]       FALSE
##  [51,]       FALSE
##  [52,]       FALSE
##  [53,]       FALSE
##  [54,]       FALSE
##  [55,]       FALSE
##  [56,]       FALSE
##  [57,]       FALSE
##  [58,]       FALSE
##  [59,]       FALSE
##  [60,]       FALSE
##  [61,]       FALSE
##  [62,]       FALSE
##  [63,]       FALSE
##  [64,]       FALSE
##  [65,]       FALSE
##  [66,]       FALSE
##  [67,]       FALSE
##  [68,]       FALSE
##  [69,]       FALSE
##  [70,]       FALSE
##  [71,]       FALSE
##  [72,]       FALSE
##  [73,]       FALSE
##  [74,]       FALSE
##  [75,]       FALSE
##  [76,]       FALSE
##  [77,]       FALSE
##  [78,]       FALSE
##  [79,]       FALSE
##  [80,]       FALSE
##  [81,]       FALSE
##  [82,]       FALSE
##  [83,]       FALSE
##  [84,]       FALSE
##  [85,]       FALSE
##  [86,]       FALSE
##  [87,]       FALSE
##  [88,]       FALSE
##  [89,]       FALSE
##  [90,]       FALSE
##  [91,]       FALSE
##  [92,]       FALSE
##  [93,]       FALSE
##  [94,]       FALSE
##  [95,]       FALSE
##  [96,]       FALSE
##  [97,]       FALSE
##  [98,]       FALSE
##  [99,]       FALSE
## [100,]       FALSE
## [101,]       FALSE
## [102,]       FALSE
## [103,]       FALSE
## [104,]       FALSE
## [105,]       FALSE
## [106,]       FALSE
## [107,]       FALSE
## [108,]       FALSE
## [109,]       FALSE
## [110,]       FALSE
## [111,]       FALSE
## [112,]       FALSE
## [113,]       FALSE
## [114,]       FALSE
## [115,]       FALSE
## [116,]       FALSE
## [117,]       FALSE
## [118,]       FALSE
## [119,]       FALSE
## [120,]       FALSE
## [121,]       FALSE
## [122,]       FALSE
## [123,]       FALSE
## [124,]       FALSE
## [125,]       FALSE
## [126,]       FALSE
## [127,]       FALSE
## [128,]       FALSE
## [129,]       FALSE
## [130,]       FALSE
## [131,]       FALSE
## [132,]       FALSE
## [133,]       FALSE
## [134,]       FALSE
## [135,]       FALSE
## [136,]       FALSE
## [137,]       FALSE
## [138,]       FALSE
## [139,]       FALSE
## [140,]       FALSE
## [141,]        TRUE
## [142,]       FALSE
## [143,]       FALSE
## [144,]       FALSE
## [145,]       FALSE
## [146,]       FALSE
## [147,]       FALSE
## [148,]       FALSE
## [149,]       FALSE
## [150,]       FALSE
## [151,]       FALSE
## [152,]       FALSE
## [153,]       FALSE
## [154,]       FALSE
## [155,]       FALSE
## [156,]       FALSE
## [157,]       FALSE
## [158,]       FALSE
## [159,]       FALSE
## [160,]       FALSE
## [161,]       FALSE
## [162,]       FALSE
## [163,]       FALSE
## [164,]       FALSE
## [165,]       FALSE
## [166,]       FALSE
## [167,]       FALSE
## [168,]       FALSE
## [169,]       FALSE
## [170,]       FALSE
## [171,]       FALSE
## [172,]       FALSE
## [173,]       FALSE
## [174,]       FALSE
## [175,]       FALSE
## [176,]       FALSE
## [177,]       FALSE
## [178,]       FALSE
## [179,]        TRUE
## [180,]       FALSE
## [181,]       FALSE
## [182,]       FALSE
## [183,]       FALSE
## [184,]       FALSE
## [185,]       FALSE
## [186,]       FALSE
## [187,]       FALSE
## [188,]       FALSE
## [189,]       FALSE
## [190,]       FALSE
## [191,]       FALSE
## [192,]       FALSE
## [193,]       FALSE
## [194,]       FALSE
## [195,]       FALSE
## [196,]       FALSE
## [197,]       FALSE
## [198,]       FALSE
## [199,]       FALSE
## [200,]       FALSE
## [201,]       FALSE
## [202,]       FALSE
## [203,]       FALSE
## [204,]       FALSE
## [205,]       FALSE
## [206,]       FALSE
## [207,]       FALSE
## [208,]       FALSE
## [209,]       FALSE
## [210,]       FALSE
## [211,]       FALSE
## [212,]       FALSE
## [213,]       FALSE
## [214,]       FALSE
## [215,]       FALSE
## [216,]       FALSE
## [217,]       FALSE
## [218,]        TRUE
## [219,]       FALSE
## [220,]       FALSE
## [221,]        TRUE
## [222,]        TRUE
## [223,]       FALSE
## [224,]       FALSE
## [225,]       FALSE
## [226,]       FALSE
## [227,]       FALSE
## [228,]       FALSE
## [229,]        TRUE
## [230,]        TRUE
## [231,]        TRUE
## [232,]        TRUE
## [233,]        TRUE
## [234,]       FALSE
## [235,]        TRUE
## [236,]       FALSE
## [237,]        TRUE
## [238,]       FALSE
## [239,]       FALSE
## [240,]       FALSE
## [241,]       FALSE
## [242,]       FALSE
## [243,]       FALSE
## [244,]       FALSE
## [245,]       FALSE
## [246,]        TRUE
## [247,]        TRUE
## [248,]       FALSE
## [249,]        TRUE
## [250,]       FALSE
## [251,]       FALSE
## [252,]       FALSE
## [253,]        TRUE
## [254,]       FALSE
## [255,]        TRUE
## [256,]        TRUE
## [257,]       FALSE
## [258,]        TRUE
## [259,]       FALSE
## [260,]       FALSE
## [261,]        TRUE
## [262,]        TRUE
## [263,]       FALSE
## [264,]       FALSE
## [265,]        TRUE
## [266,]       FALSE
## [267,]        TRUE
## [268,]       FALSE
## [269,]       FALSE
## [270,]        TRUE
## [271,]        TRUE
## [272,]       FALSE
## [273,]       FALSE
## [274,]        TRUE
## [275,]       FALSE
## [276,]       FALSE
## [277,]       FALSE
## [278,]        TRUE
## [279,]       FALSE
## [280,]        TRUE
## [281,]        TRUE
## [282,]        TRUE
## [283,]       FALSE
## [284,]       FALSE
## [285,]       FALSE
## [286,]       FALSE
## [287,]       FALSE
## [288,]       FALSE
## [289,]       FALSE
## [290,]       FALSE
## [291,]       FALSE
## [292,]       FALSE
## [293,]        TRUE
## [294,]        TRUE
## [295,]       FALSE
## [296,]       FALSE
## [297,]       FALSE
## [298,]       FALSE
## [299,]       FALSE
## [300,]       FALSE
## [301,]       FALSE
## [302,]       FALSE
## [303,]        TRUE
## [304,]        TRUE
## [305,]        TRUE
## [306,]       FALSE
## [307,]       FALSE
## [308,]        TRUE
## [309,]       FALSE
## [310,]       FALSE
## [311,]       FALSE
## [312,]       FALSE
## [313,]       FALSE
## [314,]        TRUE
## [315,]        TRUE
## [316,]        TRUE
## [317,]        TRUE
## [318,]       FALSE
## [319,]        TRUE
## [320,]       FALSE
## [321,]        TRUE
## [322,]       FALSE
## [323,]        TRUE
## [324,]       FALSE
## [325,]       FALSE
## [326,]        TRUE
## [327,]        TRUE
## [328,]        TRUE
## [329,]        TRUE
## [330,]       FALSE
## [331,]       FALSE
## [332,]       FALSE
## [333,]       FALSE
## [334,]        TRUE
## [335,]        TRUE
## [336,]       FALSE
## [337,]       FALSE
## [338,]        TRUE
## [339,]        TRUE
## [340,]        TRUE
## [341,]        TRUE
```


```r
colleges <- clean_names(colleges)
```

2. Which cities in California have the highest number of colleges?

```r
cities <- colleges %>%
  #count(city) %>%
  #arrange(desc(n))
  group_by(city) %>%
  summarise(num_colleges=n_distinct(instnm)) %>%
  arrange(desc(num_colleges))
```
Los Angeles

3. Based on your answer to #2, make a plot that shows the number of colleges in the top 10 cities.

```r
cities %>%
  slice_head(n=10) %>%
  ggplot(aes(x=city, y=num_colleges))+geom_col()
```

![](lab9_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

4. The column `COSTT4_A` is the annual cost of each institution. Which city has the highest average cost? Where is it located?

```r
colleges %>%
  group_by(city) %>%
  summarise(avg_cost=mean(costt4_a)) %>%
  arrange(desc(avg_cost))
```

```
## # A tibble: 161 × 2
##    city                avg_cost
##    <chr>                  <dbl>
##  1 Malibu                 66152
##  2 Valencia               64686
##  3 Redlands               61542
##  4 Moraga                 61095
##  5 Atherton               56035
##  6 Thousand Oaks          54373
##  7 Rancho Palos Verdes    50758
##  8 La Verne               50603
##  9 Belmont                50415
## 10 La Mirada              48857
## # … with 151 more rows
```
Malibu

5. Based on your answer to #4, make a plot that compares the cost of the individual colleges in the most expensive city. Bonus! Add UC Davis here to see how it compares :>).

```r
colleges %>%
  filter(city == "Malibu" | instnm == "University of California-Davis") %>%
  ggplot(aes(x=instnm, y=costt4_a))+geom_col()
```

![](lab9_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

6. The column `ADM_RATE` is the admissions rate by college and `C150_4_POOLED` is the four-year completion rate. Use a scatterplot to show the relationship between these two variables. What do you think this means?

```r
colleges %>%
  ggplot(aes(x=adm_rate, y=c150_4_pooled))+geom_point()
```

```
## Warning: Removed 251 rows containing missing values (`geom_point()`).
```

![](lab9_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->
There is a negative correlation, so the greater the admission rate, the more likely it is that students did not complete four-years of education. 

7. Is there a relationship between cost and four-year completion rate? (You don't need to do the stats, just produce a plot). What do you think this means?

```r
colleges %>%
  ggplot(aes(x=costt4_a, y=c150_4_pooled))+geom_point()
```

```
## Warning: Removed 225 rows containing missing values (`geom_point()`).
```

![](lab9_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->
There seems to be a relationship -- greater cost is associated with higher four-year completion rate. 

8. The column titled `INSTNM` is the institution name. We are only interested in the University of California colleges. Make a new data frame that is restricted to UC institutions. You can remove `Hastings College of Law` and `UC San Francisco` as we are only interested in undergraduate institutions.

```r
UC_institutions <- colleges %>%
  filter(grepl("University of California", instnm)) #%>%
  #filter(instnm != "University of California-Hastings College of Law" & instnm != "University of California-San Francisco")
```

Remove `Hastings College of Law` and `UC San Francisco` and store the final data frame as a new object `univ_calif_final`.

```r
univ_calif_final <- UC_institutions %>%
  filter(instnm != "University of California-Hastings College of Law" & instnm != "University of California-San Francisco")
```

Use `separate()` to separate institution name into two new columns "UNIV" and "CAMPUS".

```r
univ_calif_final <- univ_calif_final %>%
  separate(instnm, into = c("univ","campus"), sep="-")
```

9. The column `ADM_RATE` is the admissions rate by campus. Which UC has the lowest and highest admissions rates? Produce a numerical summary and an appropriate plot.

```r
univ_calif_final %>%
  group_by(campus) %>%
  summarise(admit_rate=adm_rate) %>%
  arrange(desc(admit_rate))
```

```
## # A tibble: 8 × 2
##   campus        admit_rate
##   <chr>              <dbl>
## 1 Riverside          0.663
## 2 Santa Cruz         0.578
## 3 Davis              0.423
## 4 Irvine             0.406
## 5 Santa Barbara      0.358
## 6 San Diego          0.357
## 7 Los Angeles        0.180
## 8 Berkeley           0.169
```
Riverside is highest, Berkeley is lowest. 


```r
univ_calif_final %>%
  ggplot(aes(x=campus, y=adm_rate))+geom_col()
```

![](lab9_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

10. If you wanted to get a degree in biological or biomedical sciences, which campus confers the majority of these degrees? Produce a numerical summary and an appropriate plot.

```r
univ_calif_final %>%
  group_by(campus) %>%
  summarise(num_of_deg=pcip26) %>%
  arrange(desc(num_of_deg))
```

```
## # A tibble: 8 × 2
##   campus        num_of_deg
##   <chr>              <dbl>
## 1 San Diego          0.216
## 2 Davis              0.198
## 3 Santa Cruz         0.193
## 4 Los Angeles        0.155
## 5 Riverside          0.149
## 6 Santa Barbara      0.108
## 7 Irvine             0.107
## 8 Berkeley           0.105
```


```r
univ_calif_final %>%
  ggplot(aes(x=campus, y=pcip26))+geom_col()
```

![](lab9_hw_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

## Knit Your Output and Post to [GitHub](https://github.com/FRS417-DataScienceBiologists)
