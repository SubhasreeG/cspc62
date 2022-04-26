%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

  typedef struct node
  {
    struct node *left;
    struct node *right;
    char *token;
  } node;

  node *insertNode(node *left, node *right, char *token);
  void displayTree(node *tree);

#define YYSTYPE struct node *

%}

%start statements

%token OPERAND

%right  '='
%left OR
%left AND
%left GE LE NE EQ
%left '<' '>'
%left '+' '-'
%left '/' '*'

%%

statements:  
        | statements statement 

statement:   expr ';'     { printf("\nSyntax Tree in level order (paranthesis are displayed for clarity:)\n"); displayTree($1); printf("\n");}
    ;

expr: 
 expr '+' expr {$$ = insertNode($1,$3,"+");}
| expr '-' expr {$$ = insertNode($1,$3,"-");}
| expr '*' expr {$$ = insertNode($1,$3,"*");}
| expr '/' expr {$$ = insertNode($1,$3,"/");}
| expr '=' expr {$$ = insertNode($1,$3,"=");}
| expr '>' expr {$$ = insertNode($1,$3,">");}
| expr '<' expr {$$ = insertNode($1,$3,"<");}
| expr AND expr {$$ = insertNode($1,$3,"&&");}
| expr OR expr {$$ = insertNode($1,$3,"||");}
| expr GE expr {$$ = insertNode($1,$3,">=");}
| expr LE expr {$$ = insertNode($1,$3,"<=");}
| expr NE expr {$$ = insertNode($1,$3,"!=");}
| '(' expr ')' {$$ = $2;}
| OPERAND {$$ = insertNode(0,0,(char *)yylval);}
;

%%

node *insertNode(node *left, node *right, char *token)
{
  node *newnode = (node *)malloc(sizeof(node));
  char *newstr = (char *)malloc(strlen(token)+1);
  strcpy(newstr, token);
  newnode->left = left;
  newnode->right = right;
  newnode->token = newstr;
  return(newnode);
}

void displayTree(node *tree)
{
  int i;


  if (tree->left || tree->right)
    printf("(");

  printf(" %s ", tree->token);

  if (tree->left)
    displayTree(tree->left);
  if (tree->right)
    displayTree(tree->right);

  if (tree->left || tree->right)
    printf(")");
}


int main (void) {
  printf("Enter Assignment statement/expression:");
  return yyparse ( );
}

int yyerror (char *s) {
  fprintf (stderr, "%s\n", s);
}