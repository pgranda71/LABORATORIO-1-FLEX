%{
/* 7.l - Reconoce numeros binarios (secuencias de 0 y 1) y muestra su valor decimal */
#include <stdio.h>
%}

%option noyywrap

%%

[01]+           {
                    if (yyleng > 63) {
                        printf("BINARIO: %s -> demasiado largo (maximo 63 digitos)\n", yytext);
                    } else {
                        unsigned long long valor = 0;
                        int i;
                        for (i = 0; i < yyleng; i++)
                            valor = valor * 2 + (yytext[i] - '0');
                        printf("BINARIO: %s -> DECIMAL: %llu\n", yytext, valor);
                    }
                }

[0-9A-Za-z_]+   { printf("ERROR: %s no es binario (solo se permiten 0 y 1)\n", yytext); }

[ \t\r\n]+      { /* se ignoran espacios y saltos de linea */ }

.               { printf("ERROR: caracter no valido '%s'\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}

