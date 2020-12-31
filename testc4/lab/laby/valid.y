%{
#include<stdio.h>
#include<stdlib.h>
%}

%token INT CH
%left '+' '-'
%right '*' '/'
%%
S:E {printf("valid expression");}
E:E'+'E|E'-'E|E'*'E|E'/'E|INT|CH;
%%
main()
{
yyparse();
}

yyerror(){}