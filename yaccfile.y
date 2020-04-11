%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int i=0,j,g;
char sym[100][100];
char str[100];
char ints[]={'%','d','\0'};
char floats[]={'%','f','\0'};
char chars[]={'%','c','\0'};
char doubles[]={'%','l','d','\0'};
char name[100];
void update(char s[20])
{
strcpy(sym[i],s);
i++;
}
int check(char s[20])
{
int flag=0;
for(j=0;j<i;j++)
{
if(!strcmp(sym[j],s))
flag=1;
}
return flag;
}
void getspec(char s[20])
{
//char str1[100];
if(!strcmp(s,"int"))
  strcpy(str,ints);
else if(!strcmp(s,"float"))
  strcpy(str,floats);
else if(!strcmp(s,"char"))
  strcpy(str,chars);
else if(!strcmp(s,"double"))
  strcpy(str,doubles);
}
%}
%union{
char code[100];
}
%token BEG END ASSIGN TO PRINT SCAN COMMA OPEN CLOSE IF ENDIF THEN ELSE WHILE ENDWHILE DO RETURN
%token START_PROCEDURE END_FUNCTION ENDDOWHILE FOR REPEAT ENDFOR FROM READ QUOTE
%token<code> VAR NUM
%token<code> DATATYPE
%token<code> RELOP LOGOP BOOL
%token<code> MD AS Q
%token<code> NAME_PROCEDURE

%%
START :  BEG {printf("\n#include<stdio.h>\nvoid main()\n{\n");} CODE END { printf("\n}\nValid"); exit(0); }
      ;      
CODE : STMT  {printf(";");}
     | CODE STMT {printf(";");}
     | ST
     | CODE ST
     ;


STMT : EXPR
     | DEC		
     | INIT	
     ;

ST   : IF {printf("if(");} CON THEN{printf(")\n{");} CODE ENDIF {printf("\n}");}
     | IF { printf("if(");} CON THEN{printf(")\n{");} STMT ELSE { printf("}\nelse\n{");} STMT ENDIF {printf("\n}");}
     | WHILE{printf("while(");} EXPR THEN{printf(")\n{\n");} CODE ENDWHILE {printf("\n}");}
     | DO{printf("do\n{");} CODE WHILE{printf("\n}while(");} EXPR ENDDOWHILE {printf(");");}
     | START_PROCEDURE NAME_PROCEDURE OPEN{printf("void %s(",$2); } parameter_list CLOSE{printf(")\n{\n");} CODE END_FUNCTION {printf("}");}
     | FOR{printf("for(");} INIT REPEAT{printf("\n{\n");} CODE ENDFOR {printf("\n}\n");}  
     | PR
     | SC
     ;	

parameter_list: VAR DATATYPE{printf("%s %s",$2,$1);}
               | parameter_list COMMA VAR DATATYPE{printf(",%s %s",$4,$3);}

EXPR : E RELOP{printf("%s",$2); } E
     | E LOGOP{printf("%s",$2); } E  
     | E		
     ;

E : E AS{printf("%s",$2);} T  
  | T	
  ;

T : T MD{printf("%s",$2);} F    
  | F 
  ;

F : VAR {printf("%s",$1);} 
  | NUM	{printf("%s",$1);} 
  | OPEN E CLOSE
  ;

N : VAR{printf("%s",$1);} N
  |
  ;

DEC : ASSIGN OPEN VAR DATATYPE CLOSE { update($3); printf("%s %s",$4,$3); };
  
INIT : ASSIGN VAR TO NUM {g=check($2); if(g==1)printf("%s = %s",$2,$4); else exit(0);}
     | ASSIGN VAR TO VAR { printf("%s = %s",$2,$4); }
     | VAR FROM NUM TO NUM {if($3<$5){printf("%s = %s ; %s <= %s ; %s ++)",$1,$3,$1,$5,$1);}else{printf("%s = %s ; %s >= %s ; %s --)",$1,$3,$1,$5,$1);}}
     | VAR Q{printf("%s %s",$1,$2);} E 
     ;

DATA : DATATYPE COMMA VAR{g=check($3); getspec($1); if(g==1){printf("%s ",str); strcat(name,$3);} else exit(0); } DATA
     |
     ;

PR : PRINT DATATYPE COMMA VAR {g=check($4); getspec($2); if(g==1)printf("printf(\"%s\",%s);\n",str,$4); else exit(0); }
   | PRINT{printf("printf(\"");} QUOTE N DATA N QUOTE{printf("\"%s);",name); strcpy(name,"");}
   | PRINT{printf("printf(\"");} QUOTE N QUOTE{printf("\");");} 
   ;

SC : READ DATATYPE COMMA VAR {g=check($4); getspec($2); if(g==1)printf("scanf(\"%s\",&%s);\n",str,$4); else exit(0); }
   ;

CON : VAR RELOP VAR { printf("%s %s %s",$1,$2,$3); } 
    | VAR RELOP NUM { printf("%s %s %s",$1,$2,$3); }
    | VAR LOGOP VAR { printf("%s %s %s",$1,$2,$3); }
    | BOOL { printf("%s",$1); }
    ;


 

%%
#include"lex.yy.c"
int main()
{
yyin=fopen("inputnew1.txt","r");
printf("Enter the expr");
yyparse();
return 0;
}






