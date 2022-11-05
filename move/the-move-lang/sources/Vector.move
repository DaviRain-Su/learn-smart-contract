module the_move_lang::Vector {
    #[test_only]
    use std::vector;

    // error not empty vector
    const ERROR_NOT_EMPTY_VECTOR: u64 = 0;
    // error vector not equal
    const ERROR_VECTOR_NOT_EQUAL: u64 = 1;
    // error element not equal
    const ERROR_ELEMENT_NO_EQUAL: u64 = 2;

    struct MyStruct has drop {}

    #[test(account = @0x1)]
    public entry fun  test_vector_type() {
        // create a empty MyStruct
        let empty_mystruct = std::vector::empty<MyStruct>();
        assert!(std::vector::length(&empty_mystruct) == 0, 0);

        // create a Vector<u8>
        let vec_u8 = vector[1u8, 2, 3];
        // std::debug::print(&vec_u8);
        assert!(vec_u8 == vector[1, 2, 3], 0);

        // create a Vector<Vector<u8>>
        let vec_vec_u8 = vector[vec_u8, vec_u8];
        // std::debug::print(&vec_vec_u8);
        assert!(vec_vec_u8 == vector[vec_u8, vec_u8], 0);

        // create a Vector<address>
        let vec_address = vector[@0x1];
        assert!(vec_address == vector[@0x1], 0);

        // std::debug::print(&vec_address);
        let vec_vec_address = vector[vec_address];
        // std::debug::print(&vec_vec_address);
        assert!(vec_vec_address == vector[vec_address], 0);

        // create empty vector
        let empty_vec: vector<u8> = vector[];
        assert!(empty_vec == vector[], 0);

        let hello_vec = b"hello, world!";
        assert!(hello_vec == b"hello, world!", 0);

        assert!(b"" == x"", 0);
        assert!(b"Hello!\n" == x"48656C6C6F210A", 1);
        assert!(b"\x48\x65\x6C\x6C\x6F\x21\x0A" == x"48656C6C6F210A", 2);
        assert!(
            b"\"Hello\tworld!\"\n \r \\Null=\0" ==
            x"2248656C6C6F09776F726C6421220A200D205C4E756C6C3D00",
            3
        );

        // create a empty vector u8
        // empty function
        let empty_vec_u8 = vector::empty<u8>();
        // vector::lenght get the vector length
        assert!(vector::length(&empty_vec_u8) == 0, ERROR_NOT_EMPTY_VECTOR);

        // create a vector with single element u8
        let single_element_vec = vector::singleton(1u8);
        assert!(single_element_vec == vector[1], ERROR_VECTOR_NOT_EQUAL);

        // push a element to vector last element u8
        let empty_vec_u8 = vector::empty<u8>();
        vector::push_back(&mut empty_vec_u8, 0);
        vector::push_back(&mut empty_vec_u8, 1);
        vector::push_back(&mut empty_vec_u8, 2);
        assert!(empty_vec_u8 == vector[0, 1, 2], ERROR_VECTOR_NOT_EQUAL);

        // pop last element of vector u8
        vector::pop_back(&mut empty_vec_u8);
        assert!(empty_vec_u8 == vector[0, 1], ERROR_VECTOR_NOT_EQUAL);

        // borrow a element
        let elem = vector::borrow(&empty_vec_u8, 0);
        assert!(*elem == 0, ERROR_ELEMENT_NO_EQUAL);
        let elem = vector::borrow(&empty_vec_u8, 1);
        assert!(*elem == 1, ERROR_ELEMENT_NO_EQUAL);

        // borrow mut element
        let elem = vector::borrow_mut(&mut empty_vec_u8, 0);
        *elem = 2;
        assert!(empty_vec_u8 == vector[2, 1], ERROR_VECTOR_NOT_EQUAL);

        // destory element
        let empty_vec = vector::empty<u8>();
        assert!(vector::length(&empty_vec) == 0, ERROR_NOT_EMPTY_VECTOR);
        vector::destroy_empty(empty_vec);

        // vector append
        let vec1 = vector[1, 2, 3];
        let vec2 = vector[3, 2, 1];
        vector::append(&mut vec1, vec2);
        assert!(vec1 == vector[1, 2, 3, 3, 2, 1], ERROR_VECTOR_NOT_EQUAL);

        // vector swap
        let vec = vector[1, 2, 3];
        vector::swap(&mut vec, 0, 1);
        assert!(vec == vector[2, 1, 3], ERROR_VECTOR_NOT_EQUAL);

        // vector reverse
        let vec: vector<u8> = vector[1, 2, 3];
        vector::reverse(&mut vec);
        assert!(vec == vector[3, 2, 1], ERROR_VECTOR_NOT_EQUAL);

        // vector index_of
        let (value1, value2) = vector::index_of(&vec, &0);
        assert!(value1 == false, 0);
        assert!(value2 == 0, 0);
        let (value1, value2) = vector::index_of(&vec, &1);
        assert!(value1 == true, 0);
        assert!(value2 == 2, 0);

        // vector remove
        vector::remove(&mut vec, 0);
        assert!(vec == vector[2, 1], ERROR_VECTOR_NOT_EQUAL);

        // vector swap remove
        vector::swap_remove(&mut vec, 0);
        assert!(vec == vector[1],ERROR_VECTOR_NOT_EQUAL);
    }
}