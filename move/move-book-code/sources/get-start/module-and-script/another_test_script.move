script {
    use std::debug;

    fun main() {
        let example = move_book_code::another_test::print();
        debug::print(&example);
    }
}