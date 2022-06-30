#Syntactic Anallyser: Parser
from ply.yacc import yacc
from lex_bla import tokens
import argparse
import sys

def p_expression_plus(p):
    'expression : expression A term'
    p[0] = p[1] + p[3]

def p_expression_minus(p):
    'expression : expression S term'
    p[0] = p[1] - p[3]

def p_expression_term(p):
    'expression : term'
    p[0] = p[1]

def p_term_times(p):
    'term : term M factor'
    p[0] = p[1] * p[3]

def p_term_div(p):
    'term : term D factor'
    p[0] = p[1] / p[3]

def p_term_factor(p):
    'term : factor'
    p[0] = p[1]
def p_factor_expr(p):
    'factor : ( expression )'
    p[0] = p[2]

def p_factor_num(p):
    'factor : BINARY_LITERAL'
    p[0] = p[1]

def p_factor_id(p):
    'factor :   ID'
    p[0]=p[1]

# Error rule for syntax errors
def p_error(p):
    print("Syntax error in input!")

parser = yacc.yacc()

def main():
    filename = "bla_samples/" + sys.argv[1]
    filein = open(filename, 'r')
    lines = filein.readlines()
    filein.close()
    
    while True:
        try:
            s = raw_input(sys.argv[1])
        except EOFError:
            break
        if not s: continue
        result = parser.parse(s)
        print(result)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print('Usage: parse_bla.py my_program.bla')
    else:
        main()