%{

/* Tokens do scanner C */

#define KW      1     // Palavras-Chave: int, float, if, else, for, while, return
#define ID      2     // Nomes de variáveis e funções
#define DEC     3     // Decimal inteiro
#define OCT     4     // Octal
#define HEX     5     // Hexadecimal
#define FLOAT   6     // Números de ponto flutuante
#define OP      7     // Operadores: +, -, *, /, %, ++, --
#define RELOP   8     // Operadores Relacionais: ==, !=, <, <=, >, >=, =
#define DELIM   9     // Delimitadores: (, ), {, }, ;, ,
#define SPC     10    // Espaço e tab
#define ENT     11    // Quebra de linha
#define UNK     12    // Qualquer caractere não reconhecido
#define END     13    // Final de arquivo

%}

%%

int|char|float|double|if|else|for|while|return   { return KW;     }
[a-zA-Z_][a-zA-Z0-9_]*                           { return ID;     }
0[xX][0-9A-Fa-f]+                                { return HEX;    } 
0[0-7]+                                          { return OCT;    } 
[0-9]+\.[0-9]*([eE][+-]?[0-9]+)?                 { return FLOAT;  } 
[0-9]+                                           { return DEC;    } 
"=="|"!="|"<="|">="|"<"|">"|"="                  { return RELOP;  }
"++"|"--"|"+"|"-"|"*"|"/"|"%"                    { return OP;     }
[()\{\};,]  								     { return DELIM;  }
[\n]										     { return ENT;    }
[ \t]+                                           { /* ignora */   }
"//".*                                           { /* ignora */   }
"/*"([^*]|\*+[^*/])*\*+"/"                       { /* ignora */   }
.                                                { return UNK;    }
<<EOF>>                                          { return END;    }

%%

const char* nomeToken(int token)
{
    switch(token)
    {
        case KW:    return "KW";
        case ID:    return "ID";
        case DEC:   return "DEC";
        case OCT:   return "OCT";
        case HEX:   return "HEX";
        case FLOAT: return "FLOAT";
        case OP:    return "OP";
        case RELOP: return "RELOP";
        case DELIM: return "DELIM";
        case SPC:   return "SPC";
        case ENT:   return "ENT";
        case UNK:   return "UNK";
        case END:   return "EOF";
        default:    return "???";
    }
}

int main(int argc, char *argv[])
{
	FILE *f_in;     // Usado para abrir e ler o arquivo
	int tipoToken;  // Usado para receber o código do tipo do token e converter para o nome
	int linha = 1;  // Cria o contador de linhas

	if(argc == 2)
	{
		if((f_in = fopen(argv[1], "r")) != NULL)
		{
			yyin = f_in;
		}
		else
		{
			perror(argv[1]);
    		return 1;
		}
	}
	else
	{
		yyin = stdin;
	}

	printf("[L%d]   ", linha);

	while((tipoToken = yylex()) != END)
	{
		if (tipoToken == ENT){
			linha++;
        	printf("\n[L%d]   ", linha);
		}
		else
			printf("%s(%s) ", nomeToken(tipoToken), yytext);
	}
}