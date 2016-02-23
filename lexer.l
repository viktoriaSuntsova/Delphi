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

%%

"//"						{ printf("Line Comment\n"); BEGIN(LINE_COMMENT);}
"(*"						{ printf("Comment\n"); BEGIN(COMMENT);}
"{"							{ printf("Comment\n"); BEGIN(COMMENT);}

<LINE_COMMENT>\n			{ BEGIN(INITIAL);}
<LINE_COMMENT>.*			{ printf(yytext); }
<COMMENT>"*)"			    {  BEGIN(INITIAL);}
<COMMENT>"}"			    {  BEGIN(INITIAL);}
<COMMENT>.|\n     			{  }


"'"							{printf("Const str\n"); BEGIN(STRING);}
<STRING>"''"	            {printf("'");BEGIN(STRING);}
<STRING>"'"					{BEGIN(INITIAL);}
<STRING>.					{printf(yytext);}


"["							{printf("[\n");}
\.\.						{printf(yytext);printf("\n");}
"]"			         		{printf("]\n");}

Integer                     { printf("INTEGER\n"); }
function
result
Cardinal					{ printf("CARDINAL\n"); }
ShortInt					{ printf("SHORTINT\n"); }
Int64						{ printf("INT64\n"); }
Byte						{ printf("BYTE\n"); }					
Word						{ printf("WORD\n"); }
Real						{ printf("REAL\n"); }
Real48						{ printf("REAL48\n"); }
Singl						{ printf("SINGL\n"); }
Double						{ printf("DOUBLE\n"); }
Extended					{ printf("EXTENDED\n"); }
Comp						{ printf("COMP\n"); }
Currency					{ printf("CURREMCY\n"); }
Boolean						{ printf("BOOLEAN\n"); }
String						{ printf("STRING\n"); }


var							{ printf("Keyword VAR\n"); }
const						{ printf("Keyword CONST\n"); }
begin						{ printf("Keyword BEGIN\n"); }
end							{ printf("Keyword END\n"); }
;							{ printf("SEMICOLON\n"); }
type						{ printf("Keyword TYPE\n"); }
array						{ printf("Keyword ARRAY\n"); }
of							{ printf("Keyword OF\n"); }
to							{ printf("Keyword TO\n"); }
Case						{ printf("Keyword CASE\n"); }
nil							{ printf("Keyword NILL\n"); }
record						{ printf("Keyword RECORD\n"); }
file						{ printf("FILE\n"); }
set							{ printf("Keyword SET\n"); }
if							{ printf("Keyword IF\n"); }
in							{ printf("Keyword IN\n"); }
then						{ printf("Keyword THEN\n"); }
else						{ printf("Keyword ELSE\n"); }
true						{ printf("TRUE\n"); }
false						{ printf("FALSE\n"); }
for							{ printf("Keyword FOR\n"); }
do							{ printf("Keyword DO\n"); }
downto						{ printf("Keyword DOWNTO\n"); }
while						{ printf("Keyword WHILE\n"); }
repeat						{ printf("Keyword REPEAT\n"); }
until						{ printf("Keyword UNTIL\n"); }
Break						{ printf("Keyword BREAK\n"); }
Continue					{ printf("Keyword CONTINUE\n"); }
goto						{ printf("Keyword GOTO\n"); }
label						{ printf("Keyword LABEL\n"); }
Pointer						{ printf("POINTER\n"); }
ShowMessage					{ printf("Procedure SHOWMESSAGE\n");}
not							{ printf("NOT\n"); }
and							{ printf("AND\n"); }
or							{ printf("OR\n"); }
xor							{ printf("XOR\n"); }
mod							{ printf("mod\n");}
div							{ printf("div\n");}
:=							{ printf("assignment statement\n"); }
=							{ printf("is equal\n"); }
\^							{ printf("pointer\n"); }
:							{ printf(":\n"); }
\(							{ printf("(\n"); }
\)							{ printf(")\n"); }
\n							{ printf("");}
\+							{ printf("+\n");}
\*							{ printf("*\n");}
\-							{ printf("-\n");}
\/							{ printf("//\n");}
\<\>						{ printf("<>\n");}
>=							{ printf(">=\n");}
\<\=					    { printf("<=\n");}
\>							{ printf(">\n");}
\<							{ printf("<\n");}
,							{ printf("comma\n"); }

class						{ printf("Keyword CLASS\n"); }
private						{ printf("Keyword PRIVATE\n"); }
public						{ printf("Keyword PUBLIC\n"); }
published					{ printf("Keyword PUBLISHED\n"); }
protected					{ printf("Keyword PROTECTED\n"); }
procedure					{ printf("Keyword PROCEDURE\n");}
program						{ printf("Keyword PROGRAMM\n");}
uses						{ printf("Keyword USES\n");}
unit						{ printf("Keyword UNIT\n");}

implementation				{printf ("Keyword IMPL\n");}
interface					{printf("Keyword INTERFASE\n");}

"T"[A-Z][A-Za-z0-9]+	    {  printf("%s-type\n" , yytext);}
[A-Za-z_][A-Za-z0-9_]*	    { printf("%s - Id \n", yytext); }

[0-9]+/.[0-9]+			    { printf("%d - doubleDigit\n", atoi(yytext)); }
[0-9]+						{ printf("%d - intDigit\n", atoi(yytext)); }


[ \t]						{ printf("");}
.						    { printf("UNKNOWN\n");}

%%