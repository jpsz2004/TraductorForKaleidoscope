start: app;

app: contenido_app;

contenido_app: funcion llamada | funcion contenido_app;

funcion: 'def' variable '\(' contenido '\)' '{' contenido_funcion '}';

llamada: variable '\(' cont '\)';
program: 
    lista |
    operacion |
    condicion
    ;

contenido_funcion: program | program contenido_funcion;

contenido: variable | (contenido ',' contenido);

cont: numero | variable | (contenido ',' contenido);

operacion:
  '\(' operacion '\)'
  | '\-' operacion
  | suma
  | decimal
  | trigonometricas
  | numero 
  | variable;

suma:  operacion ('\+'| '\-' | '\*' | '/') operacion;

decimal: numero '\.' numero;

numero: '[0]|([1-9][0-9]*)';

trigonometricas: ('SEN'| 'COS' | 'TAN') ('\('operacion '\)'| (numero|decimal) );

logica: operacion ('<' | '>' | '<=' | '>=' | '==' | '!=') operacion;

contenido_condicion: '\(logica\)' ( disyuncion | conjuncion | negacion) '\(logica\)' | '\(logica\)' ( disyuncion | conjuncion | negacion) contenido_condicion;

variable: '[a-zA-Z_][a-zA-Z0-9_]*';

conjuncion: '&&';

disyuncion: '\|\|' ;

negacion: '¬' | '~';

lista: 'QUOTE \(elementos\)' ;

elementos: elemento (',' elemento)*;

elemento: (numero | decimal) | NIL | lista;



NIL: 'nil';

QUOTE: '\'';

condicion: 'if\(contenido_condicion\)/{program /; /}' '(else/{ program /; /})?';

WS: '[ \t\n]+' (%ignore);
