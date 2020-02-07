pub fn mov(register: u64, value: u64, current_pointer: u64) -> String {
    // go to register
    let mov_pointer = decrement_stack(current_pointer - register);

    format!("{}[-]{}", mov_pointer, add(value))
}

pub fn decrement_stack(times: u64) -> String {
    repeat("<", times)
}

pub fn increment_stack(times: u64) -> String {
    repeat(">", times)
}

pub fn add(value: u64) -> String {
    repeat("+", value)
}

pub fn sub(value: u64) -> String {
    repeat("-", value)
}

fn repeat(character: &str, times: u64) -> String {
    (0..times).map(|_| character).collect::<String>()
}
