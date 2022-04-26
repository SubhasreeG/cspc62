%{
%}
  
%%  

"/*"([^*]|(\*+[^*/]))*\*+\/\n    ;

\/\/.*\n     ;

\t           ;

\n+          { fprintf(yyout, "\n"); }

" "+         { fprintf(yyout, " ");  }

" "+\n      ;
  
%%
  
int yywrap(){}

int main()
{
    yyin = fopen("Input.c", "r");
    yyout=fopen("out.c","w");
    yylex();
    return 0;
}