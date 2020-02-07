use crate::cparser::ast::{Function, Statement, Types, Value, AST};
use crate::cparser::cparser::*;

#[test]
fn test_valid_stage_1() {
    let expected = AST {
        functions: vec![Function {
            name: "main".to_string(),
            return_type: Types::Integer,
            statements: vec![Statement::Return(Value::Literal("100".to_string()))],
        }],
    };

    let multi_digit = r#"
    int main(){
        return 100;
    }"#;

    let newlines = r#"
    int
    main
    (
    )
    {
    return
    100
    ;
    }"#;

    let no_newlines = "int main(){return 100;}";

    let spaces = "int   main    (  )  {   return  100 ; }";

    assert_eq!(expected, parser(multi_digit));
    assert_eq!(expected, parser(newlines));
    assert_eq!(expected, parser(no_newlines));
    assert_eq!(expected, parser(spaces));
}

#[should_panic]
#[test]
fn test_invalid_missing_paren() {
    let missing_paren = r#"int main( {
        return 0;
    }"#;
    parser(missing_paren);
}

#[should_panic]
#[test]
fn test_invalid_no_return_val() {
    let no_return_val = r#"int main() {
        return;
    }"#;
    parser(no_return_val);
}

#[should_panic]
#[test]
fn test_invalid_no_brace() {
    let no_brace = r#"int main() {
        return 0;
    "#;
    parser(no_brace);
}

#[should_panic]
#[test]
fn test_invalid_no_semicolon() {
    let no_semicolon = r#"int main() {
        return 0
    }"#;
    parser(no_semicolon);
}

#[should_panic]
#[test]
fn test_invalid_no_space() {
    let no_space = r#"int main() {
        return0;
    }"#;
    parser(no_space);
}

#[should_panic]
#[test]
fn test_invalid_wrong_case() {
    let wrong_case = r#"int main() {
        RETURN 0;
    }"#;
    parser(wrong_case);
}
