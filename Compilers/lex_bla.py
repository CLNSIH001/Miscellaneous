#Lexical Analyser: Lexer
import ply.lex as lex
import sys

literals = ['A', 'S', 'M', 'D', '(', '=', ')']
tokens = ('ID', 'BINARY_LITERAL', 'WHITESPACE', 'COMMENT')

t_BINARY_LITERAL = r'-?\d+'
t_ID = r'[a-z_][a-z0-9_]*'
t_WHITESPACE = r'\s'
t_COMMENT = r"/\*([^*]|[\s+]|(\*+([^*/]|[\r\n])))*\*+/|/\*.*\*/|//.*"

# Error handling rule
def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

lexer = lex.lex()

def main():
    filein = open(sys.argv[1], 'r')
    text = filein.read()
    filein.close()
    
    lexer.input(text)
    text = text[:-1]
    filename = sys.argv[1][:-3] + "tkn"
    fileout = open(filename, 'w')
    while True:
        tok = lexer.token()
        if not tok: 
            break      # No more input
        if (tok.type == 'BINARY_LITERAL' or tok.type == 'ID'):
            print(tok.type + "," + tok.value, file=fileout)
            print(tok.type + "," + tok.value)
        else:
            print(tok.type, file=fileout)
            print(tok.type)
                
    fileout.close()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print('Usage: lex_bla.py my_program.bla')
    else:
        main()