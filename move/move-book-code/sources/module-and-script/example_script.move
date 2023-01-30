// run command:
//
// move sandbox run sources/module-and-script/example_script.move --args "your want input value"
script {
    use std::debug;
    use std::string;
    
    const ONE: u64 = 1;

    fun main(x: u64) {
        let sum = x + ONE;
        debug::print(&string::utf8(b"this is example script! start ---- "));
        debug::print(&sum);
        debug::print(&string::utf8(b"this is example script! end ----"));
    }
}