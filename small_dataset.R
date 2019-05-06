---
title: "Testing setupsdmdata with small dataset in Model-R"
author: "Andrea Sánchez-Tapia"
date: "`r Sys.Date()`"
output:
    html_document: default
pdf_document: default
---


    ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, message = F, warning = T)
```

```{r load}
library(rJava)
library(raster)
#library(ModelR)
#eu estou usando uma cópia local para desenvolvimento
devtools::load_all("../../ModelR")
#mas o pacote pode ser instalado assim:
#devtools::install_github("model-r/modelr_pkg", build_vignettes = TRUE, ref = "andrea")

```

# We use a standard dataset

```{r dataset}
especies <- unique(coordenadas$sp)
coord1sp <- dplyr::filter(coordenadas, sp == especies[1])
head(coord1sp)
dim(coord1sp)
ceiling(0.7 * nrow(coord1sp))
set <- sample(1:nrow(coord1sp), size = ceiling(0.7 * nrow(coord1sp)))
train_set <- coord1sp[set,]
test_set <- coord1sp[setdiff(1:nrow(coord1sp),set),]

```

```{r plotdataset}
predictor <- example_vars[[1]]
pts <- SpatialPoints(coord1sp[,c(2,3)])
plot(predictor, legend = F)
points(train_set[,2:3], col = "red", pch = 19)
points(test_set[,2:3], col = "blue", pch = 19)

```

# Function arguments

```{r args, echo = F}
args(setup_sdmdata)
```


```{r remedy001}

a <- setup_sdmdata(species_name = especies[1],
                   occurrences = coord1sp[,-1],
                   predictors = example_vars,
                   models_dir = "./setupsdmdatam",
                   real_absences = NULL,
                   buffer_type = NULL,
                   clean_dupl = T,
                   clean_nas = T,
                   seed = 512)
```


```{r remedy002}
head(a)
```

```{r remedy003}

knitr::include_graphics("./setupsdmdatam/Eugenia florida DC./present/partitions/sdmdata_Eugenia florida DC..png")


```

#### buffer mean

```{r remedy0031}

a <- setup_sdmdata(species_name = especies[1],
                   occurrences = coord1sp[,-1],
                   predictors = example_vars,
                   models_dir = "./setupsdmdatan",
                   real_absences = NULL,
                   buffer_type = "mean",
                   clean_dupl = T,
                   clean_nas = T,
                   seed = 512)
```


```{r remedy004}
head(a)
```

```{r remedy0061}

knitr::include_graphics("./setupsdmdatan/Eugenia florida DC./present/partitions/sdmdata_Eugenia florida DC..png")

```


#buffer median

```{r remedy005}

a <- setup_sdmdata(species_name = especies[1],
                   occurrences = coord1sp[,-1],
                   predictors = example_vars,
                   models_dir = "./setupsdmdatap",
                   real_absences = NULL,
                   buffer_type = "median",
                   clean_dupl = T,
                   clean_nas = T,
                   seed = 512)
```


```{r remedy006}
head(a)
```

```{r remedy009}

knitr::include_graphics("./setupsdmdatap/Eugenia florida DC./present/partitions/sdmdata_Eugenia florida DC..png")

```

#buffer max

```{r remedy0051}

a <- setup_sdmdata(species_name = especies[1],
                   occurrences = coord1sp[,-1],
                   predictors = example_vars,
                   models_dir = "./setupsdmdatax",
                   real_absences = NULL,
                   buffer_type = "max",
                   clean_dupl = T,
                   clean_nas = T,
                   seed = 512)
```


```{r remedy0062}
head(a)
```

```{r remedy0092}

knitr::include_graphics("./setupsdmdatax/Eugenia florida DC./present/partitions/sdmdata_Eugenia florida DC..png")

```

#buffer dist

```{r remedy00512}

a <- setup_sdmdata(species_name = especies[1],
                   occurrences = coord1sp[,-1],
                   predictors = example_vars,
                   models_dir = "./setupsdmdataxd",
                   real_absences = NULL,
                   buffer_type = "distance",
                   dist_buf = 4,
                   clean_dupl = T,
                   clean_nas = T,
                   seed = 512)
```


```{r remedy00622}
head(a)
```

```{r remedy00922}

knitr::include_graphics("./setupsdmdataxd/Eugenia florida DC./present/partitions/sdmdata_Eugenia florida DC..png")

```
