// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.6.0) (utils/math/SafeMath.sol)

/**
* @dev Wrappers over Move's arithmetic operations.
*
* NOTE: `SafeMath` is generally not needed starting with Move, since the compiler
* now has built in overflow checking.
*/
module openzeppelin_contracts::safe_math {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    public fun try_add(a: u256, b: u256): (bool, u256) {
        let c = a + b;
        if (c < a) return (false, 0);
        (true, c)
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    public fun try_sub(a: u256, b: u256): (bool, u256) {
            if (b > a) return (false, 0);
            (true, a - b)
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    public fun try_mul(a: u256, b: u256): (bool, u256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        let c = a * b;
        if (c / a != b) return (false, 0);
        (true, c)
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    public fun try_div(a: u256, b: u256) : (bool, u256) {
        if (b == 0) return (false, 0);
        (true, a / b)
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    public fun try_mod(a: u256, b: u256): (bool, u256) {
            if (b == 0) return (false, 0);
            (true, a % b)
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Move's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    public fun add(a: u256, b: u256): u256 {
        a + b
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Move's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    public fun sub(a: u256, b: u256): u256 {
        a - b
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Move's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    public fun mul(a: u256, b: u256): u256 {
        a * b
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Move's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    public fun div(a: u256, b: u256): u256 {
        a / b
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Move's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Move uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    public fun mod(a: u256, b: u256) : u256 {
        a % b
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Move's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    public fun sub_with_error_message(a: u256, b: u256, error_message: u64): u256 {
        assert!(b <= a, error_message);
        a - b
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Move's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Move
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    public fun div_with_error_message(a: u256, b: u256, error_message: u64): u256 {
        assert!(b > 0, error_message);
        a / b
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Move's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Move uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    public fun mod_with_error_message(a: u256, b: u256, error_message: u64) : u256 {
            assert!(b > 0, error_message);
            a % b
    }
}


#[test_only]
module openzeppelin_contracts::test_safe_math {
    use openzeppelin_contracts::safe_math;

    #[test]
    fun test_try_add_successful() {
        let (bool_value, result) = safe_math::try_add(1, 2);
        assert!(bool_value == true && result == 3, 0); 
    }

    #[test]
    fun test_try_sub_successful() {
        let (bool_value, result) = safe_math::try_sub(2, 1);
        assert!(bool_value == true && result == 1, 0)
    }

    #[test]
    fun test_try_mul_successful() {
        let (bool_value, result) = safe_math::try_mul(1, 2);
        assert!(bool_value == true && result == 2, 0);
    }

    #[test]
    fun test_try_div_successful() {
        let (bool_value, result) = safe_math::try_div(2, 2);
        assert!(bool_value == true && result == 1, 0);
    }

    #[test]
    fun test_try_mod_successful() {
        let (bool_value, result) = safe_math::try_mod(2, 2);
        assert!(bool_value == true && result == 0, 0);
    }

    #[test]
    fun test_add() {
        assert!(safe_math::add(1,1) == 2, 0);
    }

    #[test]
    fun test_sub() {
        assert!(safe_math::sub(1,1) == 0, 0);
    }

    #[test]
    fun test_mul() {
        assert!(safe_math::mul(1,2) == 2, 0);
    }

    #[test]
    fun test_div() {
        assert!(safe_math::div(2,1) == 2, 0);
    }

    #[test]
    fun test_mod() {
        assert!(safe_math::mod(1,1) == 0, 0);
    }

    #[test]
    #[expected_failure]
    fun test_sub_with_error_message() {
        let _result = safe_math::sub_with_error_message(1, 2, 0);
    }

    #[test]
    #[expected_failure]
    fun test_div_with_error_message() {
        let _result = safe_math::div_with_error_message(1, 0, 0);
    }

    #[test]
    #[expected_failure]
    fun test_mod_with_error_message() {
        let _result = safe_math::mod_with_error_message(1, 0, 0);
    }
}