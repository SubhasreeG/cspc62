%{
#include<stdio.h>
%}
 
%%

[+]    {printf("Addition %s\n",yytext);}
[-]    {printf("Subtraction %s\n",yytext);}
[*]    {printf("Multiplication %s\n",yytext);}
[/]    {printf("Division %s\n",yytext);}
[%]    {printf("Modulo %s\n",yytext);}
\>\>   {printf("Right Shift %s\n",yytext);}
\<\<   {printf("Left Shift %s\n",yytext);}
[~]    {printf("Compliment %s\n",yytext);}
[,]    {printf("Comma %s\n",yytext);}
[=]    {printf("Assignment %s\n",yytext);}     
[\^]   {printf("XOR %s\n",yytext);} 
&&     {printf("AND %s\n",yytext);}    
\|\|   {printf("OR %s\n",yytext);}      
[&]    {printf("Bitwise AND %s\n",yytext);}
[|]    {printf("Bitwise OR %s\n",yytext);}     
[!]    {printf("Not %s\n",yytext);}   
[>]    {printf("Greater than %s\n",yytext);}      
[<]    {printf("less than %s\n",yytext);}            
.      {printf("");}

%%

int yywrap(void)
{
    return 1;
}  

int main()
{
    yylex();
    return 0;
}