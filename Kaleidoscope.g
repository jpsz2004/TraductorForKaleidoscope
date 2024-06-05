start: app;

app: contenido_app;

contenido_app: funcion llamar | funcion contenido_app;

funcion: 'def' variable '\(' parametros '\)' '{' contenido_funcion '}';

llamada: variable '\(' argumentos '\)';

parametros: variable (',' variable)* | /* vacío */ ;

argumentos: expresion (',' expresion)* | /* vacío */ ;

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

logica: operacion ('<' | '>' | '<=' | '>=' | '==' | '!=') operacion;

contenido_condicion: '\(logica\)' ( disyuncion | conjuncion | negacion) '\(logica\)' | '\(logica\)' ( disyuncion | conjuncion | negacion) contenido_condicion;

variable: '[a-zA-Z_][a-zA-Z0-9_]*';

conjuncion: '&&';

disyuncion: '\|\|' ;

negacion: '¬' | '~';

lista: 'QUOTE \(elementos\)' ;

elementos: elemento (',' elemento)*;

elemento: NUMBER | NIL | lista;

NUMBER: decimal | numero;



NIL: 'nil';

QUOTE: '\'';

condicion: 'if\(contenido_condicion\)/{program /; /}' '(else/{ program /; /})?';

WS: '[ \t\n]+' (%ignore);
