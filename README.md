# Detecting Exception Handling Bugs in Commercial Cyber-Physical System Development Tool Chain

We propose a method called CATCH for detecting exception handling bugs in Commercial Cyber-PhysicAl System development Tool CHain (e.g. MATLAB/Simulink).We present following three independant tools in this repository:

- [Preprocessing component](slsf/AntecedentExperimentCheck.m)
- [Equivalent variation component](slsf/)
- [Differential testing component](slsf/AntecedentExperimentResultCheck.m)

## RQ3 Bug

Here we list all the bug in  article CATCH RQ3:
06595341 Propagation Delay block has inconsistent display of "nan" in different modes
06595343 The compiler error pointing to PID block in the model is not perfect
06597462 The data output accuracy of the model is inconsistent in different modes
06597463 The block has inconsistent symbol display for the data result "0" in different modes
06597517 The model has inconsistent representation of data results in different system acceleration modes
06600624 MSLException has fuzzy identifier definition after model exception
06600852 The model detects the presence of inconsistent warning information after overflow modification
06607358 The model handles inconsistent cases of Unary Minus in MSLException under exception handling
06607962 The model shows consistent handle data in MSLException under exception handling, but it is relatively inconsistent
06617288 blocks on the non-execution path of the model induce exception handling false positives
06617290 The equivalent model has inconsistent exception propagation during exception handling

To see more detail about bug file , click this [BugFile](confirm bugs/)

## Requirements

MATLAB Simulink R2023b with default Simulink toolboxes

## Installation

Please use `git` to properly install all third-party dependencies:

    git clone <REPO URL>
    cd <REPO>
    git submodule update --init
    matlab # Opens MATLAB

## Hello, World!
### seed Model Creation  
We improved SLforge in Simulink R2023b with a modified adaptation.You can use:

  sgtest
  
To create Simulink models，and more details can be changed in the cfg.m file.
### Preprocessing 
For generated SLforge or realistic models, place them in the error folder under each date unit folder in reprotsneo (no action if generated by SLforge).
At the command line, type:

  AntecedentExperimentCheck
  
The results will be displayed in the resultfile.txt file
### Equivalent variation component 
Use the following instructions to add the equivalent mutation model to the model：
  
  AntecedentExperimentAddBlock

Use the following instructions to add an equivalent mutation strategy to the model：

(CIC)
  AntecedentExperimentIdentIfierCheck 
(CBR)
  AntecedentExperimentThrowCheck
(CBI)
  AntecedentExperimentTryCatchCheck
  
### Differential testing component
Use the following instructions to differential testing the model：

  AntecedentExperimentResultCheck
  
All possible bugs will be displayed in difffile.txt, and demo.m will record the identifier type, time, and location of each occurrence.
## Randomly Generated Seed Models And Compare In EMI Mode

We use the open source *SLforge* tool to generate valid Simulink models. 

### SLforge: Automatically Finding Bugs in a Commercial Cyber-Physical Systems Development Tool

Check out [SLforge homepage](https://github.com/verivital/slsf_randgen/wiki) for latest news, running the tools and to contribute.
