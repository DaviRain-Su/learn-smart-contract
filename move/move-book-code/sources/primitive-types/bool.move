module move_book_code::bool {
    public fun display_bool() {
        let a = true && true;
        assert!(a == true, 1);
        let a = false || true;
        assert!(a == true, 1);
        let a = !false;
        assert!(a == true, 1);
    }

    #[test]
    fun test_display_bool() {
        display_bool();
    }
}