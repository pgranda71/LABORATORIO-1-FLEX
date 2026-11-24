%{
/* 8.l - Reconoce numeros hexadecimales del tipo 0x1A3F y muestra su valor decimal */
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%

0[xX][0-9a-fA-F]+    {
                         /* yytext+2 salta el prefijo "0x" */
                         unsigned long valor = strtoul(yytext + 2, NULL, 16);
                         printf("HEXADECIMAL: %s -> DECIMAL: %lu\n", yytext, valor);
                     }

[0-9A-Za-z_]+        { printf("ERROR: %s no es un hexadecimal valido (formato 0x...)\n", yytext); }

[ \t\r\n]+           { /* se ignoran espacios y saltos de linea */ }

.                    { printf("ERROR: caracter no valido '%s'\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}

