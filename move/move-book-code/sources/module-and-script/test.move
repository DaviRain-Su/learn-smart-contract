module move_book_code::test {
    struct Example has copy, drop { i: u64 }
    use std::debug;
    friend move_book_code::another_test;

    const ONE: u64 = 1;

    public fun test_print(x: u64) {
        let sum = x + ONE;
        let example = Example { i: sum };
        debug::print<Example>(&example);
        debug::print(&sum)
    }
}