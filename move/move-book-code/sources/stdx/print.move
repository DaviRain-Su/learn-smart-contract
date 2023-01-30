module stdx::print {
    use std::debug;
    use std::string::String;

    public fun print_string(value: &String) {
        debug::print<String>(value)
    }
}