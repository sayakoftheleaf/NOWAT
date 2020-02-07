#[derive(Debug, PartialEq)]
pub struct AST {
    pub functions: Vec<Function>,
}

#[derive(Debug, PartialEq)]
pub struct Function {
    pub name: String,
    pub return_type: Types,
    pub statements: Vec<Statement>,
}

#[derive(Debug, PartialEq)]
pub enum Types {
    Integer,
}

#[derive(Debug, PartialEq)]
pub enum Value {
    Literal(String),
    Variable(String),
}

#[derive(Debug, PartialEq)]
pub enum Statement {
    Return(Value),
}
