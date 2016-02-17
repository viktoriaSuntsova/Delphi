%option noyywrap 
%option never-interactive
%option header-file="lexer.hpp"
%top{
	 #pragma warning(disable: 4996)
}

%{
	#include <stdio.h>
	#include <cstdlib>
%}

%x LINE_COMMENT
%x COMMENT
%x STRING
%x ARRAY_RANGE

%%

"//"						{ BEGIN(LINE_COMMENT);}
"(*"						{ BEGIN(COMMENT);}
"{"							{ BEGIN(COMMENT);}

<LINE_COMMENT>\n			{ BEGIN(INITIAL);}
<LINE_COMMENT>.*			{  }
<COMMENT>"*)"			    {  BEGIN(INITIAL);}
<COMMENT>"}"			    { BEGIN(INITIAL);}
<COMMENT>.|\n     			{  }


"'"							{BEGIN(STRING);}
<STRING>"''"	            {BEGIN(STRING);}
<STRING>"'"					{BEGIN(INITIAL);}
<STRING>.					{ }


"["							{BEGIN(ARRAY_RANGE);}
<ARRAY_RANGE>\.				{return POINT;}
<ARRAY_RANGE>[0-9]			{yylval.dig = atoi(yytext); return DIGIT_IN_ARR; }
<ARRAY_RANGE>"]"			{BEGIN(INITIAL);}
<ARRAY_RANGE>.				{return MIST_IN_ARRAY_RANGE}

Integer                     { return INT; }
Cardinal					{ return CARDINAL;}
ShortInt					{ return SHORT_INT; }
Int64						{ return INT64;}
Byte						{ return BYTE; }					
Word						{ return WORD;}
Real						{ return REAL; }
Real48						{ return REAL48; }
Singl						{ return SINGL; }
Double						{ return DOUBLE; }
Extended					{ return EXTENDED; }
Comp						{ return COMP; }
Currency					{ return CURRENCY; }
Boolean						{ return BOOLEAN; }
var							{ return VAR; }
const						{ return CONST;}
begin						{ return BEGIN;}
end							{ return END; }
;							{ return SEMICOLON;}
type						{ return TYPE; }
array						{ return ARRAY; }
of							{ return OF; }
nil							{ return NULL; }
record						{ return RECORD; }
file						{ return FILE; }
set							{ return SET; }
if							{ return IF; }
in							{ return IN; }
then						{ return THEN; }
else						{ return ELSE; }
true						{ return TRUE; }
false						{ return FALSE; }
for							{ return FOR; }
do							{ return DO; }
downto						{ return DOWNTO; }
while						{ return WHILE; }
repeat						{ return REPEAT; }
until						{ return UNTIL; }
Break						{ return BREAK; }
Continue					{ return CONTINUE; }
goto						{ return GOTO; }
label						{ return LABEL; }
Pointer						{ return POINTER; }
:=							{ return ASSIGMENTSTAT; }
=							{ return EQUAL; }
\^							{ return POINTER; }
:							{ return COLON; }
\(							{ return OPENPARENT; }
\)							{ return CLOSEPARENT; }


class						{ return CLASS; }
private						{ return PRIVATE; }
public						{ return PUBLIC; }
published					{ return PUBLISHED; }
protected					{ return PROTECTED; }

implimentation				{return IMPL;}

[A-Za-z_][A-Za-z0-9_]+	    { yylval = yytext; return ID;}
[0-9]						{ yylval.dig = atoi(yytext); return DIGIT; }
[0-9]/.[0-9]			    { yylval.dbl = atof(yytext); return DBL_DIG; }
.							{ throw yytext;}

%%