%{
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    
    struct symbolTable {
        char identifiers[1000][32]; 
        char DType[1000][32]; 
        int datasize[1000]; 
        int offset[1000];  
        int max_offset;  
    };
    int scope=0, max_scope=0;
    struct symbolTable SYMBOLS[10];
    char recen_Dtype[32];
    struct token_list
    {
      char token[32];
      char lexeme[32];
    };
    struct token_list list[100];
    int count=0;
    int search_lexeme(char *s);
    int search_idtf(char *s,int x);
    int Size(char *s);

%}
%x ML_COMMENT

%option yylineno

DTYPE int|float|char|double|long|short
KEYWORD  auto|extern|if|else|do|void|while|for|case|switch|const|static|continue|break|default|return|typedef|enum|struct|union|signed|unsigned|register|extern|sizeof|goto|volatile|printf|scanf|main

KEYWORDS [DTYPE|KEYWORD]

INT             \-?[0-9]{1,9}
FLOAT           \-?[0-9]{1,38}\.[0-9]{1,6}
DOUBLE          \-?[0-9]{1,308}\.[0-9]{1,15}
LONG            \-?[0-9]{1,18}
LONGDOUBLE      \-?[0-9]{1,4932}\.[0-9]{1,19}

NUM             {INT}|{FLOAT}|{DOUBLE}|{LONG}|{LONGDOUBLE}

PUNCT           [\;\:\'\"\,]
IDENTIFIER              [_a-zA-Z][_a-zA-Z0-9]{0,31}

%%

\/\/.*\n        {printf("");}
("/"\*([^*]|[\r\n]|(\*+([^*"/"]|[\r\n])))*\*+"/")|("/""/".*) {fprintf(yyout, "");}

\#define.*\n    {printf("");}
\#include<[a-z]+[\.h]?> {printf("");}
\#.*\n          {printf("");}

\{              {scope = scope + 1;}
\}              {
                if(scope>max_scope) max_scope = scope;
                scope = scope-1;
                }
{DTYPE} {    int id=search_lexeme(yytext);
                if(id==-1)
                {
                  strcpy(list[count].token,"KEYWORD");
                  strcpy(list[count].lexeme,yytext);
                  count++;
                  printf("%s--KEYWORD\n", yytext); 
                }
                  strcpy(recen_Dtype, yytext);}
{KEYWORD}      {int id=search_lexeme(yytext);
                if(id==-1)
                {
                  strcpy(list[count].token,"KEYWORD");
                  strcpy(list[count].lexeme,yytext);
                  count++;
                  printf("%s--KEYWORD\n", yytext);
                }}
{NUM}           {int id=search_lexeme(yytext);
                if(id==-1)
                {
                  strcpy(list[count].token,"NUMERIC_DATA");
                  strcpy(list[count].lexeme,yytext);
                  count++;
                  printf("%s--NUMERIC_DATA\n", yytext);
                }}
[0-9][_a-zA-Z0-9]*  {printf("%s--id should not begin with number\n", yytext);}
[_a-zA-Z][_a-zA-Z0-9]{31}+  {printf("%s-- very long identifier\n", yytext);}
{IDENTIFIER}            {
          int id=search_lexeme(yytext);
                if(id==-1)
                {
                  strcpy(list[count].token,"IDENTIFIER");
                  strcpy(list[count].lexeme,yytext);
                  count++;
                  printf("%s--IDENTIFIER\n", yytext); 
                }
                int* x = &SYMBOLS[scope].max_offset;
                int id1=search_idtf(yytext,*x);
                if(id1==-1)
                {
    
                strcpy(SYMBOLS[scope].identifiers[*x+1], yytext);
                strcpy(SYMBOLS[scope].DType[*x+1], recen_Dtype);
                SYMBOLS[scope].datasize[*x+1]=Size(SYMBOLS[scope].DType[*x+1]);
                SYMBOLS[scope].offset[*x+1]=SYMBOLS[scope].offset[*x]+SYMBOLS[scope].datasize[*x+1];
                *x = *x + 1;}}
.               {printf("");}
\n              {printf("");}
%%


int search_lexeme(char  *s)
{
  int i;
    for(i = 0; i < 100; i++){
        if(strcmp(list[i].lexeme,s) == 0)
            return i;
    }
    return -1;
}

int search_idtf(char *str,int x)
{
  int j;
  int i=0;
  for(i=0;i<scope;i++)
  {

  for(j=0; j<=x; j++)
  {
            if(strcmp(SYMBOLS[i+1].identifiers[j],str) == 0)
            {return i;
            }
  }
  }
  return -1;
}

int Size(char* s)
{
    if(strcmp(s, "int")==0) return 4;
    if(strcmp(s, "char")==0) return 1;
    if(strcmp(s, "float")==0) return 4;
    if(strcmp(s, "short")==0) return 2;
    if(strcmp(s, "double")==0) return 8;
    if(strcmp(s, "long")==0) return 4;
    if(strcmp(s, "long double")==0) return 10;
    return 0;
}

int yywrap(void){return 1;}
int main()
{
    int i=0, j=0;
    for(i=0; i<10;i++)
    {
        SYMBOLS[i].max_offset = 0;
    }

    //input file
    yyin = fopen("sample.c", "r");

    yylex();
    fclose(yyin);
    printf("\nidentifier\tDType\tsize\tscope\toffset\n");
    printf("---------------------------------------------------\n");
    for(i=0; i<=max_scope; i++)
    {
        int Offset = 0;
        for(j=1; j<=SYMBOLS[i].max_offset; j++)
        {
            
            printf("%s\t\t%s\t\t%d\t%d\t%d\n",SYMBOLS[i].identifiers[j], SYMBOLS[i].DType[j], SYMBOLS[i].datasize[j], i, SYMBOLS[i].offset[j]);
        }
    }
    return 0;
}