use crate::brainfuck::*;

struct Instruction {
    bf: String,
    stack_pointer: u64,
}

pub fn transpile() -> String {
    todo!()
}

fn setup() -> Instruction {
    Instruction {
        bf: instructions::initialize_registers(),
        stack_pointer: 32,
    }
}

pub fn transpile_functions() {
    todo!()
}
