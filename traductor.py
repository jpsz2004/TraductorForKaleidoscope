from plyplus import Grammar, SVisitor

# Cargar la gramática desde el archivo
with open('Kaleidoscope.g', 'r') as f:
    grammar = Grammar(f.read())

class KaleidoscopeVisitor(SVisitor):
    def __init__(self):
        super(KaleidoscopeVisitor, self).__init__()
        self.cpp_code = ""

    def visit_funcion(self, node):
        function_name = node.tail[0].value
        params = ", ".join([param.value for param in node.tail[1].tail])
        self.cpp_code += f"auto {function_name}({params}) {{\n"
        self.visit(node.tail[2])  # Visit function body
        self.cpp_code += "}\n"

    def visit_llamada(self, node):
        function_name = node.tail[0].value
        args = ", ".join([self.visit(arg) for arg in node.tail[1].tail])
        return f"{function_name}({args});"

    def visit_operacion(self, node):
        if len(node.tail) == 2:  # Unary operation
            op = node.tail[0].value
            expr = self.visit(node.tail[1])
            return f"{op}{expr}"
        elif len(node.tail) == 3:  # Binary operation
            left = self.visit(node.tail[0])
            op = node.tail[1].value
            right = self.visit(node.tail[2])
            return f"{left} {op} {right}"

    def visit_condicion(self, node):
        condition = self.visit(node.tail[0])
        self.cpp_code += f"if ({condition}) {{\n"
        self.visit(node.tail[1])
        self.cpp_code += "}\n"
        if len(node.tail) == 3:  # Else part exists
            self.cpp_code += "else {\n"
            self.visit(node.tail[2])
            self.cpp_code += "}\n"

    def visit_lista(self, node):
        elements = ", ".join([self.visit(el) for el in node.tail])
        return f"std::vector<auto>{{ {elements} }}"

    def visit_objeto(self, node):
        class_name = node.tail[0].value
        args = ", ".join([self.visit(arg) for arg in node.tail[1].tail])
        return f"new {class_name}({args})"

    def visit_bool(self, node):
        return node.tail[0].value

    def visit_variable(self, node):
        return node.tail[0].value

    def visit_numero(self, node):
        return node.tail[0].value

    def visit_decimal(self, node):
        return f"{node.tail[0].value}.{node.tail[1].value}"

    def visit_logica(self, node):
        if len(node.tail) == 2:  # Unary logic operation
            return f"{node.tail[0].value} {self.visit(node.tail[1])}"
        elif len(node.tail) == 3:  # Binary logic operation
            left = self.visit(node.tail[0])
            op = node.tail[1].value
            right = self.visit(node.tail[2])
            return f"{left} {op} {right}"

    def visit_trigonometricas(self, node):
        func = node.tail[0].value.lower()  # Convert to lowercase for C++
        arg = self.visit(node.tail[1])
        return f"std::{func}({arg})"

    def default(self, node):
        return "".join(self.visit(child) for child in node.tail)

def parse_kaleidoscope_code(code):
    # Parsear el código de Kaleidoscope
    ast = grammar.parse(code)

    # Crear un visitante
    visitor = KaleidoscopeVisitor()
    
    # Recorrer el AST
    visitor.visit(ast)

    # Retornar el código C++ generado
    return visitor.cpp_code

if __name__ == '__main__':
    # Leer el archivo de entrada
    with open('input.kal', 'r') as f:
        code = f.read()

    # Parsear y recorrer el código de Kaleidoscope
    cpp_code = parse_kaleidoscope_code(code)

    # Escribir el código C++ a un archivo de salida
    with open('output.cpp', 'w') as f:
        f.write(cpp_code)
