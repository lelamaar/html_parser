#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

int line;

typedef struct stack {
	char tagName[20];
	struct stack* link;
} tagStack;

tagStack* top;
tagStack* root;

void tagStackPush(char* value) {
	tagStack* tmp, * tmp2;
	tmp = (tagStack*)malloc(sizeof(tagStack));
	tmp2 = (tagStack*)malloc(sizeof(tagStack));
	for (int i = 0; i < strlen(value); i++)
		tmp->tagName[i] = value[i];
	tmp->tagName[strlen(value)] = '\0';
	tmp2 = root;
	while (tmp2->link != NULL)
		tmp2 = tmp2->link;
	tmp->link = top;
	top = tmp;
}

void tagStackPop() {
	tagStack* tmp;
	if (top == NULL) {
		printf("\nStack Underflow");
		return;
	}
	tmp = top;
	top = top->link;
	tmp->link = NULL;
	free(tmp);
}

int tagStackIsEmpty() {
	return top == NULL;
}

char* tagStackTop() {
	if (!tagStackIsEmpty())
		return top->tagName;
	else
		exit(1);
}

void tagStackDeinit() {
	while (!tagStackIsEmpty())
	{
		tagStackPop();
	}
}

void tagStackInit() {
	tagStack* tmproot;
	tmproot = (tagStack*)malloc(sizeof(tagStack));
	tmproot->link = NULL;
	root = tmproot;
	top = NULL;
}

void tagStackPrint() {
	tagStack* tmp;

	if (top == NULL) {
		printf("\nStack Underflow");
		exit(1);
	}

	tmp = top;
	while (tmp != NULL) {
		printf(" %s ", tmp->tagName);
		tmp = tmp->link;
	}
}


void tagStackCheck(char* data) {
	if (tagStackIsEmpty()) {
		printf("ERROR: there were no opening tags.\n");
		exit(-1);
	}
	int i;
	char newData[20];
	newData[0] = '<';
	for (i = 2; i < strlen(data); i++)
		newData[i - 1] = data[i];
	newData[i - 2] = '\0';
	if (strcmp(newData, tagStackTop())) {
		printf("ERROR: incorrect nesting of tags on line %d.\n", line);
		printf("Expected: %s>; received: %s>.\n", tagStackTop(), newData);
		tagStackDeinit();
		exit(-1);
	}
	tagStackPop();
}