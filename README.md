# C Lexical Analyzer

Este é um analisador lexical simples em C usando **Flex**.

Este lexer identifica palavras-chave (KW), identificadores (ID), delimitadores (DELIM), operadores (OP) e números decimais (DEC).
Testado com um programa de Fibonacci simples, mas pode ser usado para outros códigos em C.

### Como rodar

Para compilar e executar o lexer, siga os comandos abaixo:


### Gerar o código C a partir do arquivo lexer.l
flex --noyywrap lexer.l

### Compilar o código gerado
gcc lex.yy.c -o lexer.exe

### Executar o lexer em um arquivo de teste
./lexer.exe test.c

Usei um programa genérico de Fibonacci como entrada (test.c).

#### O resultado esperado do lexer é:<br><br>
[L1]   KW(int) ID(fib) DELIM(() KW(int) ID(n) DELIM()) DELIM({)<br>
[L2]   KW(if) DELIM(() ID(n) RELOP(<=) DEC(1) DELIM()) DELIM({)<br>
[L3]   KW(return) ID(n) DELIM(;)<br>
[L4]   DELIM(}) KW(else) DELIM({)<br>
[L5]   KW(return) ID(fib) DELIM(() ID(n) OP(-) DEC(1) DELIM()) OP(+) ID(fib) DELIM(() ID(n) OP(-) DEC(2) DELIM()) DELIM(;)<br>
[L6]   DELIM(})<br>
[L7]   DELIM(})<br>
<br>
[L8]   KW(int) ID(main) DELIM(() DELIM()) DELIM({)<br>
[L9]   KW(int) ID(resultado) RELOP(=) ID(fib) DELIM(() DEC(5) DELIM()) DELIM(;)<br>
[L10]  KW(return) DEC(0) DELIM(;)<br>
[L11]  DELIM(})<br>
