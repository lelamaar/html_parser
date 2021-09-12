#pragma once

typedef struct stack {
	char tagName[20];
	struct stack* link;
} tagStack;

char* tagStackPop();
void tagStackDeinit();
void tagStackInit();
void tagStackPrint();
int tagStackIsEmpty();

void tagStackCheck(char* data);
void tagStackPush(char* value);