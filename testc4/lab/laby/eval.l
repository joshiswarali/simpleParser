%{ 
#include"eval.tab.h"
  extern int yylval;
%}

%%
[0-9]+ {yylval=atoi(yytext); return INT;}
[a-zA-Z_]+ {return CH;}
[\+\-*/()\n] return *yytext;
[\t] ;

%%

yywrap(){}