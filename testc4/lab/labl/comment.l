%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
int state=0;
int state1=0;
int lines=0;
%}

%%
"//"  {lines++;state1=1;}
"/*"  {state=1;}
"*/"  {if (state==1){state=0;lines++;} }  
\n  {if(state1==1)state1=0; if(state==1)lines++;else{fprintf(yyout,"\n");} }
.  {if(state==0 && state1==0)fprintf(yyout,"%s",yytext);}
%%

main()
{
yyin=fopen("f.txt","r");
yyout=fopen("Desktop/f.txt","w");
yylex();
printf("Comment lines:%d",lines);
}

yywrap(){}