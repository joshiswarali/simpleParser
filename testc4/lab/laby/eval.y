%{
  #include<stdio.h>
  #include<stdlib.h>
%}

%token INT CH
%left '+' '-'
%right '*' '/'

%%
S:E  {printf("%d", $$);}
E:INT   
  |CH
  |E'+'E {$$ = $1 + $3  ;}
  |E'-'E {$$ = $1 - $3 ;}
  |E'*'E {$$ = $1 * $3 ;}
  |E'/'E {if(($3)!=0)$$=$1/$3; else {printf("divide by 0\n"); exit(0);}}
%%

main()
{
yyparse();
}

yyerror(){}