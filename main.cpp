#include <stdio.h>
#include "conio.h"
#include "lexer.hpp"
int main(int argc, char* argv[])
{
	char string[256];
	gets(string);
	yyin = fopen(string, "r");
	yylex();
	_getch();
}