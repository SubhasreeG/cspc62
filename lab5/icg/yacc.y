%{

#include<string.h> 
#include<stdio.h> 
int yylex(void);
int yyerror(const char *s);
char insertIntoTable(char,char,char[]);
int index1=0;
char temp = 'A'-1;

struct expressionr{
  char operand1; 
  char operand2; 
  char operator[2]; 
  char result;
};

%}

%union{
  char symbol;
}


%left OR

%left AND

%left GE LE NE EQ

%left '<' '>'

%left '+' '-'

%left '/' '*'

%token GE NE LE EQ AND OR

%token <symbol> LETTER NUMBER

%type <symbol> expression

%start statement

%%

statement: LETTER '=' expression ';' {insertIntoTable((char)$1,(char)$3, "=");};

expression: expression '+' expression {$$ = insertIntoTable((char)$1,(char)$3,"+");}

|expression '-' expression {$$ = insertIntoTable((char)$1,(char)$3,"-");}
|expression '/' expression {$$ = insertIntoTable((char)$1,(char)$3,"/");}
|expression '*' expression {$$ = insertIntoTable((char)$1,(char)$3,"*");}
|expression '<' expression {$$ = insertIntoTable((char)$1,(char)$3,"<");}
|expression '>' expression {$$ = insertIntoTable((char)$1,(char)$3,">");}
|expression AND expression {$$ = insertIntoTable((char)$1, (char)$3, "&&");}
|expression OR expression {$$ = insertIntoTable((char)$1, (char)$3, "||");}
|expression GE expression {$$ = insertIntoTable((char)$1, (char)$3, ">=");}
|expression LE expression {$$ = insertIntoTable((char)$1, (char)$3, "<=");}
|expression NE expression {$$ = insertIntoTable((char)$1, (char)$3, "!=");}
|expression EQ expression {$$ = insertIntoTable((char)$1, (char)$3, "==");}
|'(' expression ')' {$$ = (char)$2;}
|NUMBER {$$ = (char)$1;}
|LETTER {$$ = (char)$1;}
;

%%
struct expressionr arr[20];

int yyerror(const char *s){
  printf("%s",s);
}

char insertIntoTable(char a, char b, char o[]){ 
  temp++;
  arr[index1].operand1 = a; 
  arr[index1].operand2 = b; 
  strcpy(arr[index1].operator, o); 
  arr[index1].result=temp; index1++;
  return temp;
}

void threeAddress(){
  int i=0; 
  while(i<index1){
    printf("%c := ",arr[i].result);
    printf("%c ",arr[i].operand1);
    printf("%c%c ",arr[i].operator[0], arr[i].operator[1]); 
    printf("%c",arr[i].operand2);
    i++;
    printf("\n");
  }
}

int main(){

  printf("Enter the Assignment statement/ expression: "); 
  yyparse();
  threeAddress(); 
  printf("\n"); 
  return 0;
}
