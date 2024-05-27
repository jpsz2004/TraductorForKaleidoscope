import plyplus
import sys
from plyplus import STransformer

class Hvisitor(plyplus.STransformer):
    def program(self, args):
        return args

    def lista(self, args):
        return list(args[1:-1])  # Ignorar QUOTE y los paréntesis

    def elementos(self, args):
        return args
    
    def elemento(self, args):
        return args[0]
    
    def NUMBER(self, tok):
        try:
            return int(tok)
        except ValueError:
            return float(tok)
    
    def STRING(self, tok):
        return tok[1:-1]
    
    def NIL(self, tok):
        return None




#Llamada principal a la gramática y al visitante

if __name__ == '_main_':
    if len(sys.argv) != 3:
        print("Example call: {} input.txt output.cpp".format(sys.argv[0]))
    else:
        sourceFile = sys.argv[1]
        targetFile = sys.argv[2]
        with open('kaleidoscope.g', 'r') as grm:
            with open(sourceFile, 'r') as scode:
                parser = plyplus.Grammar(grm.read())
                ast = parser.parse(scode.read())
                with open(targetFile, 'w') as tfile:
                    tfile.write(STransformer().transform(ast))
                    print("Translation done")
                    print("Output written to {}".format(targetFile))