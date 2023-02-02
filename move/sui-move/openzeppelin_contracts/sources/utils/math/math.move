// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (utils/math/Math.sol)

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
module openzeppelin_contracts::math {
    const ROUNDIND_DOWN: u64 = 0;
    const ROUNDIND_UP: u64 = 1;
    const ROUNDIND_ZERO: u64 = 2;

    /**
     * @dev Returns the largest of two numbers.
     */
    public fun max(a: u256, b: u256): u256{
        if (a > b) { a } else { b }
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    public fun min(a: u256, b: u256): u256 {
        if (a < b) { a } else { b }
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    public fun average(a: u256, b: u256): u256 {
        // (a + b) / 2 can overflow.
        (a & b) + (a ^ b) / 2
    }

    /// Return the value of a base raised to a power
    public fun pow_u256(base: u256, exponent: u8): u256 {
        let res = 1;
        while (exponent >= 1) {
            if (exponent % 2 == 0) {
                base = base * base;
                exponent = exponent / 2;
            } else {
                res = res * base;
                exponent = exponent - 1;
            }
        };

        res
    }

    /// Return the value of a base raised to a power
    public fun pow_u64(base: u64, exponent: u8): u64 {
        let res = 1;
        while (exponent >= 1) {
            if (exponent % 2 == 0) {
                base = base * base;
                exponent = exponent / 2;
            } else {
                res = res * base;
                exponent = exponent - 1;
            }
        };

        res
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds up instead
     * of rounding down.
     */
    public fun ceil_div(a: u256, b: u256) : u256 {
        // (a + b - 1) / b can overflow on addition, so we distribute.
        if (a == 0) { 0  } else { (a - 1) / b + 1 }
    }

    /**
     * @dev Returns the square root of a number. If the number is not a perfect square, the value is rounded down.
     *
     * Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
     */
    public fun sqrt(a: u256) : u256 {
        if (a == 0) {
            return 0
        };

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        //
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`. This value can be written `msb(a)=2**k` with `k=log2(a)`.
        //
        // This can be rewritten `2**log2(a) <= a < 2**(log2(a) + 1)`
        // -> `sqrt(2**k) <= sqrt(a) < sqrt(2**(k+1))`
        // ->  `2**(k/2) <= sqrt(a) < 2**((k+1)/2) <= 2**(k/2 + 1)`
        //
        // Consequently, `2**(log2(a) / 2)` is a good first approximation of `sqrt(a)` with at least 1 correct bit.
        let result = 1 << ((log2(a) >> 1) as u8);

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        result = (result + a / result) >> 1;
        result = (result + a / result) >> 1;
        result = (result + a / result) >> 1;
        result = (result + a / result) >> 1;
        result = (result + a / result) >> 1;
        result = (result + a / result) >> 1;
        result = (result + a / result) >> 1;
        
        min(result, a / result)
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    public fun sqrt_with_rounding(a: u256, rounding: u64) : u256 {
        let result = sqrt(a);
        result + if (rounding == ROUNDIND_UP && result * result < a) { 1 } else { 0 }
    }

    /**
     * @dev Return the log in base 2, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    public fun log2(value: u256) : u256 {
        let result = 0;

        if (value >> 128 > 0) {
            value = value >> 128;
            result = result + 128;
        };

        if (value >> 64 > 0) {
            value = value >> 64;
            result = result + 64;
        };

        if (value >> 32 > 0) {
            value = value >> 32;
            result = result +  32;
        };

        if (value >> 16 > 0) {
            value =  value >>16;
            result = result + 16;
        };

        if (value >> 8 > 0) {
            value = value >> 8;
            result = result +  8;
        };

        if (value >> 4 > 0) {
            value = value >> 4;
            result = result + 4;
        };

        if (value >> 2 > 0) {
            value = value >> 2;
            result = result +  2;
        };

        if (value >> 1 > 0) {
            result = result + 1;
        };

        result
    }

    /**
     * @dev Return the log in base 2, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    public fun log2_with_rounding(value: u256, rounding: u64): u256 {
        let result = log2(value);
        result + if (rounding == ROUNDIND_UP && 1 << (result as u8) < value) { 1 } else { 0 }
    }

    /**
     * @dev Return the log in base 10, rounded down, of a positive value.
     * Returns 0 if given 0.
     */
    public fun log10(value: u256): u256 {
        let result = 0;
        if (value >= pow_u256(10, 64)) {
            value = value / pow_u256(10, 64);
            result = result +  64;
        };

        if (value >= pow_u256(10, 32)) {
            value = value / pow_u256(10, 32);
            result = result + 32;
        };

        if (value >= pow_u256(10, 16)) {
            value = value / pow_u256(10, 16);
            result = result + 16;
        };

        if (value >= pow_u256(10, 8)) {
            value = value / pow_u256(10, 8);
            result = result + 8;
        };

        if (value >= pow_u256(10, 4)) {
            value = value / pow_u256(10, 4);
            result = result + 4;
        };

        if (value >= pow_u256(10, 2)) {
            value = value / pow_u256(10, 2);
            result = result + 2;
        };

        if (value >= pow_u256(10, 1)) {
            result = result +  1;
        };

        result
    }

    /**
     * @dev Return the log in base 10, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    public fun log10_with_round(value: u256, rounding: u64): u256 {
        let result = log10(value);
        result + if (rounding == ROUNDIND_UP && pow_u256(10, (result as u8)) < value) { 1 } else { 0 }
    }

    /**
     * @dev Return the log in base 256, rounded down, of a positive value.
     * Returns 0 if given 0.
     *
     * Adding one to the result gives the number of pairs of hex symbols needed to represent `value` as a hex string.
     */
    public fun log256(value: u256) : u256 {
        let result = 0;
        
        if (value >> 128 > 0) {
            value = value >> 128;
            result = result + 16;
        };

        if (value >> 64 > 0) {
            value = value >> 64;
            result = result + 8;
        };

        if (value >> 32 > 0) {
            value = value >> 32;
            result = result + 4;
        };

        if (value >> 16 > 0) {
            value = value >> 16;
            result = result + 2;
        };

        if (value >> 8 > 0) {
            result = result + 1;
        };

        result
    }

    /**
     * @dev Return the log in base 256, following the selected rounding direction, of a positive value.
     * Returns 0 if given 0.
     */
    public fun log256_rounding_up(value: u256, rounding: u64): u256 {
        let result = log256(value);
        result + if (rounding == ROUNDIND_UP && 1 << ((result << 3) as u8) < value) { 1 } else { 0 }
    }
}

#[test_only]
module openzeppelin_contracts::test_math {
    use openzeppelin_contracts::math;

    #[test]
    fun test_log2() {
        let result = math::log2(8);
        assert!(result == 3, 0);
    }

    #[test]
    fun test_sqrt() {
        let result = math::sqrt(9);
        assert!(result == 3, 0);
    }

     #[test]
    fun test_log10() {
        let result = math::log10(100);
        assert!(result == 2, 0);
    }
}