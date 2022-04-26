%{

#include<stdio.h>
#include<string.h>
  
char replace_with [] = "double";
char to_replace [] ="float";
    
%}

  
%%
[a-zA-Z]+    { if(strcmp(yytext, to_replace)==0)
                   fprintf(yyout, "%s", replace_with);
                else
                    fprintf(yyout, "%s", yytext);}
.            fprintf(yyout, "%s", yytext);
%%
  
  
int yywrap()
{
    return 1;
}
  
int main()
{
    extern FILE *yyin, *yyout;         
    yyin=fopen("input.c", "r");
    yyout=fopen("output.c", "w");      
    yylex();
}