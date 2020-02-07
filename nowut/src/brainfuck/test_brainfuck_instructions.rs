use crate::brainfuck::instructions::*;

#[test]
fn test_add() {
    assert_eq!(add(5), "+++++");
}

#[test]
fn test_sub() {
    assert_eq!(sub(5), "-----");
}

#[test]
fn test_move() {
    assert_eq!("<<[-]++++", mov(0, 4, 2));
}
