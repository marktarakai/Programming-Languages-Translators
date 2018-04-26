/*
	tarakaim.l

	Homework #2 -- CS 3500: Programming Languages & Translators
	Dr. Jennifer Leopold
	Mark Tarakai

	This file is to accompany a bison file. Pertinent components to enable
	this file to be meaningful standalone have been removed.
*/

%{
	
%}

/* Define REGEX here */

WSPACE		[ \t\r]+

DIGIT 		[0-9]
LETTER		[a-zA-Z]

IDENT 		({LETTER}|_)({LETTER}|{DIGIT}|_)*
INTCONST 	({SUB}|{ADD})*{DIGIT}+
STRCONST	"\""[^\n]*"\""

LPAREN		"(" 		
RPAREN 		")"
ADD 		"+"
MULT 		"*"
DIV 		"/"
SUB 		"-"

LT 			"<"
GT 			">"
LE 			"<="
GE 			">="
EQ 			"="
NE 			"/="
COMMENT     ;.*
NEWLINE		\n

%%

"let*"		{
				printTokenInfo("LETSTAR", yytext);
				beginScope();
				return T_LETSTAR;
			}

"lambda"	{
				printTokenInfo("LAMBDA", yytext);
				beginScope();
				return T_LAMBDA;
			}

"input"		{
				printTokenInfo("INPUT", yytext);
				return T_INPUT;
			}

"print"		{
				printTokenInfo("PRINT", yytext);
				return T_PRINT;
			}

"and"		{
				printTokenInfo("AND", yytext);
				return T_AND;
			}

"if"		{
				printTokenInfo("IF", yytext);
				return T_IF;
			}

"or"		{
				printTokenInfo("OR", yytext);
				return T_OR;
			}

"not"		{
				printTokenInfo("NOT", yytext);
				return T_NOT;
			}

"t"			{
				printTokenInfo("T", yytext);
				return T_T;
			}

"nil"		{
				printTokenInfo("NIL", yytext);
				return T_NIL;
			}


{COMMENT}	{  }

{LPAREN}	{
				printTokenInfo("LPAREN", yytext);
				return T_LPAREN;
			}

{RPAREN}	{
				printTokenInfo("RPAREN", yytext);
				return T_RPAREN;
			}

{ADD}		{
				printTokenInfo("ADD", yytext);
				return T_ADD;
			}

{MULT}		{
				printTokenInfo("MULT", yytext);
				return T_MULT;
			}

{DIV}		{
				printTokenInfo("DIV", yytext);
				return T_DIV;
			}

{SUB}		{
				printTokenInfo("SUB", yytext);
				return T_SUB;
			}

{LT}		{
				printTokenInfo("LT", yytext);
				return T_LT;
			}

{GT}		{
				printTokenInfo("GT", yytext);
				return T_GT;
			}			

{LE}		{
				printTokenInfo("LE", yytext);
				return T_LE;
			}		

{GE}		{
				printTokenInfo("GE", yytext);
				return T_GE;
			}			

{EQ}		{
				printTokenInfo("EQ", yytext);
				return T_EQ;
			}

{NE}		{
				printTokenInfo("NE", yytext);
				return T_NE;
			}			

{INTCONST}	{
				printTokenInfo("INTCONST", yytext);
				return T_INTCONST;
			}

{IDENT}		{
				yylval.text = strdup(yytext);
				printTokenInfo("IDENT", yytext);
				return T_IDENT;
			}

{STRCONST}	{
				printTokenInfo("STRCONST", yytext);
				return T_STRCONST;
			}

{NEWLINE}	{
				numLines++;
			}

{WSPACE}	{ }

.			{
				printTokenInfo("UNKNOWN", yytext);
				return T_UNKNOWN;
			}

%%
