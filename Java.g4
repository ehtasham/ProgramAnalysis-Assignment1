grammar Java;

file : classes+ ;

classes : accessModifier? 'class' (ID|ALPHANUMERIC) classBody ;

classBody : '{' members+ '}';

members : ((fields | methods) | (methods | fields));

fields : (fieldDecl | fieldAssign) ;

fieldDecl  : accessModifier? type (ID|ALPHANUMERIC) ';' ;

fieldAssign: accessModifier? type? (ID|ALPHANUMERIC) '=' (NUMBER|ID) ';';

methods: (methodDecl | methodCall);

methodDecl: accessModifier? 'static'? returnType (ID|ALPHANUMERIC) '(' parameters* ')' (body|';') 
		    ;

methodCall: (ID|ALPHANUMERIC) '(' parameters* ')' ';';

body: '{' statements*'}';

statements :  methodCall
		   |  fields
		   |  'if'  '(' (ID|ALPHANUMERIC) moreConditionals NUMBER  ')' body? 
		   |  'for' '(' type? ID moreConditionals NUMBER ';' ID moreConditionals NUMBER ';' ID  (INCREMENT|DECREMENT) ')' 
		   	  body? 
		   |  'while' '(' ID moreConditionals? NUMBER ')' body? 
		   |  'System' '.' 'out' '.' * 
		   ;


parameters : param(',' param)* ;

param: (type? ID) ;

accessModifier : 'public' 
			   | 'private' 
			   | 'protected' 
			   ;

type: 'int'
	| 'float'
	| 'String' 
	| 'Double'
	;

returnType: 'int' 
		  | 'float' 
		  | 'String' 
		  | 'double' 
		  | 'void' 
		  ;


conditional: and | or | not | doubleEqual  ; 
and : '&&' ;
or  : '||' ;
not : '~';




INCREMENT: '++';
DECREMENT : '--';

moreConditionals: greater | less | equal| greateEqual |doubleEqual | lessEqual ; 
greater : '>' ;
less: '<' ;
greateEqual : '>=' ;
lessEqual : '<=' ;
equal: '=';
doubleEqual : '==' ;

NUMBER: [0-9]+ ;  
ID : [a-zA-Z]+ ;  
ALPHANUMERIC: [a-zA-Z0-9]+ ;        
WS : [ \t\r\n]+ -> skip ; 



