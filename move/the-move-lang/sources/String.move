module the_move_lang::String {

    #[test]
    public entry fun test_string_type() {
        use std::string;
        use std::option;
        use std::debug;

        // create string by utf8
        let hello = string::utf8(b"hello world!");
        debug::print(&hello);
        assert!(string::bytes(&hello) == &b"hello world!", 0);

        // create string by try_utf8
        let hello = string::try_utf8(b"hello, world!");
        let hello = option::get_with_default(&hello, string::utf8(b""));
        debug::print(&hello);
        assert!(string::bytes(&hello) == &b"hello, world!", 0);

        // is_empty function
        let hello = string::utf8(b"hello world!");
        assert!(string::is_empty(&hello) == false, 0);

        // string length function
        assert!(string::length(&hello) == 12, 0);

        // string append function
        let world = string::utf8(b"world!");
        string::append(&mut hello, world);
        debug::print(&hello);
        assert!(hello == string::utf8(b"hello world!world!"), 0);

        // string append_utf8 function
        string::append_utf8(&mut hello, b"hello");
        assert!(hello == string::utf8(b"hello world!world!hello"), 0);

        // string insert function
        string::insert(&mut hello, 0, string::utf8(b"hello"));
        assert!(hello == string::utf8(b"hellohello world!world!hello"), 0);

        // string sub_string function
        let result = string::sub_string(&hello, 0, 5);
        assert!(result == string::utf8(b"hello"), 0);

        //string index_of function
        let index_result = string::index_of(&hello, &string::utf8(b"hello"));
        assert!(index_result == 0, 0);

    }
}