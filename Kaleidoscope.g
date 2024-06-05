start: app;

app: contenido_app;

contenido_app: funcion llamada | funcion contenido_app;

funcion: 'def' VARIABLE '\(' contenido '\)' '{' contenido_funcion '}';

llamada: VARIABLE '\(' cont '\)';
program: 
    LISTA |
    operacion |
    condicion
    ;

contenido_funcion: program | program contenido_funcion;

contenido: VARIABLE | (contenido ',' contenido);

cont: NUMERO | VARIABLE | (contenido ',' contenido);

operacion:
  '\(' operacion '\)'
  | '\-' operacion
  | suma
  | DECIMAL
  | trigonometricas
  | NUMERO 
  | VARIABLE;

suma:  operacion ('\+'| '\-' | '\*' | '/') operacion;

DECIMAL: NUMERO '\.' NUMERO;

NUMERO: '[0]|([1-9][0-9]*)';

trigonometricas: ('SEN'| 'COS' | 'TAN') ('\('operacion '\)'| (NUMERO|DECIMAL) );

logica: operacion ('<' | '>' | '<=' | '>=' | '==' | '!=') operacion;

contenido_condicion: '\(logica\)' ( DISYUNCION | CONJUNCION | negacion) '\(logica\)' | '\(logica\)' ( DISYUNCION | CONJUNCION | negacion) contenido_condicion;

VARIABLE: '[a-zA-Z_][a-zA-Z0-9_]*';

CONJUNCION: '&&';

DISYUNCION: '\|\|' ;

negacion: '¬' | '~';

LISTA: 'QUOTE \(elementos\)' ;

elementos: elemento (',' elemento)*;

elemento: (NUMERO | DECIMAL) | NIL | LISTA;



NIL: 'nil';

QUOTE: '\'';

condicion: 'if\(contenido_condicion\)/{program /; /}' '(else/{ program /; /})?';

WS: '[ \t\n]+' (%ignore);
