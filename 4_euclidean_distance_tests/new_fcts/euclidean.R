# Author: Robert J. Hijmans
# contact: r.hijmans@gmail.com
# Date : December 2009
# Version 0.1
# Licence GPL v3

#sets class, it inherits distmodel. representation in domain is vector, in mahalanobis is matrix (cov = 'matrix')
setClass(
    'Euclidean',
    contains = 'DistModel',
    representation(#deprecated
    #slots = c(
        type = "vector",
              centroid = 'vector'),
    prototype(),
    validity = function(object)	{
        return(TRUE)
    }
)
#generic method in both is related to a x that is the raster, and a p, that are the points
if (!isGeneric("euclidean")) {
    setGeneric("euclidean", function(x, p, ...)
        standardGeneric("euclidean"))
}

#we have five cases of use in both functions
# 1 raster and matrix
# 2 raster and data.frame
# 3 matrix and missing,
# 4 data.frame and missing
# 5 raster and spatial points

#domain runs like this
# 1 raster and matrix: extract then domain(as.data.frame())
# 2 raster and data.frame: extract then domain(as.data.frame())
# 3 matrix and missing, domain(as.data.frame()) (so the matrix is a value matrix that comes from extract)
# 5 raster and spatial points - as.dta.frame de los spatialPoints
# 4 data.frame and missing - THIS IS WHERE DOMAIN RUNS: can add factors but if not it will extract factors from x colnames
#checks dimensions, calculates range
#creates a d object new("Domain")
# fills the slots

#MAHAL:
# 1 raster and matrix extract mahal
# 2 raster and data.frame extract mahal
# 3 matrix and missing, mahal as dataframe
# 5 raster and spatial points extract and mahal
# 4 data.frame and missing IDEM this is where it works (on a data.frame)

#!!! so i should be able to execute the function on a data.frame by default. the extract one and then calculate

# 1
setMethod('euclidean',
          signature(x = 'Raster', p = 'matrix'),
          function(x, p, ...) {
              e <- extract(x, p)
              euclidean(as.data.frame(e))
          })
#2 raster and dataframe
setMethod('euclidean',
          signature(x = 'Raster', p = 'data.frame'),
          function(x, p, ...) {
              e <- extract(x, p)
              euclidean(e)#checar se e dataframe mesmo estou assumindo que sim mas talvez depende do output do extract
          })

#3 matrix and missing
setMethod('euclidean',
          signature(x = 'matrix', p = 'missing'),
          function(x, p, ...) {
              euclidean(as.data.frame(x))#checar se e dataframe mesmo
          })

#5
setMethod('euclidean', signature(x = 'Raster', p = 'SpatialPoints'),
          function(x, p, ...) {
              e <- extract(x, p)
              euclidean(e, ...)
          })

#4 the good method
setMethod('euclidean', signature(x = 'data.frame', p = 'missing'),
          function(x, p, type = "centroid", ...) {
              for (i in ncol(x):1) {
                  if (is.factor(x[, i])) {
                      warning(
                          'variable "',
                          colnames(x)[i],
                          '" was removed because it is a factor (categorical)'
                      )
                      x <- x[, -i]
                  }
              }
              if (ncol(x) == 0) {
                  stop('no usable variables')
              }

              e <- new('Euclidean')

              e@type <- type
              e@centroid <-
                  apply(x, 2, mean, na.rm = TRUE) #hay una parte donde hay un if is null y puede dar nulo y ya, esto seria nulo si type = mindist

                  x <- stats::na.omit(x)
              if (ncol(x) == 0) {
                  stop('no usable variables')
              }
              if (nrow(x) < 2) {
                  stop('insufficient records')
              }

              e@presence <- x #the dataframe with na.omit
              #d@factors <- factors #the names of the columns that are factors solo domain
              #d@range <- #the absolute value of domain range for each variable (that is a vector of length 1 set in representation) solo domain

              #if there are variables with a range of zero it takes away the corresponding columns and redefines a@presence and d@range
              #checks the final dimension of d@presence


              #e@vals <- apply(v, 1, FUN = function(x) {
               #   d <- dist(rbind(centroid.val, x))
              #}
                #  vals <- -d
                  #¿pero acá qué es v? seguir mañana.
                  e
          }
)
#table <- extract(coord1sp[,])
ee <- euclidean(x = example_vars, p = coord1sp[,c(2,3)])
is(ee)
