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
A       [aA]
B       [bB]
C       [cC]
D       [dD]
E       [eE]
F       [fF]
G       [gG]
H       [hH]
I       [iI]
J       [jJ]
K       [kK]
L       [lL]
M       [mM]
N       [nN]
O       [oO]
P       [pP]
Q       [qQ]
R       [rR]
S       [sS]
T       [tT]
U       [uU]
V       [vV]
W       [wW]
X       [xX]
Y       [yY]
Z       [zZ]
%x LINE_COMMENT
%x COMMENT
%x STRING

%%

"//"						{BEGIN(LINE_COMMENT);}
"(*"						{BEGIN(COMMENT);}
"{"							{BEGIN(COMMENT);}

<LINE_COMMENT>\n			{BEGIN(INITIAL);}
<LINE_COMMENT>.*			{return(yytext); }
<COMMENT>"*)"			    {BEGIN(INITIAL);}
<COMMENT>"}"			    {BEGIN(INITIAL);}
<COMMENT>.|\n     			{  }


"'"							{return STRING; BEGIN(STRING);}
<STRING>"''"	            {return STRING;BEGIN(STRING);}
<STRING>"'"					{BEGIN(INITIAL);}
<STRING>.					{return(yytext);}


"["							{return LBRAC;}
\.\.						{return(yytext);return  ;}
"]"			         		{return RBRAC ;}

{I}{N}{T}{E}{G}{E}{R}                   { return INTEGER ; }
{F}{U}{N}{C}{T}{I}{O}{N}				{ return FUNCTION ; }
{R}{E}{S}{U}{L}{T}						{ return RESULT ; }
{C}{A}{R}{D}{I}{N}{A}{L}			    { return CARDINAL ; }
{S}{H}{O}{R}{T}{I}{N}{T}				{ return SHORTINT ; }
{I}{N}{T}64								{ return INT64 ; }
{B}{Y}{T}{E}							{ return BYTE ; }					
{W}{O}{R}{D}							{ return WORD ; }
{R}{E}{A}{L}							{ return REAL ; }
{R}{E}{A}{L}48							{ return REAL48 ; }
{S}{I}{N}{G}{L}							{ return SINGL ; }
{D}{O}{U}{B}{L}{E}						{ return DOUBLE ; }
{E}{X}{T}{E}{N}{D}{E}{D}				{ return EXTENDED ; }
{C}{O}{M}{P}							{ return COMP ; }
{C}{U}{R}{R}{E}{M}{C}{Y}				{ return CURREMCY ; }
{B}{O}{O}{L}{E}{A}{N}					{ return BOOLEAN ; }
{S}{T}{R}{I}{N}{G}						{ return STRING ; }


{V}{A}{R}								{ return   VAR ; }
{C}{O}{N}{S}{T}  						{ return   CONST ; }
{B}{E}{G}{I}{N}							{ return   BEGIN ; }
{E}{N}{D} 								{ return   END ; }
;										{ return SEMICOLON ; }
{T}{Y}{P}{E}							{ return   TYPE ; }
{A}{R}{R}{A}{Y}							{ return   ARRAY ; }
{O}{F}									{ return   OF ; }
{T}{O}									{ return   TO ; }
{C}{A}{S}{E} 							{ return   CASE ; }
{N}{I}{L}								{ return   NILL ; }
{R}{E}{C}{O}{R}{D}						{ return   RECORD ; }
{F}{I}{L}{E}							{ return FILE ; }
{S}{E}{T}								{ return   SET ; }
{I}{F}									{ return   IF ; }
{I}{N}									{ return   IN ; }
{T}{H}{E}{N}							{ return   THEN ; }
{E}{L}{S}{E}							{ return   ELSE ; }
{T}{R}{U}{E}							{ return TRUE ; }
{F}{A}{L}{S}{E}							{ return FALSE ; }
{F}{O}{R} 								{ return   FOR ; }
{D}{O}									{ return   DO ; }
{D}{O}{W}{N}{T}{O} 						{ return   DOWNTO ; }
{W}{H}{I}{L}{E} 						{ return   WHILE ; }
{R}{E}{P}{E}{A}{T} 						{ return   REPEAT ; }
{U}{N}{T}{I}{L}							{ return   UNTIL ; }
{B}{R}{E}{A}{K}							{ return   BREAK ; }
{C}{O}{N}{T}{I}{N}{U}{E}				{ return   CONTINUE ; }
{G}{O}{T}{O}							{ return   GOTO ; }
{L}{A}{B}{E}{L}							{ return   LABEL ; }
{P}{O}{I}{N}{T}{E}{R}					{ return POINTER ; }
{P}{R}{O}{C}{E}{D}{U}{R}{E}				{return PROCEDURE ;}
{N}{O}{T} 								{ return NOT ; }
{A}{N}{D}								{ return AND ; }
{O}{R}									{ return OR ; }
{X}{O}{R}								{ return XOR ; }
{M}{O}{D}								{ return MOD ;}
{D}{I}{V}								{ return DIV ;}
:=										{ return ASSIGNMENT; }
=										{ return EQUAL ; }
\^										{ return POINTER ; }
:										{ return COLON ; }
\(										{ return LPAREN; }
\)										{ return RPAREN ; }
\n										{ line++;}
\+										{ return PLUS ;}
\*										{ return STAR ;}
\-										{ return MINUS ;}
\/										{ return SLASH ;}
\<\>									{ return NOTEQUAL ;}
>=										{ return >= ;}
\<\=									{ return <= ;}
\<										{ return LT ;}
\>										{ return GT ;}
,										{ return COMMA ; }

{C}{L}{A}{S}{S}							{ return  CLASS ; }
{P}{R}{I}{V}{A}{T}{E}					{ return  PRIVATE ; }
{P}{U}{B}{L}{I}{C}						{ return  PUBLIC ; }
{P}{U}{B}{L}{I}{S}{H}{E}{D}				{ return  PUBLISHED ; }
{P}{R}{O}{T}{E}{C}{T}{E}{D}				{ return  PROTECTED ; }
{P}{R}{O}{C}{E}{D}{U}{R}{E}				{ return  PROCEDURE ;}
{P}{R}{O}{G}{R}{A}{M}{M}				{ return  PROGRAMM ;}
{U}{S}{E}{S}							{ return  USES ;}
{U}{N}{I}{T}							{ return  UNIT ;}

{I}{M}{P}{L}{E}{M}{E}{N}{T}{A}{T}{I}{O}{N}	{return   IMPL ;}
{I}{N}{T}{E}{R}{F}{A}{S}{E}					{return  INTERFASE ;}

"T"[A-Z][A-Za-z0-9]+	    {  return TYPE;}
[A-Za-z_][A-Za-z0-9_]*	    { return IDENTIFIER; /*yytext*/); }

[0-9]+"."[0-9]+			    { return REALNUMBER; /*atoi(yytext));*/ }
[0-9]+						{ return DIGSEQ; /*atoi(yytext));*/ }


[ \t]						{ ;}
.						    { return UNKNOWN ;}
%%