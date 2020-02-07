// NOTE: the instructions don't clean up after execution
//       therefore, it is the responsibility of the executing instruction
//       to clean up before using any memory locations.

pub fn mov(location: i64, value: i64, current_pointer: i64) -> String {
    // Go to desired location, clean up, perform the move, go back to initial location
    format!(
        "{}{}{}{}",
        mov_pointer(location, current_pointer),
        flush_current(),
        put(value),
        reset_pointer(location, current_pointer)
    )
}

pub fn flush(location: i64, current_pointer: i64) -> String {
    format!(
        "{}{}{}",
        mov_pointer(location, current_pointer),
        flush_current(),
        reset_pointer(location, current_pointer)
    )
}

// cleans
fn flush_current() -> String {
    "[-]".to_string()
}

fn mov_pointer(location: i64, current_pointer: i64) -> String {
    let offset: i64 = current_pointer - location;

    if offset > 0 {
        decrement_stack(offset as u64)
    } else {
        increment_stack(offset.abs() as u64)
    }
}

fn reset_pointer(location: i64, current_pointer: i64) -> String {
    let offset = current_pointer - location;

    if offset > 0 {
        increment_stack(offset as u64)
    } else {
        decrement_stack(offset.abs() as u64)
    }
}

fn decrement_stack(times: u64) -> String {
    repeat("<", times)
}

fn increment_stack(times: u64) -> String {
    repeat(">", times)
}

pub fn put(value: i64) -> String {
    if value > 0 {
        add(value as u64)
    } else {
        sub(value.abs() as u64)
    }
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

// Initialize 32 64-bit registers at the beginning of the memory stack
pub fn initialize_registers() -> String {
    increment_stack(32)
}
