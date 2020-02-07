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
fn test_flush() {
    assert_eq!("<<[-]>>", flush(0, 2));
}

#[test]
fn test_move() {
    // move postive from left to right
    assert_eq!("<<[-]++++>>", mov(0, 4, 2));

    // move positive from right to left
    assert_eq!(">>[-]++++<<", mov(2, 4, 0));

    // moving negative
    assert_eq!("<<[-]---->>", mov(0, -4, 2));
}
