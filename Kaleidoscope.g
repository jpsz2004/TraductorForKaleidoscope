start: app;

app: contenido_app;

contenido_app: funcion llamar | funcion contenido_app;

funcion: 'def' variable '\(contenido\)' '/{contenido_funcion/}';

llamar: variable'\(cont\)';

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
decimal: numero '.' numero;
numero: '[0]|([1-9][0-9]*)';
trigonometricas: ('SEN'| 'COS' | 'TAN') ('\('operacion '\)'| (numero|decimal) );
WS: '[ ]+' (%ignore);
logica: operacion ('<' | '>' | '<=' | '>=' | '==' | '!=' ) operacion;

contenido_condicion: '\(logica\)' ( disyuncion | conjuncion | negacion) '\(logica\)' | '\(logica\)' ( disyuncion | conjuncion | negacion) contenido_condicion;


variable:'(\_)*' '( [a-z] | [A-Z] | [0-9] | '\_')+'; 

conjuncion: '/\\' | '\*' | '&&';
disyuncion: '\\/' | '\+' | '\|\|' ;
negacion: '¬' | '~';

lista: 'QUOTE \(elementos\)' ;

elementos: elemento (',' elemento)*;

elemento: STRING | NUMBER | NIL | lista;

NUMBER: decimal | numero;
STRING: '"([^"\\]|\\.)*"';
NIL: 'nil';
QUOTE : '\''


condicion: 'if\(contenido_condicion\)/{program /; /}' '(else/{ program /; /})?';