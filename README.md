# modleR_tests



Codes for testing the functions in modleR package

1. setupsdmdata_tests.Rmd
- tests different buffer types- done

2. buffer_and_randomPoints.Rmd
- tests different buffer types- done
- still needs to test user defined buffer- done
- there's a problem with "user" and `min_dist`

3. projection.Rmd 
- tests projection in do_many and final_models- done
- still having problems in the last chunk- When eval = FALSE it works. All outputs were done.
  

4. Euclidean_distance.Rmd
- an early version is calculating and projecting in the same step but this needs to be split into a function and its predict method.

5. solved
+ small_dataset.Rmd was solved by changing the resampling within the buffer (by calculating thenumber of available cells in the buffer)
+ meridiano_180 appeared when the occurrence points were around lon = 180 - buffer did not calculate correctly the distances between points. this should be checked again, however. 

