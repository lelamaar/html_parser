/* Declaration section*/
%{
	#define _CRT_SECURE_NO_WARNINGS
	#include "stackFuncs.cpp"
	#include <stdio.h>
	#include "parser.tab.h"
	
	extern FILE* yyin;
	int line = 1;
	#ifndef unix
	#define fileno _fileno
	#endif
%}

%option stack yylineno
%x attr_exp
%x title_attr_exp
%x title_text_exp
%x comment_continue
%x style_section
%x style_attr_exp
%x script_section
%x script_attr_exp

whitespace			[ \t\r\n]
int       			[0-9]+
name 				[a-zA-Z_]+[:a-zA-Z_0-9\.\-]*
str 				[a-zA-Z_]+[ :a-zA-Z_0-9\.]*

tagDOCTYPE			\![dD][oO][cC][tT][yY][pP][eE][ ]+[hH][tT][mM][lL]
tagHTML				[hH][tT][mM][lL]
tagHEAD				[hH][eE][aA][dD]
tagBODY				[bB][oO][dD][yY]
tagTITLE			[tT][iI][tT][lL][eE]

tagsAC				[aA]|[aA][bB][bB][rR]|[aA][dD][dD][rR][eE][sS][sS]|[aA][rR][tT][iI][cC][lL][eE]|[aA][sS][iI][dD][eE]|[aA][uU][dD][iI][oO]|[bB]|[bB][dD][iI]|[bB][dD][oO]|[bB][lL][oO][cC][kK][qQ][uU][oO][tT][eE]|[bB][uU][tT][tT][oO][nN]|[cC][aA][nN][vV][aA][sS]|[cC][aA][pP][tT][iI][oO][nN]|[cC][iI][tT][eE]|[cC][oO][dD][eE]|[cC][oO][lL][gG][rR][oO][uU][pP]
tagsDH    			[dD][aA][tT][aA]|[dD][aA][tT][aA][lL][iI][sS][tT]|[dD][dD]|[dD][eE][lL]|[dD][eE][tT][aA][iI][lL][sS]|[dD][fF][nN]|[dD][iI][aA][lL][oO][gG]|[dD][iI][vV]|[dD][lL]|[dD][tT]|[eE][mM]|[eE][mM][bB][eE][dD]|[fF][iI][eE][lL][dD][sS][eE][tT]|[fF][iI][g][cC][aA][pP][tT][iI][oO][nN]|[fF][iI][gG][uU][rR][eE]|[fF][oO][oO][tT][eE][rR]|[fF][oO][rR][mM]|[hH]1|[hH]2|[hH]3|[hH]4|[hH]5|[hH]6|[hH][eE][aA][dD][eE][rR]|[hH][gG][rR][oO][uU][pP]
tagsIO    			[iI]|[iI][fF][rR][aA][mM][eE]|[iI][nN][sS]|[kK][bB][dD]|[lL][aA][bB][eE][lL]|[lL][eE][gG][eE][nN][dD]|[lL][iI]|[mM][aA][iI][nN]|[mM][aA][pP]|[mM][aA][rR][kK]|[mM][eE][tT][eE][rR]|[nN][aA][vV]|[oO][bB][jJ][eE][cC][tT]|[oO][lL]|[oO][pP][tT][gG][rR][oO][uU][pP]|[oO][pP][tT][iI][oO][nN]|[oO][uU][tT][pP][uU][tT]|[mM][eE][nN][uU]
tagsPS    			[pP]|[pP][iI][cC][tT][uU][rR][eE]|[pP][rR][eE]|[pP][rR][oO][gG][rR][eE][sS][sS]|[qQ]|[rR][pP]|[rR][tT]|[rR][uU][bB][yY]|[sS]|[sS][aA][mM][pP]|[sS][eE][cC][tT][iI][oO][nN]|[sS][eE][lL][eE][cC][tT]|[sS][mM][aA][lL][lL]|[sS][pP][aA][nN]|[sS][tT][rR][oO][nN][gG]|[sS][uU][bB]|[sS][uU][mM][mM][aA][rR][yY]|[sS][uU][pP]|[sS][vV][gG]
tagsTW   			[tT][aA][bB][lL][eE]|[tT][bB][oO][dD][yY]|[tT][dD]|[tT][eE][mM][pP][lL][aA][tT][eE]|[tT][eE][xX][tT][aA][rR][eE][aA]|[tT][fF][oO][oO][tT]|[tT][hH]|[tT][hH][eE][aA][dD]|[tT][iI][mM][eE]|[tT][rR]|[tT][rR][aA][cC][kK]|[uU]|[uU][lL]|[vV][aA][rR]|[vV][iI][dD][eE][oO]|[wW][bB][rR]

tagsALL				{tagsAC}|{tagsDH}|{tagsIO}|{tagsPS}|{tagsTW}
generalTags			[nN][oO][sS][cC][rR][iI][pP][tT]

styleTag			[sS][tT][yY][lL][eE]
scriptTag			[sS][cC][rR][iI][pP][tT]

headTagsVoid		[mM][eE][tT][aA]|[bB][aA][sS][eE]|[lL][iI][nN][kK]

voidTags			[bB][rR]|[hH][rR]|[iI][nN][pP][uU][tT]|[aA][rR][eE][aA]|[cC][oO][lL]|[iI][mM][gG]|[pP][aA][rR][aA][mM]|[cC][oO][mM][mM][aA][nN][dD]|[sS][oO][uU][rR][cC][eE]
oldVersionTags		[aA][cC][rR][oO][nN][yY][mM]|[aA][pP][pP][lL][eE][tT]|[bB][aA][sS][eE][fF][oO][nN][tT]|[bB][iI][gG]|[cC][eE][nN][tT][eE][rR]|[dD][iI][rR]|[fF][oO][nN][tT]|[fF][rR][aA][mM][eE]|[fF][rR][aA][mM][eE][sS][eE][tT]|[nN][oO][fF][rR][aA][mM][eE][sS]|[sS][tT][rR][iI][kK][eE]|[tT][tT]|[kK][eE][yY][gG][eE][nN]

attributes1			[aA][cC][cC][eE][pP][tT]|[aA][cC][cC][eE][pP][tT][-][cC][hH][aA][rR][sS][eE][tT]|[aA][cC][cC][eE][sS][sS][kK][eE][yY]|[aA][cC][tT][iI][oO][nN]|[aA][lL][tT]|[aA][sS][yY][nN][cC]|[aA][uU][tT][oO][cC][oO][mM][pP][lL][eE][tT][eE]|[aA][uU][tT][oO][fF][oO][cC][uU][sS]|[aA][uU][tT][oO][pP][lL][aA][yY]|[cC][hH][aA][rR][sS][eE][tT]|[cC][hH][eE][cC][kK][eE][dD]|[cC][iI][tT][eE]|[cC][lL][aA][sS][sS]|[cC][oO][lL][sS]|[cC][oO][lL][sS][pP][aA][nN]|[cC][oO][nN][tT][eE][nN][tT]
attributes2			[cC][oO][nN][tT][eE][nN][tT][eE][dD][iI][tT][aA][bB][lL][eE]|[cC][oO][nN][tT][rR][oO][lL][sS]|[cC][oO][oO][rR][dD][sS]|[dD][aA][tT][aA]|[dD][aA][tT][eE][tT][iI][mM][eE]|[dD][eE][fF][aA][uU][lL][tT]|[dD][eE][fF][eE][rR]|[dD][iI][rR]|[dD][iI][rR][nN][aA][mM][eE]|[dD][iI][sS][aA][bB][lL][eE][dD]|[dD][oO][wW][nN][lL][oO][aA][dD]|[dD][rR][aA][gG][gG][aA][bB][lL][eE]|[eE][nN][cC][tT][yY][pP][eE]|[fF][oO][rR]|[fF][oO][rR][mM]|[fF][oO][rR][mM][aA][cC][tT][iI][oO][nN]|[hH][eE][aA][dD][eE][rR][sS]
attributes3			[hH][eE][iI][gG][hH][tT]|[hH][iI][dD][dD][eE][nN]|[hH][iI][gG][hH]|[hH][rR][eE][fF]|[hH][rR][eE][fF][lL][aA][nN][gG]|[hH][tT][tT][pP][-][eE][qQ][uU][iI][vV]|[iI][dD]|[iI][sS][mM][aA][pP]|[kK][iI][nN][dD]|[lL][aA][bB][eE][lL]|[lL][aA][nN][gG]|[lL][iI][sS][tT]|[lL][oO][oO][pP]|[lL][oO][wW]|[mM][aA][xX]|[mM][aA][xX][lL][eE][nN][gG][tT][hH]|[mM][eE][dD][iI][aA]|[mM][eE][tT][hH][oO][dD]|[mM][iI][nN]|[mM][uU][lL][tT][iI][pP][lL][eE]|[mM][uU][tT][eE][dD]|[nN][aA][mM][eE]|[nN][oO][vV][aA][lL][iI][dD][aA][tT][eE]
attributes4			[oO][nN][aA][bB][oO][rR][tT]|[oO][nN][aA][fF][tT][eE][rR][pP][rR][iI][nN][tT]|[oO][nN][bB][eE][fF][oO][rR][eE][pP][rR][iI][nN][tT]|[oO][nN][bB][eE][fF][oO][rR][eE][uU][nN][lL][oO][aA][dD]|[oO][nN][bB][lL][uU][rR]|[oO][nN][cC][aA][nN][pP][lL][aA][yY]|[oO][nN][cC][aA][nN][pP][lL][aA][yY][tT][hH][rR][oO][uU][gG][hH]|[oO][nN][cC][hH][aA][nN][gG][eE]|[oO][nN][cC][lL][iI][cC][kK]|[oO][nN][cC][oO][nN][tT][eE][xX][tT][mM][eE][nN][uU]|[oO][nN][cC][oO][pP][yY]
attributes5			[oO][nN][cC][uU][eE][cC][hH][aA][nN][gG][eE]|[oO][nN][cC][uU][tT]|[oO][nN][dD][bB][lL][cC][lL][iI][cC][kK]|[oO][nN][dD][rR][aA][gG]|[oO][nN][dD][rR][aA][gG][eE][nN][dD]|[oO][nN][dD][rR][aA][gG][eE][nN][tT][eE][rR]|[oO][nN][dD][rR][aA][gG][lL][eE][aA][vV][eE]|[oO][nN][dD][rR][aA][gG][oO][vV][eE][rR]|[oO][nN][dD][rR][aA][gG][sS][tT][aA][rR][tT]|[oO][nN][dD][rR][oO][pP]|[oO][nN][dD][uU][rR][aA][tT][iI][oO][nN][cC][hH][aA][nN][gG][eE]|[oO][nN][eE][mM][pP][tT][iI][eE][dD]|[oO][nN][eE][nN][dD][eE][dD]
attributes6			[oO][nN][eE][rR][rR][oO][rR]|[oO][nN][fF][oO][cC][uU][sS]|[oO][nN][hH][aA][sS][hH][cC][hH][aA][nN][gG][eE]|[oO][nN][iI][nN][pP][uU][tT]|[oO][nN][iI][nN][vV][aA][lL][iI][dD]|[oO][nN][kK][eE][yY][dD][oO][wW][nN]|[oO][nN][kK][eE][yY][pP][rR][eE][sS][sS]|[oO][nN][kK][eE][yY][uU][pP]|[oO][nN][lL][oO][aA][dD]|[oO][nN][lL][oO][aA][dD][eE][dD][dD][aA][tT][aA]|[oO][nN][lL][oO][aA][dD][eE][dD][mM][eE][tT][aA][dD][aA][tT][aA]|[oO][nN][lL][oO][aA][dD][sS][tT][aA][rR][tT]
attributes7			[oO][nN][mM][oO][uU][sS][eE][dD][oO][wW][nN]|[oO][nN][mM][oO][uU][sS][eE][mM][oO][vV][eE]|[oO][nN][mM][oO][uU][sS][eE][oO][uU][tT]|[oO][nN][mM][oO][uU][sS][eE][oO][vV][eE][rR]|[oO][nN][mM][oO][uU][sS][eE][uU][pP]|[oO][nN][mM][oO][uU][sS][eE][wW][hH][eE][eE][lL]|[oO][nN][oO][fF][fF][lL][iI][nN][eE]|[oO][nN][oO][nN][lL][iI][nN][eE]|[oO][nN][pP][aA][gG][eE][hH][iI][dD][eE]|[oO][nN][pP][aA][gG][eE][sS][hH][oO][wW]|[oO][nN][pP][aA][sS][tT][eE]|[oO][nN][pP][aA][uU][sS][eE]
attributes8			[oO][nN][pP][lL][aA][yY]|[oO][nN][pP][lL][aA][yY][iI][nN][gG]|[oO][nN][pP][oO][pP][sS][tT][aA][tT][eE]|[oO][nN][pP][rR][oO][gG][rR][eE][sS][sS]|[oO][nN][rR][aA][tT][eE][cC][hH][aA][nN][gG][eE]|[oO][nN][rR][eE][sS][eE][tT]|[oO][nN][rR][eE][sS][iI][zZ][eE]|[oO][nN][sS][cC][rR][oO][lL][lL]|[oO][nN][sS][eE][aA][rR][cC][hH]|[oO][nN][sS][eE][eE][kK][eE][dD]|[oO][nN][sS][eE][eE][kK][iI][nN][gG]|[oO][nN][sS][eE][lL][eE][cC][tT]|[oO][nN][sS][tT][aA][lL][lL][eE][dD]|[oO][nN][sS][tT][oO][rR][aA][gG][eE]
attributes9			[oO][nN][sS][uU][bB][mM][iI][tT]|[oO][nN][sS][uU][sS][pP][eE][nN][dD]|[oO][nN][tT][iI][mM][eE][uU][pP][dD][aA][tT][eE]|[oO][nN][tT][oO][gG][gG][lL][eE]|[oO][nN][uU][nN][lL][oO][aA][dD]|[oO][nN][vV][oO][lL][uU][mM][eE][cC][hH][aA][nN][gG][eE]|[oO][nN][wW][aA][iI][tT][iI][nN][gG]|[oO][nN][wW][hH][eE][eE][lL]|[oO][pP][eE][nN]|[oO][pP][tT][iI][mM][uU][mM]|[pP][aA][tT][tT][eE][rR][nN]|[pP][lL][aA][cC][eE][hH][oO][lL][dD][eE][rR]|[pP][oO][sS][tT][eE][rR]|[pP][rR][eE][lL][oO][aA][dD]
attributes10		[rR][eE][aA][dD][oO][nN][lL][yY]|[rR][eE][lL]|[rR][eE][qQ][uU][iI][rR][eE][dD]|[rR][eE][vV][eE][rR][sS][eE][dD]|[rR][oO][wW][sS]|[rR][oO][wW][sS][pP][aA][nN]|[sS][aA][nN][dD][bB][oO][xX]|[sS][cC][oO][pP][eE]|[sS][eE][lL][eE][cC][tT][eE][dD]|[sS][hH][aA][pP][eE]|[sS][iI][zZ][eE]|[sS][iI][zZ][eE][sS]|[sS][pP][aA][nN]|[sS][pP][eE][lL][lL][cC][hH][eE][cC][kK]|[sS][rR][cC]|[sS][rR][cC][dD][oO][cC]|[sS][rR][cC][lL][aA][nN][gG]|[sS][rR][cC][sS][eE][tT]|[sS][tT][aA][rR][tT]|[sS][tT][eE][pP]
attributes11		[tT][aA][bB][iI][nN][dD][eE][xX]|[tT][aA][rR][gG][eE][tT]|[tT][rR][aA][nN][sS][lL][aA][tT][eE]|[tT][yY][pP][eE]|[uU][sS][eE][mM][aA][pP]|[vV][aA][lL][uU][eE]|[wW][iI][dD][tT][hH]|[wW][rR][aA][pP]|[pP][rR][oO][pP][eE][rR][tT][yY]|[sS][tT][yY][lL][eE]|[rR][oO][lL][eE]
attributesALL       {attributes1}|{attributes2}|{attributes3}|{attributes4}|{attributes5}|{attributes6}|{attributes7}|{attributes8}|{attributes9}|{attributes10}|{attributes11}
oldVersionAttr		[aA][lL][iI][gG][nN]|[bB][gG][cC][oO][lL][oO][rR]|[bB][oO][rR][dD][eE][rR]|[cC][oO][lL][oO][rR]
attrWithoutValue	[iI][tT][eE][mM][sS][cC][oO][pP][eE]|[aA][sS][yY][nN][cC]|[dD][eE][fF][eE][rR]
attributesValue     \"[^<"]*\")|("'"[^<']*"'"
			  
commentTagStart		"\<\!\-\-"
commentTagEnd		"\-\-\>"
cdataTag			"\<!\[CDATA"
xmlTAG				"<\?"[xX][mM][lL]			
tagDOCTYPEold		\![dD][oO][cC][tT][yY][pP][eE][ ]+[hH][tT][mM][lL][ ]+[pP][uU][bB][lL][iI][cC]
			
%%
\<{tagDOCTYPE}\> {
	//printf("docktype: %s\n", yytext);
	return TAG_DOCKTYPE;
}

\<{tagDOCTYPEold} {
	//printf("docktype: %s\n", yytext);
	printf("ERROR: non-HTML5 docktype element on line %d.\n", line);
	exit(-1);
}

{xmlTAG} {
	//printf("xml: %s\n", yytext);
	printf("ERROR: XML declaration %d.\n", line);
	exit(-1);
}

{cdataTag} {
	//printf("cdata: %s\n", yytext);
	printf("ERROR: CDATA declaration (XML), %d.\n", line);
	exit(-1);	
}

\<{tagHTML} {
	//printf("start html tag: %s\n", yytext);
	//tagStackPush(yytext);
	BEGIN(attr_exp);
	return TAG_HTML;
}

\<{tagHEAD} {
	//printf("start head tag: %s\n", yytext);
	//tagStackPush(yytext);
	BEGIN(attr_exp);
	return TAG_HEAD;
}

\<{tagBODY} {
	//printf("start body tag: %s\n", yytext);
	//tagStackPush(yytext);
	BEGIN(attr_exp);
	return TAG_BODY;
}

\<{tagTITLE} {
	//printf("start title tag: %s\n", yytext);
	BEGIN(title_attr_exp);
	return TAG_TITLE;
}

\<{tagsALL} {
	//printf("start tag: %s\n", yytext);
	tagStackPush(yytext);
	BEGIN(attr_exp);
	return COMMON_TAG;
}

\<\/{tagHTML}{whitespace}*\> {
	//printf("close html tag: %s\n", yytext);
	//tagStackCheck(yytext);
	return TAG_HTML_CLOSE;
}

\<\/{tagHEAD}{whitespace}*\> {
	//printf("close head tag: %s\n", yytext);
	//tagStackCheck(yytext);
	return TAG_HEAD_CLOSE;
}

\<\/{tagBODY}{whitespace}*\> {
	//printf("close body tag: %s\n", yytext);
	//tagStackCheck(yytext);
	return TAG_BODY_CLOSE;
}

\<\/{tagTITLE}{whitespace}*\> {
	//printf("close title tag: %s\n", yytext);
	return TAG_TITLE_CLOSE;
}

\<{generalTags} {
	//printf("start general tag: %s\n", yytext);
	//tagStackPush(yytext);
	BEGIN(attr_exp);
	return GENERAL_TAG;
}

\<\/{generalTags}{whitespace}*\> {
	//printf("close general tag: %s\n", yytext);
	//tagStackCheck(yytext);
	return GENERAL_TAG_CLOSE;
}

\<{oldVersionTags} { 
	//printf("old version start tag: %s\n", yytext);
	printf("WARNING: no HTML5 tag %s %d\n", yytext, line);
	tagStackPush(yytext);
	BEGIN(attr_exp);
	return COMMON_TAG;
}
			 
\<{voidTags} {
	//printf("void tag: %s\n", yytext);
	BEGIN(attr_exp);
	return COMMON_VOID_TAG;
}

\<{headTagsVoid} {
	//printf("head void tag: %s\n", yytext);
    BEGIN(attr_exp);
	return HEAD_SECTION_VOID_TAG;
}

\<{styleTag} {
	//printf("style tag open: %s\n", yytext);
	BEGIN(style_attr_exp);
	return TAG_STYLE;
}

\<{scriptTag} {
	//printf("script tag open: %s\n", yytext);
	BEGIN(script_attr_exp);
	return TAG_SCRIPT;
}
			 
\<\/{tagsALL}{whitespace}*\> { 
	//printf("[end tag ok]: %s\n", yytext);
	tagStackCheck(yytext);
	return COMMON_TAG_CLOSE;
}
			 
\<{name} { 
	//printf("unknown start tag: %s\n", yytext);
	printf("WARNING: unknown tag %s, %d\n", yytext, line);
	//tagStackPush(yytext);
	//BEGIN(attr_exp);
	//return COMMON_TAG;
}
			 
\<\/{name}{whitespace}*\> { 
	//printf("unknown end tag: %s\n", yytext);
	printf("WARNING: unknown end tag %s, %d\n", yytext, line);
	//tagStackCheck(yytext);
	//return COMMON_TAG_CLOSE;
}

\<\/{oldVersionTags}{whitespace}*\> { 
	//printf("old version end tag: %s\n", yytext);
	printf("WARNING: no HTML5 end tag %s, %d\n", yytext, line);
	tagStackCheck(yytext);
	BEGIN(attr_exp);
	return COMMON_TAG_CLOSE;
}
			 
\<\/{voidTags} {
	printf("WARNING: non-HTML5 construction: %s, %d\n", yytext, line);
}

<attr_exp>{
	{attributesALL}{whitespace}*[=] { 
		//printf("[attr ok]: %s\n", yytext);
		return ATTRIBUTE; 
	}
	
	{oldVersionAttr}{whitespace}*[=] { 
		//printf("[old attr]: %s\n", yytext);
		printf("WARNING: no HTML5 attribute %s, %d\n", yytext, line);
		return ATTRIBUTE; 
	}
	
	{name}{whitespace}*[=] { 
		//printf("[unknown attr]: %s\n", yytext);
		printf("WARNING: unknown attribute %s, %d\n", yytext, line);
		return ATTRIBUTE;
	}
			 
	{whitespace}*{attributesValue} {
		//printf("[attr value ok]: %s\n", yytext);
		return VALUE;
	}
	
	[\n] {
		line++;
	}

	\/\> {
		printf("WARNING: non-HTML5 construction - selfclosing void tag: %s, %d\n", yytext, line);
		BEGIN(0);
		return CLOSING_MORE_SIGN;
	}

	[>] {
		//printf("CLOSING_MORE_SIGN: %s\n", yytext);
		BEGIN(0);
		return CLOSING_MORE_SIGN;
	}
			
	{whitespace} ;

	{attrWithoutValue}{whitespace}* ;

	. ;
}

<title_attr_exp>{
	{attributesALL}{whitespace}*[=] { 
		//printf("[attr ok]: %s\n", yytext);
		return ATTRIBUTE; 
	}
	
	{oldVersionAttr}{whitespace}*[=] { 
		printf("WARNING: no HTML5 attribute %s, %d\n", yytext, line);
		return ATTRIBUTE; 
	}
	
	{name}{whitespace}*[=] { 
		printf("WARNING: unknown attribute %s, %d\n", yytext, line);
		return ATTRIBUTE;
	}
			 
	{whitespace}*{attributesValue} {
		//printf("[attr value ok]: %s\n", yytext);
		return VALUE;
	}
	
	[>] {
		//printf("CLOSING_MORE_SIGN after title: %s\n", yytext);
		BEGIN(title_text_exp);
		return CLOSING_MORE_SIGN;
	}

	[\n] {
		line++;
	}

	{whitespace} ;
}

<title_text_exp>{
	\<\/{tagTITLE}{whitespace}*\> {
		//printf("Empty TITLE_TEXT");
		return TAG_TITLE_CLOSE;
	}

	[^ \t\r\n] {
		BEGIN(0);
		return TITLE_TEXT;
	}

	. ;
}

<style_attr_exp>{
	{attributesALL}{whitespace}*[=] { 
		//printf("[attr ok]: %s\n", yytext);
		return ATTRIBUTE; 
	}
	
	{oldVersionAttr}{whitespace}*[=] { 
		printf("WARNING: no HTML5 attribute %s, %d\n", yytext, line);
		return ATTRIBUTE; 
	}
	
	{name}{whitespace}*[=] { 
		printf("WARNING: unknown attribute %s, %d\n", yytext, line);
		return ATTRIBUTE;
	}
			 
	{whitespace}*{attributesValue} {
		//printf("[attr value ok]: %s\n", yytext);
		return VALUE;
	}
	
	[>] {
		//printf("CLOSING_MORE_SIGN after style: %s\n", yytext);
		BEGIN(style_section);
		return CLOSING_MORE_SIGN;
	}

	[\n] {
		line++;
	}

    {whitespace} ;
}

<style_section>{
	\<\/{styleTag}{whitespace}*\> {
		//printf("style tag close: %s\n", yytext);
		BEGIN(0);
		return TAG_STYLE_CLOSE;
	}

	[\n] {
		line++;
	}

	. ;
}

<script_attr_exp>{
	{attributesALL}{whitespace}*[=] { 
		//printf("[attr ok]: %s\n", yytext);
		return ATTRIBUTE; 
	}
	
	{oldVersionAttr}{whitespace}*[=] { 
		printf("WARNING: no HTML5 attribute %s, %d\n", yytext, line);
		return ATTRIBUTE; 
	}
	
	{name}{whitespace}*[=] { 
		printf("WARNING: unknown attribute %s, %d\n", yytext, line);
		return ATTRIBUTE;
	}
			 
	{whitespace}*{attributesValue} {
		//printf("[attr value ok]: %s\n", yytext);
		return VALUE;
	}

	[>] {
		//printf("CLOSING_MORE_SIGN after script: %s\n", yytext);
		BEGIN(script_section);
		return CLOSING_MORE_SIGN;
	}

	[\n] {
		line++;
	}
			
	{whitespace} ;

	{attrWithoutValue}{whitespace}* ;
}

<script_section>{
	\<\/{scriptTag}{whitespace}*\> {
		//printf("script tag close: %s\n", yytext);
		BEGIN(0);
		return TAG_SCRIPT_CLOSE;
	}

	[\n] {
		line++;
	}

	. ;
}

{commentTagStart} {
	//printf("comment open: %s\n", yytext);
	BEGIN(comment_continue);
	return TAG_COMMENT_START;
}

<comment_continue>{
	{commentTagEnd} {
		//printf("comment close: %s\n", yytext);
		BEGIN(0);
		return TAG_COMMENT_END;
	}

	[\n] {
		line++;
	}

	. ;
}

{str} ;

[\n] {
	line++;
}

[\r] ; 

. ;

%% 
  
int yywrap(){}

void yyerror(char *msg)
{
    printf("%s \n", msg); 
}
  
int main(int argc, char*argv[])
{
	errno_t err;
    
	if (argc < 2){
		printf("no filename\n");
		exit(-1);
	}

    if ((err = fopen_s(&yyin, argv[1], "r")) != 0) {
		printf("file not found.\n");
		exit(-1);
	} 
	tagStackInit();
    // The function that starts the analysis
	yyparse();
	tagStackDeinit();
	fclose(yyin);
	printf("Parse status - ok.\n");
    return 0;
}