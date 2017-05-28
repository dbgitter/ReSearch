# ReSearch
Program to calculate parallel resistances

                       ReSearch - The Resistor Search program 
                (Or How To Instantly Increase Your Resistor Inventory)


The average hobbyist might own a few resistor kits, but if you don't want to own every resistance value or are in a hurry to breadboard something and you need an exact resistance value, you will want to combine resistors to make up what you need.  But who wants to search through all their resistors every time then calculate the required value from what's on hand or worse yet to just get within 10 or 20%.  As we will find out, the key is knowing what's on hand.  

It turns out, you can figure it all out ahead of time!  You might ask, "Why would I do that, it would take far too much time!". But with a little up front work and the ReSearch program you can easily expand your list of resistance choices by many times.

One approach might be to compute all combinations of resistors in series and parallel.  That could produce a very large, complicated result.  My approach was to select certain combinations of resistors in parallel, calculate those and list the results.  Since it doesn't help much to combine very large values with very small ones , e.g, 1 megohm with 1 ohm, the values selected should be closer together.  Going from this principle, I chose to use sets of increasing value resistors, with the first in the set (lowest value), paired consecutively with each of the next higher values on the list.  This is done for the entire range of owned resistors in a moving window fashion.  Each set yields n values when including the value of the owned resistor and the value of combining the owned resistor with itself where n is two plus the number of consecutive owned resistors.  The program thus produces a new list of resistance values several times greater than the list of owned resistors .

As mentioned above, the key is knowing your owned resistor values.  It may seem to be a boring, tedious task, but making and keeping an up-to-date list of all your resistor values is the key to expanding your list many fold to say nothing of just knowing what you have on hand.  I have a few kits containing a total of 51 values, and it took me less than 10 minutes to create the list in a text file. So for just a little up front (and ongoing) effort I now have a list of about 600 resistance values to choose from. To make up any desired resistance, it is only necessary to choose the values from the new list and place them in series.

The code was generated and runs in MatLab and can be adapted to C or other languages and will be available on Github

The input format is a 1 column list of resistor values in a text file.  Engineering, scientific, integer or decimal format can be used (for MatLab).

The output shows a list of resistance values to use, the actual resistance found, and the actual tolerance achieved.

Please see the "unformatted" description text in ReSearch_Info.txt for the full description.  Use the raw format.

