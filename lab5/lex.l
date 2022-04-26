%{
#include "y.tab.h"
%}

%%

[a-zA-Z0-9]+                {yylval=yytext; return OPERAND;} 
">="	{return	GE;}
"<="	{return	LE;}
"=="	{return	EQ;}
"!="	{return	NE;}
"&&"	{return	AND;}
"||"	{return	OR;}
\n {return 0;}
. {return yytext[0];}


%%

int yywrap (void) 
{
    return 1;
}