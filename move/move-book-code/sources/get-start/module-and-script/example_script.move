// run command:
//
// move sandbox run sources/module-and-script/example_script.move --args "your want input value"
script {
    use std::debug;
    use std::string;

    const ONE: u64 = 1;

    fun main(x: u64) {
        debug::print(&string::utf8(b"this is example script! start ---- "));
        debug::print(&move_book_code::test::plus_one(x));
        debug::print(&string::utf8(b"this is example script! end ----"));
    }
}