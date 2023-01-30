module move_book_code::another_test {
    struct Example has copy, drop { a: address }
    use std::debug;
    
    public fun print() {
        let example = Example { a: @move_book_code };
        debug::print(&example)
    }
}