%{ 
#include<stdio.h>
#include<stdlib.h>
int ids=0;
%}

types ("int"|"float"|"char"|"double")
alpha [a-zA-Z_]
alnum [a-zA-Z0-9]

%%

{types}[ ]+({alpha}{alnum}*[,][ ]*)*{alpha}{alnum}*[;] {
 int i;
 for(i=0;yytext[i]!='\0';i++)
 {
  if(yytext[i]==',' || yytext[i]==';')ids++;
 }
}

.|\n ;

%%

main()
{
yylex();
printf("ids: %d",ids);
}

yywrap(){}