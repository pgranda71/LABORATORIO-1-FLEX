%{
#include <stdio.h>

int mayus = 0;
int minus = 0;
int digitos = 0;
int espacios = 0;
%}

%option noyywrap

%%
[A-Z]        { mayus++; }
[a-z]        { minus++; }
[0-9]        { digitos++; }
[ \t\r\n]+   { espacios += yyleng; }
.            { /* otros caracteres */ }
%%

int main(void) {
    printf("Escribe texto y presiona CONTROL+ D");
    yylex();
    printf("\n--- Resumen de clasificacion de caracteres ---\n");
    printf("Mayusculas: %d\n", mayus);
    printf("Minuscuculas: %d\n", minus);
    printf("Digitos:    %d\n", digitos);
    printf("Espacios:   %d\n", espacios);
    return 0;
}
