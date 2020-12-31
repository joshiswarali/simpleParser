%{
    
#include <stdio.h>
    
#include <stdlib.h>

    
extern FILE *yyin;

int id=0;
%}


%token IF VARIABLE COMP UNARY NUM BIN



%%

S: forloop  {printf("valid statement");}   

 |;
forloop:IF '(' expr ')' '{'
 stats '}' {id++;}



stats: stat stats
     |;
stat: VARIABLE '=' expr ';'|forloop
expr: expr BIN expr |VARIABLE|NUM
%%



yyerror() 
{
 printf("Invalid statement\n");
    
exit(1);

}



int main(int argc, char* argv[]) 
{
    
/*if (argc < 2) 
{
        
printf("Usage: ./run input\n");
        
return 1;
    
}

 */   

//yyin = fopen(argv[1], "r");
    
yyparse();
    
    
printf("num=%d",id);
return 0;

}
