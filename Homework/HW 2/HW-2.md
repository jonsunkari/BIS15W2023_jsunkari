---
title: "Lab 2 Homework"
author: "Jonathan Sunkari"
date: "2023-01-17"
output: 
  html_document: 
    keep_md: yes
---



1. A vector in R is essentially a list, which can be assigned to an object by the syntax "obj <- c(x,y,z)"

2. A data matrix is multiple vectors together, or a vector of multiple vectors. 

3. 

```r
spring_1 <- c(36.25, 35.40, 35.30)
spring_2 <- c(35.15, 35.35, 33.35)
spring_3 <- c(30.70, 29.65, 29.20)
spring_4 <- c(39.70, 40.05, 38.65)
spring_5 <- c(31.85, 31.40, 29.30)
spring_6 <- c(30.20, 30.65, 29.75)
spring_7 <- c(32.90, 32.50, 32.80)
spring_8 <- c(36.80, 36.45, 33.15)
```

4 and 5. 

```r
scientists <- c('Jill', 'Steve', 'Susan')
springs_data <- c(spring_1,spring_2,spring_3,spring_4,spring_5,spring_6,spring_7,spring_8)

spring_matrix <- matrix(springs_data, nrow=8, byrow=TRUE)

springs <- c('Bluebell Spring', 'Opal Spring', 'Riverside Spring', 'Too Hot Spring', 'Mystery Spring', 'Emerald Spring', 'Black Spring', 'Pearl Spring')

colnames(spring_matrix) <- scientists
row.names(spring_matrix) <- springs

spring_matrix
```

```
##                   Jill Steve Susan
## Bluebell Spring  36.25 35.40 35.30
## Opal Spring      35.15 35.35 33.35
## Riverside Spring 30.70 29.65 29.20
## Too Hot Spring   39.70 40.05 38.65
## Mystery Spring   31.85 31.40 29.30
## Emerald Spring   30.20 30.65 29.75
## Black Spring     32.90 32.50 32.80
## Pearl Spring     36.80 36.45 33.15
```

6. 

```r
mean_temp <- rowMeans(spring_matrix)
mean_temp
```

```
##  Bluebell Spring      Opal Spring Riverside Spring   Too Hot Spring 
##         35.65000         34.61667         29.85000         39.46667 
##   Mystery Spring   Emerald Spring     Black Spring     Pearl Spring 
##         30.85000         30.20000         32.73333         35.46667
```

7. 

```r
spring_matrix <- cbind(spring_matrix, mean_temp)
spring_matrix
```

```
##                   Jill Steve Susan mean_temp
## Bluebell Spring  36.25 35.40 35.30  35.65000
## Opal Spring      35.15 35.35 33.35  34.61667
## Riverside Spring 30.70 29.65 29.20  29.85000
## Too Hot Spring   39.70 40.05 38.65  39.46667
## Mystery Spring   31.85 31.40 29.30  30.85000
## Emerald Spring   30.20 30.65 29.75  30.20000
## Black Spring     32.90 32.50 32.80  32.73333
## Pearl Spring     36.80 36.45 33.15  35.46667
```

8. 

```r
spring_matrix["Opal Spring", "Susan"]
```

```
## [1] 33.35
```

9. 

```r
Jill_values <- spring_matrix[springs, "Jill"]
Jill_mean <- mean(Jill_values)
Jill_mean 
```

```
## [1] 34.19375
```

10. 
Mean for Susan's values: 

```r
Susan_values <- spring_matrix[springs, "Susan"]
Susan_mean <- mean(Susan_values)
Susan_mean
```

```
## [1] 32.6875
```

