%{
/* 6.l - Detecta patrones simples de correo electronico: nombre@dominio.com */
#include <stdio.h>
int total = 0;
%}

%option noyywrap

LOCAL   [a-zA-Z0-9._%+-]+
DOMINIO [a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*
TLD     [a-zA-Z]{2,}

%%

{LOCAL}"@"{DOMINIO}"."{TLD}   { total++; printf("TOKEN_EMAIL: %s\n", yytext); }

[ \t\r\n]+                    { /* se ignoran espacios y saltos de linea */ }
.                             { /* cualquier otro caracter se ignora */ }

%%

int main(void) {
    yylex();
    printf("\nTotal de correos validos: %d\n", total);
    return 0;
}

