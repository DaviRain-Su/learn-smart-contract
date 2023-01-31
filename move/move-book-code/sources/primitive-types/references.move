module move_book_code::references {
    struct S has drop {
        f: u64
    }

    struct A has drop { b: B }
    struct B has drop { c : u64 }


    fun f(a: &A): &u64 {
        &a.b.c
    }

    #[test]
    fun test_references() {
        let s = S { f: 10 };
        let _f_ref1: &u64 = &s.f; // works
        let s_ref: &S = &s;
        let _f_ref2: &u64 = &s_ref.f; // also works

        let a = A { b : B { c: 1 }};
        let r = f(&a);
        assert!(r == &1, 1);

        let x = 7;
        let _y: &u64 = &x;
        // let z: &&u64 = &y; // will not compile
    }
}