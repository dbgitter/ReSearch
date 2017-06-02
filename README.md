# ReSearch
Program to calculate parallel resistances

                       ReSearch - The Resistor Search program 
                (A Practical Way To Instantly Increase Your Resistor Inventory)

The ReSearch program allows the user to pre-calculate parallel resistance values from resistors on hand (owned).  The search depth determines the size of each combination set. A combination set is the group of resistors which will be paired to form the parallel resistor calculations.

The code was generated and runs in MatLab and can be adapted to C or other languages.

The owned resistor input format is a 1 column list of resistor values in a text file.  Engineering, scientific, integer or decimal format can be used.

The user inputs the owned resistor file name, search depth, desired resistance, and desired tolerance.

The output shows a list of resistance values to use, the actual resistance found, and the actual tolerance achieved.

The output list could also be used recursively to generate even larger lists of parallel combinations.

This program is useful in determining the respective series/parallel capacitance and inductance calculations as well.

Please see the "unformatted" text in ReSearch_Info.txt for the full description.  Use the raw format.
