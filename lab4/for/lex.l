%{
/* Definition section */
#include<stdio.h>
#include "y.tab.h"
extern int yylval;
%}

alpha [A-Za-z]
digit [0-9]
%%

[\t \n]
for             return FOR;
if              return IF;
else            return ELSE;
while           return WHILE;
{digit}+        return NUM;
{alpha}({alpha}|{digit})* return ID;
"<="            return LE;
">="            return GE;
"=="            return EQ;
"!="            return NE;
"||"            return OR;
"&&"            return AND;
.               return yytext[0];

%%


int yywrap()
{
    return 1;
}
