%{
    #include<stdio.h>
    #include<string.h>
    #include "y.tab.h"
%}
dataTypes int|float|long|double|char|struct|union|enum|void|long[ ]*double|long[ ]*int|long[ ]*long|long[ ]*float|long[ ]*char|unsigned[ ]*int|unsigned[ ]*long|unsigned[ ]*double|unsigned[ ]*char|signed[ ]*int|signed[ ]*long|signed[ ]*double|signed[ ]*char|short|char[ ]*\*
keyword auto|break|case|const|continue|default|do|extern|for|goto|inline|register|restrict|return|sizeof|static|switch|typedef|volatile|include|define|ifdef|ifndef|endif

%option noyywrap

%%

{dataTypes}                     { return DATATYPE; }
{keyword}                       ;
\".*\"                          {yylval.str = strdup(yytext); return NUMBER;}
[0-9]+                          {yylval.str = strdup(yytext); return NUMBER;}
[a-zA-Z_][_a-zA-Z0-9]*          {yylval.str = strdup(yytext); return IDENTIFIER;}
"&&"                            {return AND;}    
"||"                            {return OR;}
">="                            {return GE;}
"<="                            {return LE;}
"=="                            {return EE;}
"!="                            {return NE;}
"--"                            {return UM;}
"++"                            {return UP;}
\t                              ;
[ ]                             ;
\n                              ;
.                               {return yytext[0];}

%%