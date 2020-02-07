#[macro_use]
use ::pest::{
    Parser,
    iterators::{Pair, Pairs},
};
use ::pest_derive::*;

use crate::ast::{Function, Statement, Types, Value, AST};

#[derive(Parser)]
#[grammar = "c.pest"]
pub struct CParser;

pub fn parser(string: &str) -> AST {
    let function = CParser::parse(Rule::function, string)
        .expect("unsuccessful parse")
        .next()
        .unwrap();

    // FIXME: only expects one function
    AST {
        functions: vec![parse_function(function)],
    }
}

fn parse_function(func: Pair<'_, Rule>) -> Function {
    let mut return_type = None;
    let mut identifier = None;
    let mut statement = None;

    for token in func.into_inner() {
        match token.as_rule() {
            Rule::types => match token.into_inner().next().unwrap().as_rule() {
                Rule::INT => return_type = Some(Types::Integer),
                _ => unreachable!(),
            },
            Rule::identifier => identifier = Some(token.as_str().to_string()),
            Rule::statement => {
                statement = Some(parse_statement(token));
            }
            _ => unreachable!(),
        }
    }

    Function {
        name: identifier.unwrap(),
        return_type: return_type.unwrap(),
        statements: vec![statement.unwrap()],
    }
}

fn parse_statement(token: Pair<'_, Rule>) -> Statement {
    let mut val;

    let statement = token.into_inner().next().unwrap();

    match statement.as_rule() {
        Rule::return_statement => {
            let return_val = statement.into_inner().next().unwrap();
            println!("{:#?}", return_val);
            match return_val.as_rule() {
                Rule::int_literal => val = Value::Literal(return_val.as_str().to_string()),
                _ => unreachable!(),
            }
        }
        _ => unreachable!(),
    }
    Statement::Return(val)
}
