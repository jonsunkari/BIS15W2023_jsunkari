---
title: "Lab 11 Homework"
author: "Jonathan Sunkari"
date: "2023-02-21"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

**In this homework, you should make use of the aesthetics you have learned. It's OK to be flashy!**

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
#install.packages("tidyverse", "janitor", "here", "naniar")

library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

## Resources
The idea for this assignment came from [Rebecca Barter's](http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/) ggplot tutorial so if you get stuck this is a good place to have a look.  

## Gapminder
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use. This is the same data that we will use for midterm 2 so this is good practice.

```r
install.packages("gapminder")
```

```
## Installing package into '/cloud/lib/x86_64-pc-linux-gnu-library/4.2'
## (as 'lib' is unspecified)
```

```r
library("gapminder")
```

## Questions
The questions below are open-ended and have many possible solutions. Your approach should, where appropriate, include numerical summaries and visuals. Be creative; assume you are building an analysis that you would ultimately present to an audience of stakeholders. Feel free to try out different `geoms` if they more clearly present your results.  

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine how NA's are treated in the data.**  

```r
gapminder <- read_builtin("gapminder")
glimpse(gapminder)
```

```
## Rows: 1,704
## Columns: 6
## $ country   <fct> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", …
## $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, …
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 1997, …
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 40.8…
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372, 12…
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.1134, …
```

```r
any_na(gapminder)
```

```
## [1] FALSE
```

**2. Among the interesting variables in gapminder is life expectancy. How has global life expectancy changed between 1952 and 2007?**

```r
gapminder %>%
  group_by(year) %>%
  summarise(avg_LE=mean(lifeExp)) %>%
  ggplot(aes(x=year, y=avg_LE))+
  geom_line()+
  labs(title="Life Expectancy from 1952 to 2007", y="Life Expectancy")
```

![](lab11_hw_files/figure-html/unnamed-chunk-4-1.png)<!-- -->
It has increased. 

**3. How do the distributions of life expectancy compare for the years 1952 and 2007?**

```r
gapminder %>%
  filter(year==1952) %>%
  ggplot(aes(x=lifeExp))+
  geom_histogram(aes(y = ..density..), fill = "coral", alpha = 0.4, color = "black")+
  geom_density(color = "gray")+
  labs(title="Life Expectancy Distribution in 1952")
```

```
## Warning: The dot-dot notation (`..density..`) was deprecated in ggplot2 3.4.0.
## ℹ Please use `after_stat(density)` instead.
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](lab11_hw_files/figure-html/unnamed-chunk-5-1.png)<!-- -->



```r
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=lifeExp))+
  geom_histogram(aes(y = ..density..), fill = "deepskyblue4", alpha = 0.4, color = "black")+
  geom_density(color = "gray")+
  labs(title="Life Expectancy Distribution in 2007")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](lab11_hw_files/figure-html/unnamed-chunk-6-1.png)<!-- -->
Life Expectancy is much higher in 2007 than 1952, with the average being around 70-80. 

**4. Your answer above doesn't tell the whole story since life expectancy varies by region. Make a summary that shows the min, mean, and max life expectancy by continent for all years represented in the data.**

```r
gapminder %>%
  select(continent, lifeExp, year) %>%
  group_by(year, continent) %>%
  summarise(min_LE=min(lifeExp), max_LE=max(lifeExp), mean_LE=mean(lifeExp), .groups = "keep")
```

```
## # A tibble: 60 × 5
## # Groups:   year, continent [60]
##     year continent min_LE max_LE mean_LE
##    <int> <fct>      <dbl>  <dbl>   <dbl>
##  1  1952 Africa      30     52.7    39.1
##  2  1952 Americas    37.6   68.8    53.3
##  3  1952 Asia        28.8   65.4    46.3
##  4  1952 Europe      43.6   72.7    64.4
##  5  1952 Oceania     69.1   69.4    69.3
##  6  1957 Africa      31.6   58.1    41.3
##  7  1957 Americas    40.7   70.0    56.0
##  8  1957 Asia        30.3   67.8    49.3
##  9  1957 Europe      48.1   73.5    66.7
## 10  1957 Oceania     70.3   70.3    70.3
## # … with 50 more rows
```

```r
  #If you want the plot:
  #mutate(year=as.factor(year)) %>%
  #ggplot(aes(x=year, y=lifeExp, fill=continent))+
  #geom_boxplot(alpha=0.4)+
  #labs(title="Life Expectancy by Continent for all Years", y="Life Expectancy")
```


**5. How has life expectancy changed between 1952-2007 for each continent?**

```r
gapminder %>%
  group_by(year, continent) %>%
  summarise(avg_le=mean(lifeExp), .groups="keep") %>%
  ggplot(aes(x=year, y=avg_le, color=continent, group=continent))+
  geom_line()+
  labs(title="Life Expectancy by Continent Between 1952-2007", y="Life Expectancy")
```

![](lab11_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->


**6. We are interested in the relationship between per capita GDP and life expectancy; i.e. does having more money help you live longer?**

```r
gapminder %>%
  ggplot(aes(x=gdpPercap, y=lifeExp))+
  geom_point()
```

![](lab11_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->
Only up to a gdp per capita of 30000 does more money help you live longer.

**7. Which countries have had the largest population growth since 1952?**

```r
gapminder %>%
  select(country, year, pop) %>%
  filter(year==1952|year==2007) %>%
  pivot_wider(names_from = year, names_prefix = "yr", values_from = pop) %>%
  mutate(delta=yr2007-yr1952) %>%
  arrange(desc(delta)) #Output: China, India, Indonesia, USA, Brazil
```

```
## # A tibble: 142 × 4
##    country          yr1952     yr2007     delta
##    <fct>             <int>      <int>     <int>
##  1 China         556263527 1318683096 762419569
##  2 India         372000000 1110396331 738396331
##  3 United States 157553000  301139947 143586947
##  4 Indonesia      82052000  223547000 141495000
##  5 Brazil         56602560  190010647 133408087
##  6 Pakistan       41346560  169270617 127924057
##  7 Bangladesh     46886859  150448339 103561480
##  8 Nigeria        33119096  135031164 101912068
##  9 Mexico         30144317  108700891  78556574
## 10 Philippines    22438691   91077287  68638596
## # … with 132 more rows
```


**8. Use your results from the question above to plot population growth for the top five countries since 1952.**

```r
gapminder %>%
  filter(country=="China"|country=="India"|country=="Indonesia"|country=="United States"|country=="Brazil") %>%
  select(country, year, pop) %>%
  ggplot(aes(x=year, y=pop, color=country))+
  geom_line()+
  labs(title="Population Growth Trends for Top Five Countries")
```

![](lab11_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->


**9. How does per-capita GDP growth compare between these same five countries?**

```r
gapminder %>%
  filter(country=="China"|country=="India"|country=="Indonesia"|country=="United States"|country=="Brazil") %>%
  ggplot(aes(x=year, y=gdpPercap, color=country))+
  geom_line()+
  labs(title="Per-capita GDP Growth per Year by Country")
```

![](lab11_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->


**10. Make one plot of your choice that uses faceting!**
## Didn't go over faceting yet

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
