/*
	tarakaim.l

	Homework #1 -- CS 3500: Programming Languages & Translators
	Dr. Jennifer Leopold
	Mark Tarakai

	To create the lexical analyzer, follow the procedure below:
	
	flex <filename>.l
	g++ lex.yy.c -o lexer
	lexer < <inputFileName>
*/

%{
	/* Define the tokens */
	
	#define T_IDENT		1
	#define T_INTCONST	2
	#define T_LETSTAR	3
	#define T_LAMBDA	4
	#define T_INPUT		5
	#define T_PRINT		6
	#define T_IF		7
	#define T_LPAREN	8
	#define T_RPAREN	9
	#define T_ADD		10
	#define T_MULT		11
	#define T_DIV		12
	#define T_SUB		13
	#define T_AND		14
	#define T_OR		15
	#define T_NOT		16
	#define T_LT		17
	#define T_GT		18
	#define T_LE		19
	#define T_GE		20
	#define T_EQ		21
	#define T_NE		22
	#define T_STRCONST	23
	#define T_T			24
	#define T_NIL		25
	#define T_UNKNOWN	26

	int numLines = 0;
	
	void printTokenInfo(const char* tokenType, const char* lexeme);	
%}

/* Define REGEX here */

WSPACE		[ \t\r\n]+

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

%%

"let*"		{
				printTokenInfo("LETSTAR", yytext);
				return T_LETSTAR;
			}

"lambda"	{
				printTokenInfo("LAMBDA", yytext);
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
				printTokenInfo("IDENT", yytext);
				return T_IDENT;
			}

{STRCONST}	{
				printTokenInfo("STRCONST", yytext);
				return T_STRCONST;
			}

{WSPACE}	{ }

.			{
				printTokenInfo("UNKNOWN", yytext);
				return T_UNKNOWN;
			}

%%

/* UI */

void printTokenInfo(const char* tokenType, const char* lexeme)
{
	printf("TOKEN: %-8s  LEXEME: %s\n", tokenType, lexeme);
}

/* yywrap function */

int yywrap()
{
	return 1; /* check for input */
}

/* Here lies the main */

int main()
{
	while( yylex() ); /* Continue Processing until 0 is returned */
	return 0;
}