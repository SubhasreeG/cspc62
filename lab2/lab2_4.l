%{
    #include<stdio.h>
%}


%%

([^ab\n])+          {printf("%s : Enter only strings of a and b\n", yytext);}

(b*a+bb(a|b)*)   {printf("%s is not accepted\n", yytext);}

b*|b*a+|b*a+ba*     {printf("%s is accepted\n", yytext);}

%%

int yywrap(void)
{
   return 1;
}

int main()

{
    yylex();
    printf("\n");
    return 0;
}