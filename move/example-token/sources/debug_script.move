script {
    use example_token::ExampleToken;
    fun test_script(account: signer) {
        ExampleToken::publish(&account)
    }
}