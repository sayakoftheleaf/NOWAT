#[macro_use]
use derive_builder::*;

#[derive(Debug, PartialEq, Clone)]

pub struct AST {
    pub functions: Vec<Function>,
}

#[derive(Debug, Builder, PartialEq, Clone)]
#[builder(setter(into))]
pub struct Function {
    pub name: String,
    pub return_type: Types,
    pub statements: Vec<Statement>,
}

#[derive(Debug, PartialEq, Clone)]
pub enum Types {
    Integer,
}

#[derive(Debug, PartialEq, Clone)]
pub enum Value {
    Literal(String),
    Variable(String),
}

#[derive(Debug, PartialEq, Clone)]
pub enum Statement {
    Return(Value),
}
