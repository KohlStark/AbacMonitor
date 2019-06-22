# ABAC Monitor project description


Contained in this repository is a working ABAC (Attribute Based Access Control) generator based on a user defined policy.
It is required that a user provide an example policy when running this code, a couple of example policies are attached to show the format.

The user must specify Attributes, Permission, PA's, Entities, and A's in the format of the example .txt files. Once an example policy
is specified, the user may ask the ABAC monitor simple commands which are specified in the Sample_commands.pdf. 

Also attached in the repository is a makefile that builds an executable version of the ABAC Monitor using the AbacMonitor.py file.
Once the abacmonitor executable has been created, sample commands look like this:

./abacmonitor "load-policy Example-ASU.txt; add-attributes-to-permission PW role Student; check-permission Josie GradesFile ENV PW"

./abacmonitor "load-policy Example-ASU.txt; check-permission Josie GradesFile ENV PW"

./abacmonitor "load-policy Example-Entering-Bar.txt; check-permission User Bar ENV PE"

./abacmonitor "load-policy Example-Entering-Bar.txt; remove-attribute age; check-permission User Bar ENV PE"

./abacmonitor "load-policy Example-Space-Sensitive.txt; check-permission Josie S_App ENV PlayPermission"

./abacmonitor "load-policy Example-Space-Sensitive.txt; check-permission Kyle S_App ENV PlayPermission"

which always yeild either Permission GRANTED! or Permission DENIED!

Also attached is a run.sh script, an input, and an output folder. The run.sh script runs the AbacMonitor.py file against the 
.txt files in the input folder and compares the results of the AbacMonitor.py output to the .txt files in the output folder. 
This is to check if the ABAC monitor is representing policies correctly.


