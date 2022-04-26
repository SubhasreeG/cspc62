%{
	#include "expEval.h"
	#include <string.h>
	#include <stdlib.h>
	#include <stdio.h>
%}
%union {
	int val;
	struct symbol *symc;
	}

%token <symc> VAR
%token <val> NUMBER

%left   '='
%left   OR
%left   AND
%left   '&' '|'
%left   EE NE
%left   '<' '>' GE LE
%left   '+' '-'
%left   '*' '/' '%'
%left   '(' ')'

%nonassoc UNNEG

%nonassoc NEG

%type <val> E;
%%

stmts :	stmt '\n'
     |	stmts stmt '\n'
	;
stmt :	VAR '=' E { 
                        $1->value = $3;
                    }
     |	E {
                printf("Result is: %d\n",$1);
            }
	;
E :	E '+' E	{$$ = $1 + $3;}

	|E '-' E	{$$ = $1 - $3;}

	|E '*' E	{$$ = $1 * $3;}

	|E '/' E	{
				    if($3 == 0) {	
                        yyerror();
				    }
				    else {	
                        $$ = $1 / $3;
                    }
			    }
	|E'%'E {$$ = $1 % $3;}

	|E AND E {$$ = $1 && $3;}

	|E OR E {$$ = $1 || $3;}

	|E'>'E {$$ = $1>$3;}

	|E'<'E {$$ = $1<$3;}

	|E LE E {$$ = $1 <= $3;}

	|E GE E {$$ = $1 >= $3;}

	|E EE E {$$ = $1 == $3;}

	|E NE E {$$ = $1 != $3;}

	|E'&'E {$$ = $1 & $3;}

	|E'|'E {$$ = $1 | $3;}

	|'-' E  %prec UNNEG	{$$ = -$2;}

	|'!' E  %prec NEG	{$$ = !$2;}

	|'(' E ')'	{$$ = $2;}

	|NUMBER	{$$ = $1;}

	|VAR	{$$ = $1->value;}
	;

%%
struct symbol *sym(char* s){
	struct symbol*	sp;
	for( sp = symbol; sp <&symbol[COUNT]; sp++) {
		if(sp->var && !strcmp(sp->var,s)) {
			return sp;
        }
		if(!sp->var) {
			sp->var=strdup(s);
			return sp;
		}
	}
    yyerror();
}

int yyerror() {
	printf("\nInvalid\n");
	exit(0);
}

main() {
	printf("\nEnter expression:  \n");
	yyparse();
}