%{
int COUNT = 0;
%}

identifier [_a-zA-Z][a-zA-Z0-9_]*
invalidtokens [0-9]+[a-zA-Z]+

%%

#.* {
  printf("\n%s is a preprocessor directive", yytext);
}

auto |
break |
case |
char |
const |
continue |
default |
do |
double |
else |
enum |
extern |
float |
for |
goto |
if |
int |
long |
register |
return |
short |
signed |
sizeof |
static |
struct |
switch |
typedef |
union |
unsigned |
void |
volatile |

while {
  printf("\n%s is a keyword", yytext);
}

{invalidtokens} {
  if (!COUNT) printf("\n%s is an Invalid token", yytext);
}

"/*" {
  COUNT = 1;
  printf("\n%s is a comment", yytext);
}

\; |
\, |
\) |
\( |
\{ |
\} {
  if (!COUNT) printf("\n%s is a separator", yytext);
}

{identifier} {
  if (!COUNT) printf("\n%s is an identifier", yytext);
}

\".*\" {
  if (!COUNT) printf("\n%s is a string", yytext);
}

[0-9]+ {
  if (!COUNT) printf("\n%s is a constant ", yytext);
}

\/ |
\* |
\- |
\+ |
= |
\<= |
\>= |
\< |
== |
\> {
  if (!COUNT) printf("\n%s is an operator", yytext);
}

%%

int main(int argc, char **argv) {
  FILE *file;
  file = fopen("input.c", "r");
  if (!file) {
    printf("UNABLE TO OPEN THE FILE");
    exit(0);
  }
  yyin = file;
  yylex();
  printf("\n");
  return 0;
}

int yywrap() {
  return 1;
}
