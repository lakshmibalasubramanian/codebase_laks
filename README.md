# codebase

This is a repository specifically for lakshmi and manisha to store their codes.
The codebase will have a specific set of guidelines for the code files management. These will be updated once they have been discussed.

## Project management: Guidelines
1. The major chunks of the codebase are to be devided into separate rmd file.
2. The functions that are to be used by more than 1 rmd file are to be put in R folder and sourced in each rmd.
3. The plots are to be output in each rmd subfolder in the plots folder. (Though I do not like this paradigm because I am a fan of knitting the rmd file, so that the report is generated, and forwarding the philosophy of the literate programming). 
4. The intermediate outputs of each rmd that will be used as input by other rmd should be placed in outputs folder.
5. The codes should be able to process the raw data as an output from CellProfiler. There should be serial rmd files if need be numbered.

This space will grow. 
