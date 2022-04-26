%option noyywrap
%{
	#include "y.tab.h"
	#include "expEval.h"
%}
%%

[0-9]+	{
			yylval.val=atof(yytext);
			return NUMBER;
		}

[ \t]						;

[A-Za-z][A-Za-z0-9]*	{
							yylval.symc = sym(yytext);
							return VAR;
						}
"$"						return 0;						
"&&"                    {
                            return AND;
                        }
                        
"||"                    {
                            return OR;
                        }

">="                    {
                            return GE;
                        }

"<="                    {
                            return LE;
                        }

"=="                    {
                            return EE;
                        }

"!="                    {
                            return NE;
                        }

.|\n					return yytext[0];

%%