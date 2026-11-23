%{
/* 9.l - Procesa listas separadas por comas. Cada elemento: identificador o entero.
   Cualquier otro token se reporta como error. Cada linea es una lista. */
#include <stdio.h>

int espera_elemento = 1;  /* 1: se espera ID/NUM, 0: se espera coma */
int elementos = 0;        /* elementos validos en la lista actual */
int errores = 0;          /* errores en la lista actual */
int hay_contenido = 0;    /* la linea actual tiene algo */
int linea = 1;

void fin_lista(void);
%}

%option noyywrap

ID      [a-zA-Z_][a-zA-Z0-9_]*
NUM     -?[0-9]+

%%

[ \t\r]+            { /* se ignoran espacios */ }

{ID}                {
                        hay_contenido = 1;
                        if (espera_elemento) {
                            printf("  IDENTIFICADOR: %s\n", yytext);
                            elementos++; espera_elemento = 0;
                        } else {
                            printf("  ERROR: falta una coma antes de '%s'\n", yytext);
                            errores++;
                        }
                    }

{NUM}               {
                        hay_contenido = 1;
                        if (espera_elemento) {
                            printf("  ENTERO: %s\n", yytext);
                            elementos++; espera_elemento = 0;
                        } else {
                            printf("  ERROR: falta una coma antes de '%s'\n", yytext);
                            errores++;
                        }
                    }

-?[0-9]+[a-zA-Z_][a-zA-Z0-9_]*  {
                        hay_contenido = 1;
                        printf("  ERROR: token invalido '%s' (ni identificador ni entero)\n", yytext);
                        errores++;
                        espera_elemento = 0;
                    }

","                 {
                        hay_contenido = 1;
                        if (espera_elemento) {
                            printf("  ERROR: coma sin elemento previo\n");
                            errores++;
                        } else {
                            printf("  COMA\n");
                            espera_elemento = 1;
                        }
                    }

\n                  { fin_lista(); linea++; }

.                   {
                        hay_contenido = 1;
                        printf("  ERROR: token no valido '%s'\n", yytext);
                        errores++;
                    }

%%

void fin_lista(void) {
    if (!hay_contenido) return;               /* linea vacia */
    if (elementos > 0 && espera_elemento) {   /* termino en coma */
        printf("  ERROR: la lista termina en coma\n");
        errores++;
    }
    if (errores == 0)
        printf("  => Linea %d: LISTA VALIDA (%d elementos)\n\n", linea, elementos);
    else
        printf("  => Linea %d: LISTA INVALIDA (%d errores)\n\n", linea, errores);
    espera_elemento = 1; elementos = 0; errores = 0; hay_contenido = 0;
}

int main(void) {
    yylex();
    fin_lista();   /* por si la ultima linea no termina en salto de linea */
    return 0;
}

