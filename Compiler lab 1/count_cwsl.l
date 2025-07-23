%{
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
int c=0, w=0, s=0, l=0;
%}

WORD    [^ \t\n,\.:]+
EOL     [\n]
BLANK   [ \t]

%%

{WORD}  { w++; c += yyleng; }
{BLANK} { s++; c++; }
{EOL}   { l++; c++; }
.       { c++; }

%%

int yywrap()
{
    return 1;
}

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        printf("Usage: %s <input_file>\n", argv[0]);
        exit(1);
    }

    yyin = fopen(argv[1], "r");
    if(!yyin)
    {
        perror("Error opening file");
        exit(1);
    }

    yylex();

    printf("No of characters = %d\nNo of words = %d\nNo of spaces = %d\nNo of lines = %d\n", c, w, s, l);

    fclose(yyin);
    return 0;
}

