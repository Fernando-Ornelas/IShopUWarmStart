# IShopUWarmStart
Source Code

Folder Guidelines
x = {1...5}
zzzz = {Short, Medium, Large}
zz = {S, M, L}
yyy = {GA, CGA, WCA}

For the development of this chapter, the following uniform instances were used:

Short (10 products and 25 stores)
Medium (25 products and 50 stores)
Large (50 products and 100 stores)

They are presented under the following names:

Uniform(zzx).csv
can be found in the folder \yyy\zzzz\zzx

From the instances, a results file was generated using JDK-11.0.2 version, as follows:

java Test(yyy) Uniform(zzx).csv

Generating a file containing the objective value of 30 executions and the best candidate solution found by the algorithm. This file can be viewed within the folder (zzx) generated in the folder \yyy\zzzz\zzx

In the case of the genetic algorithm and the cellular genetic algorithm, respectively

(zzx)_1.0M_0.05C.csv               
(zzx)_1.0M_0.05C_CGA.csv

The values 1.0M and 0.05C indicate 1.0 mutation and 0.05 crossover for both algorithms, with 250 generations and 100 individuals.

In the case of the Water Cycle Algorithm
zzx_100PS_25000ME_WCA.csv

In this algorithm, the mutation and crossover settings are fixed as recommended by the author. Additionally, 250 generations and 100 individuals were executed.

The OPL project developed in CPLEX can be found in the \ISHOP-U folder along with the uniform instances. To generate the LP files, simply load the project into CPLEX and in the execution settings in ISHOP-U.ops Language\Run, select Export format LP, and run the OPL code. An LP file will be generated.

For the present research, an LP file was generated for each uniform instance, resulting in 15 LP files. The generated LP files can be viewed within the folders \yyy\zzzz\

After this, an MST file was generated for each instance size in the interactive optimizer. Below, we present the instructions used in the aforementioned folder 

C:\yyy\zzzz\>CPLEX
CPLEX>read ISHOP-U_(zzx).lp
CPLEX>write (zzzz).mst

The file was taken as a template for generating each warm start, as this format is required to be recognized by the interactive optimizer of CPLEX. Therefore, a Java program was developed for this task.

java ReadFiles (zzx)_1.0M_0.05C.csv (zzzz).mst

Having all the files for the warm start, the following steps were taken

C:\yyy\zzzz\>CPLEX
CPLEX>read ISHOP-U_zzx.lp
CPLEX>read zzx_yyy.mst
CPLEX>optimize

If we desire only a cold start, we simply load the interactive optimizer, read the LP file, and optimize.
