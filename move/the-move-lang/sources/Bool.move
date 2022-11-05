module the_move_lang::Bool {
    #[test]
    public entry fun test_bool_type() {
        let a = true;
        let b = false;
        let c = a && b;
        assert!(c == false, 0);

        let c = a || b;
        assert!(c == true, 0);

        let c = !c;
        assert!(c == false, 0);
    }
}