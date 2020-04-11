alpha [a-zA-Z]
digit [0-9]
%%
"begin" return BEG;
"end" return END;
"int" { strcpy(yylval.code,yytext); return DATATYPE; }
"float" {strcpy(yylval.code,yytext);  return DATATYPE;}
"char" { strcpy(yylval.code,yytext); return DATATYPE; }
"double" { strcpy(yylval.code,yytext); return DATATYPE; }
"assign" return ASSIGN;
"to" return TO;
"print" return PRINT;
"scan" return SCAN;
"read" return READ;
"," return COMMA;
"(" return OPEN;
")" return CLOSE;
"if" return IF;
"then" return THEN;
"else" return ELSE;
"endif" return ENDIF;
"while" return WHILE;
"endwhile" return ENDWHILE;
"enddowhile" return ENDDOWHILE;
"do" return DO;
"for" return FOR;
"from" return FROM;
"repeat" return REPEAT;
"return" return RETURN;
"endfor" return ENDFOR;
"\"" return QUOTE;
"true" { strcpy(yylval.code,yytext); return BOOL; }
"false" { strcpy(yylval.code,yytext); return BOOL; }
"<=" { strcpy(yylval.code,yytext); return RELOP;}
">=" { strcpy(yylval.code,yytext); return RELOP; }
"==" { strcpy(yylval.code,yytext); return RELOP; }
"!=" { strcpy(yylval.code,yytext); return RELOP; }
"<" { strcpy(yylval.code,yytext); return RELOP; }
">" { strcpy(yylval.code,yytext); return RELOP; }
"&&" { strcpy(yylval.code,yytext); return LOGOP; }
"||" { strcpy(yylval.code,yytext); return LOGOP; }
"+" { strcpy(yylval.code,yytext); return AS; }
"-" { strcpy(yylval.code,yytext); return AS; }
"*" { strcpy(yylval.code,yytext); return MD; }
"/" { strcpy(yylval.code,yytext); return MD; }
"=" { strcpy(yylval.code,yytext); return Q; }
"start_procedure"    return START_PROCEDURE;
"end_procedure"    return END_FUNCTION;
{alpha}({alpha}|{digit})*  {strcpy(yylval.code,yytext); return VAR; }
{alpha}({alpha}|{digit})*/[(] { strcpy(yylval.code,yytext); return NAME_PROCEDURE;}
[0-9]+ { strcpy(yylval.code,yytext); return NUM; }
%%


