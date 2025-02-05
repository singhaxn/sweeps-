%{
#include "parser.tab.h"

int yyerror(char*);
%}

%%
[ \t\n]			continue;

"x"|"y"|"z"		{
					if(e->functionType()==Expression::FTYPE_1 || e->functionType()==Expression::FTYPE_2) {
						e->addToken(yytext, tokVariable);
						return tokVariable;
					} else
						return tokErr;
				}

"s"				{
					if(e->functionType()==Expression::FTYPE_1) {
						e->addToken(yytext, tokVariable);
						return tokVariable;
					} else
						return tokErr;
				}

"t"				{
					if(e->functionType()==Expression::FTYPE_3) {
						e->addToken(yytext, tokVariable);
						return tokVariable;
					} else
						return tokErr;
				}

([0-9]+("."[0-9]+)?)|("."[0-9]+)		{
					e->addToken(yytext, tokNumber);
					return tokNumber;
				}

"sin"|"cos"|"tan"|"cosec"|"sec"|"cot"|"log"|"sqrt"|"abs"|"exp"|"asin"|"acos"|"atan"	{
					e->addToken(yytext, tokFunction);
					return tokFunction;
				}

"*"|"/"|"+"|"-"|"^" 		{
					e->addToken(yytext, tokOperator);
					return tokOperator;
				}

"("				{
					e->addToken(yytext, '(');
					return '(';
				}

")"				{
					e->addToken(yytext, ')');
					return ')';
				}

";"				{
					e->addToken(yytext, ';');
					return ';';
				}

<<EOF>>			{
					return tokEOF;
				}

.				{
					char str[20];
					
					cerr<<"Error: Unrecognized symbol "<<yytext<<endl;
					return tokErr;
				}
%%

int yywrap()
{
	return 1;
}
