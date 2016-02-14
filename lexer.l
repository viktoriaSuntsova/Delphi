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
%x ARRAY_CONTENT

%%

"//"						{printf("Start of line comment "); BEGIN(LINE_COMMENT);}
"(*"						{ printf("Start of comment "); BEGIN(COMMENT);}
"{"							{printf("Start of comment "); BEGIN(COMMENT);}

<LINE_COMMENT>\n			{ printf("End of line comment\n"); BEGIN(INITIAL);}
<COMMENT>"*)"			    { printf("End of comment "); BEGIN(INITIAL);}
<COMMENT>"}"			    { printf("End of comment "); BEGIN(INITIAL);}

"\'"						{printf("Start const string "); BEGIN(STRING);}
<STRING>"\'\'"	            {printf("Continue const string "); BEGIN(STRING);}
<STRING>"\'"			    {printf("End const string "); BEGIN(INITIAL);}

"["							{printf("  ");BEGIN(ARRAY_CONTENT);}
<ARRAY_CONTENT>\.			{}
<ARRAY_CONTENT>[0-9]		{}
"]"							{printf("  ");BEGIN(INITIAL);}

Integer                     { printf("Integer type  "); }
Cardinal					{ printf("Cardinal type  "); }
ShortInt					{ printf("ShortInt type  "); }
Int64						{ printf("Int64 type  "); }
Byte						{ printf("Byte type  "); }					
Word						{ printf("Word type  "); }
Real						{ printf("Real type  "); }
Real48						{ printf("Real48 type  "); }
Singl						{ printf("Singl type  "); }
Double						{ printf("Double type  "); }
Extended					{ printf("Extended type  "); }
Comp						{ printf("Comp type  "); }
Currency					{ printf("Currency type  "); }
Boolean						{ printf("Boolean type  "); }
var							{ printf("Start variable declaration  "); }
const						{ printf("Start constant declaration  "); }
begin						{ printf("BEGIN  "); }
end							{ printf("END  "); }
;							{ printf(";  "); }
type						{ printf("Start type description  "); }
array						{ printf("Start array description  "); }
of							{ printf("OF  "); }
nil							{ printf("NULL "); }
record						{ printf("Start record description "); }
file						{ printf("Start file declaration "); }
set							{ printf("Start file declaration "); }
if							{ printf("IF "); }
in							{ printf("IN "); }
then						{ printf("THEN "); }
else						{ printf("ELSE "); }
true						{ printf("TRUE "); }
false						{ printf("FALSE "); }
for							{ printf("FOR "); }
do							{ printf("DO "); }
downto						{ printf("DOWNTO "); }
while						{ printf("WHILE "); }
repeat						{ printf("REPEAT "); }
until						{ printf("UNTIL "); }
Break						{ printf("BREAK "); }
Continue					{ printf("CONTINUE "); }
goto						{ printf("GOTO "); }
label						{ printf("Start label declaration "); }
Pointer						{ printf("Start pointer declaration "); }
:=							{ printf("assignment statement  "); }
=							{ printf("  "); }
\^							{ printf("pointer  "); }
:							{ printf(":  "); }
\(							{ printf("(  "); }
\)							{ printf(")  "); }
\n							{ printf("\n  ");}


class						{ printf("Start class declaration "); }
private						{ printf("PRIVATE "); }
public						{ printf("PUBLIC "); }
published					{ printf("PUBLISHED "); }
protected					{ printf("PROTECTED "); }

implimentation				{printf ("Vars model is over");}

[A-Za-z_][A-Za-z0-9_]+	    { printf("Id - %s", yytext); }
[0-9]						{ printf("intDigit - %d", atoi(yytext)); }
.							{ throw yytext;}
%%