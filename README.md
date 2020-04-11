
                                                   Automatic C-code Generator       
Problem statement :
                 Given an algorithm or a pseudocode as input, the automatic c-code generator converts the algorithm to its corresponding C code.
                 
                 
 Functionalities available:
 
 
•	Declaring and initialising variables


•	Use of variables only if declared


•	Operations : Arithmetic, logical, assignment ,relational


•	Reading input and printing output


•	Conditional statements


•	Looping statements ( while ,for ,do-while)


•	Functions and procedures


Tools used : Lex ,Yacc


Implementation:
                  This convertor has been constructed using lex and yacc . The keywords/ tokens are declared in the lex file.The productions and rules for converting algorithm to c code are implemented in yacc file.


Instructions:


lex lexcode.l       


yacc yacccode.y


gcc y.tab.c –lfl –ly  


./a.out
