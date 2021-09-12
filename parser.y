%{
	#define YYERROR_VERBOSE 1
	#include <stdio.h>
	extern int line;
	/*
	other: 
	  | other TAG_START payload other TAG_END TAG_CLOSE
	  | other TAG_COMMENT_START TAG_COMMENT_END

	payload: TAG_CLOSE
	   | atr_sequence TAG_CLOSE
	   
	atr_sequence: ATTRIBUTE VALUE
	   | atr_sequence ATTRIBUTE VALUE
	*/
%}

%token CLOSING_MORE_SIGN
%token TAG_DOCKTYPE TAG_COMMENT_START TAG_COMMENT_END
%token TAG_HTML TAG_HTML_CLOSE
%token TAG_HEAD TAG_HEAD_CLOSE
%token HEAD_SECTION_TAG HEAD_SECTION_TAG_CLOSE
%token TAG_BODY TAG_BODY_CLOSE
%token COMMON_TAG COMMON_TAG_CLOSE
%token ATTRIBUTE VALUE
%%

html_doc: TAG_DOCKTYPE html_section
		| error { yyerrok; printf("in line %d.\n", line); exit(-1);}

html_section: html_section_start head_section body_section TAG_HTML_CLOSE

html_section_start: TAG_HTML payload

head_section: head_section_start head_section_content

head_section_start: TAG_HEAD payload

head_section_content:
	   | TAG_HEAD_CLOSE
	   | head_section_content HEAD_SECTION_TAG payload head_section_content HEAD_SECTION_TAG_CLOSE
	   | head_section_content TAG_COMMENT_START TAG_COMMENT_END

body_section: body_section_start body_section_content

body_section_start: TAG_BODY payload

body_section_content:
	   | body_section_content COMMON_TAG payload body_section_content COMMON_TAG_CLOSE
	   | body_section_content TAG_COMMENT_START TAG_COMMENT_END

payload: CLOSING_MORE_SIGN
	   | atr_sequence CLOSING_MORE_SIGN
	   
atr_sequence: ATTRIBUTE VALUE
	   | atr_sequence ATTRIBUTE VALUE

%%