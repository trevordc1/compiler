# compiler
compile scanner with: 
lex scanner.l
gcc lex.yy.c -ll -o scanner

run scanner with: 
./scanner example.txt
