use std::iter::repeat;

fn main() {
    let bytes = to_bytes("Hello, World!");
    let mut bf_instruction_stack = String::new();
    for byte in bytes {
        dbg!(byte);
        let new_instruction = byte_to_bf_print(byte);
        bf_instruction_stack = format!("{bf_instruction_stack}\n{new_instruction}");
    }

    print!("{bf_instruction_stack}");
}

fn to_bytes(payload: &str) -> Vec<u8> {
    payload.as_bytes().to_vec()
}

fn byte_to_bf_print(byte: u8) -> String {
    let add: String = repeat('+').take(byte as usize).collect();
    let sub: String = repeat('-').take(byte as usize).collect();
    format!("{add}.{sub}") // Add the print operator
}
