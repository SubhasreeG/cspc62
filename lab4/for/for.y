%{
#include <stdio.h>
#include <stdlib.h>

%}
%token ID NUM FOR IF ELSE WHILE LE GE EQ NE OR AND
%right "="
%left OR AND
%left '>' '<' LE GE EQ NE
%left '+' '-'
%left '*' '/'
%left '!'
%%

S         : ForLoop {printf("Input accepted\n"); exit(0);}
ForLoop
: FOR '(' Exprs Exprs ')' STMT
| FOR '(' Exprs Exprs Expr ')' STMT
;

STMT
: '{' STMTList '}'
| '{' '}'
| ForLoop
| Expr
| ';'
;

STMTList
: STMTList STMT 
| STMT
;

Exprs
: ';'
| Expr Exprs
;

Expr  
: Assignments
| Expr ',' Assignments
;

Assignments
: ConditionalExpr 
| ID '=' Assignments
;

ConditionalExpr
: LogicalExpr
| LogicalExpr '?' Expr ':' ConditionalExpr
;

LogicalExpr
: Operand AND Operand
| Operand OR Operand
| Operand EQ Operand
| Operand NE Operand
| Operand LE Operand
| Operand GE Operand
| Operand '<' Operand
| Operand '>' Operand
| Operand '|' Operand
| Operand '&' Operand
| Operand '^' Operand
| Operand '+' Operand
| Operand '-' Operand
| Operand '*' Operand
| Operand '/' Operand
| Operand '%' Operand
| Operand '!' Operand
| Operand '+' '+'
| Operand '-' '-'
| Operand
;

Operand
: NUM
| ID
| '(' Exprs ')'
;

%%
void main()
{
    printf("\nEnter for loop :\n");

    yyparse();
}

void yyerror()
{
    printf("\nEntered for loop is Invalid\n\n");
}

