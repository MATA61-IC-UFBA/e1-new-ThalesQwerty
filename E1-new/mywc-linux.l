/* just like Unix wc */
%{
#include <stdbool.h>

int chars = 0;
int words = 0;
int lines = 0;
bool readingWord = false;

void startWord() {
    if (!readingWord) {
        readingWord = true;
        words ++;
    }
}

void endWord() {
    readingWord = false;
}
%}

%%
\n { lines++; chars++; endWord(); }
[\r\n\t\f\v ] { chars++; endWord(); }
. { chars++; startWord(); }
%%

int main(int argc, char **argv)
{
endWord();
yylex();
printf("%8d%8d%8d\n", lines, words, chars);
return 0;
}