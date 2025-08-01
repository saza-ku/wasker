(module
  ;; Import our myprint function
  (import "myenv" "print" (func $print (param i64 i32)))

  ;; Define a single page memory of 64KB.
  (memory $0 1)

  ;; Store the Hello World (null terminated) string at byte offset 0
  (data (i32.const 0) "Test Passed\n")
  (data (i32.const 16) "# Test Failed\n")

  ;; Debug function
  (func $printd (param $len i32)
    i64.const 0
    (local.get $len)
    (call $print)
  )
  
  (func $printSuccess
    i64.const 0
    i32.const 12
    (call $print)
  )

  (func $printFail
    i64.const 16
    i32.const 14
    (call $print)
  )

  (func $assert_test_i64 (param $expected i64) (param $result i64)
    local.get $expected
    local.get $result
    i64.eq
    (if
      (then
        (call $printSuccess)
      )
      (else
        (call $printFail)
      )
    )
  )
  (func $assert_test_i32 (param $expected i32) (param $result i32)
    local.get $expected
    local.get $result
    i32.eq
    (if
      (then
        (call $printSuccess)
      )
      (else
        (call $printFail)
      )
    )
  )
  (func $add (param $x i64) (param $y i64) (result i64) (i64.add (local.get $x) (local.get $y)))
  (func $sub (param $x i64) (param $y i64) (result i64) (i64.sub (local.get $x) (local.get $y)))
  (func $mul (param $x i64) (param $y i64) (result i64) (i64.mul (local.get $x) (local.get $y)))
  (func $div_s (param $x i64) (param $y i64) (result i64) (i64.div_s (local.get $x) (local.get $y)))
  (func $div_u (param $x i64) (param $y i64) (result i64) (i64.div_u (local.get $x) (local.get $y)))
  (func $rem_s (param $x i64) (param $y i64) (result i64) (i64.rem_s (local.get $x) (local.get $y)))
  (func $rem_u (param $x i64) (param $y i64) (result i64) (i64.rem_u (local.get $x) (local.get $y)))
  (func $and (param $x i64) (param $y i64) (result i64) (i64.and (local.get $x) (local.get $y)))
  (func $or (param $x i64) (param $y i64) (result i64) (i64.or (local.get $x) (local.get $y)))
  (func $xor (param $x i64) (param $y i64) (result i64) (i64.xor (local.get $x) (local.get $y)))
  (func $shl (param $x i64) (param $y i64) (result i64) (i64.shl (local.get $x) (local.get $y)))
  (func $shr_s (param $x i64) (param $y i64) (result i64) (i64.shr_s (local.get $x) (local.get $y)))
  (func $shr_u (param $x i64) (param $y i64) (result i64) (i64.shr_u (local.get $x) (local.get $y)))
  (func $rotl (param $x i64) (param $y i64) (result i64) (i64.rotl (local.get $x) (local.get $y)))
  (func $rotr (param $x i64) (param $y i64) (result i64) (i64.rotr (local.get $x) (local.get $y)))
  (func $clz (param $x i64) (result i64) (i64.clz (local.get $x)))
  (func $ctz (param $x i64) (result i64) (i64.ctz (local.get $x)))
  (func $popcnt (param $x i64) (result i64) (i64.popcnt (local.get $x)))
  (func $extend8_s (param $x i64) (result i64) (i64.extend8_s (local.get $x)))
  (func $extend16_s (param $x i64) (result i64) (i64.extend16_s (local.get $x)))
  (func $extend32_s (param $x i64) (result i64) (i64.extend32_s (local.get $x)))
  (func $eqz (param $x i64) (result i32) (i64.eqz (local.get $x)))
  (func $eq (param $x i64) (param $y i64) (result i32) (i64.eq (local.get $x) (local.get $y)))
  (func $ne (param $x i64) (param $y i64) (result i32) (i64.ne (local.get $x) (local.get $y)))
  (func $lt_s (param $x i64) (param $y i64) (result i32) (i64.lt_s (local.get $x) (local.get $y)))
  (func $lt_u (param $x i64) (param $y i64) (result i32) (i64.lt_u (local.get $x) (local.get $y)))
  (func $le_s (param $x i64) (param $y i64) (result i32) (i64.le_s (local.get $x) (local.get $y)))
  (func $le_u (param $x i64) (param $y i64) (result i32) (i64.le_u (local.get $x) (local.get $y)))
  (func $gt_s (param $x i64) (param $y i64) (result i32) (i64.gt_s (local.get $x) (local.get $y)))
  (func $gt_u (param $x i64) (param $y i64) (result i32) (i64.gt_u (local.get $x) (local.get $y)))
  (func $ge_s (param $x i64) (param $y i64) (result i32) (i64.ge_s (local.get $x) (local.get $y)))
  (func $ge_u (param $x i64) (param $y i64) (result i32) (i64.ge_u (local.get $x) (local.get $y)))

  (func (export "_start")
    (call $assert_test_i64 (call $add (i64.const 1) (i64.const 1)) (i64.const 2))
    (call $assert_test_i64 (call $add (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $add (i64.const -1) (i64.const -1)) (i64.const -2))
    (call $assert_test_i64 (call $add (i64.const -1) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $add (i64.const 0x7fffffffffffffff) (i64.const 1)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $add (i64.const 0x8000000000000000) (i64.const -1)) (i64.const 0x7fffffffffffffff))
    (call $assert_test_i64 (call $add (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i64.const 0))
    (call $assert_test_i64 (call $add (i64.const 0x3fffffff) (i64.const 1)) (i64.const 0x40000000))
    
    (call $assert_test_i64 (call $sub (i64.const 1) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $sub (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $sub (i64.const -1) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $sub (i64.const 0x7fffffffffffffff) (i64.const -1)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $sub (i64.const 0x8000000000000000) (i64.const 1)) (i64.const 0x7fffffffffffffff))
    (call $assert_test_i64 (call $sub (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i64.const 0))
    (call $assert_test_i64 (call $sub (i64.const 0x3fffffff) (i64.const -1)) (i64.const 0x40000000))
    
    (call $assert_test_i64 (call $mul (i64.const 1) (i64.const 1)) (i64.const 1))
    (call $assert_test_i64 (call $mul (i64.const 1) (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $mul (i64.const -1) (i64.const -1)) (i64.const 1))
    (call $assert_test_i64 (call $mul (i64.const 0x1000000000000000) (i64.const 4096)) (i64.const 0))
    (call $assert_test_i64 (call $mul (i64.const 0x8000000000000000) (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $mul (i64.const 0x8000000000000000) (i64.const -1)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $mul (i64.const 0x7fffffffffffffff) (i64.const -1)) (i64.const 0x8000000000000001))
    (call $assert_test_i64 (call $mul (i64.const 0x0123456789abcdef) (i64.const 0xfedcba9876543210)) (i64.const 0x2236d88fe5618cf0))
    (call $assert_test_i64 (call $mul (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i64.const 1))
    
    (call $assert_test_i64 (call $div_s (i64.const 1) (i64.const 1)) (i64.const 1))
    (call $assert_test_i64 (call $div_s (i64.const 0) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $div_s (i64.const 0) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $div_s (i64.const -1) (i64.const -1)) (i64.const 1))
    (call $assert_test_i64 (call $div_s (i64.const 0x8000000000000000) (i64.const 2)) (i64.const 0xc000000000000000))
    (call $assert_test_i64 (call $div_s (i64.const 0x8000000000000001) (i64.const 1000)) (i64.const 0xffdf3b645a1cac09))
    (call $assert_test_i64 (call $div_s (i64.const 5) (i64.const 2)) (i64.const 2))
    (call $assert_test_i64 (call $div_s (i64.const -5) (i64.const 2)) (i64.const -2))
    (call $assert_test_i64 (call $div_s (i64.const 5) (i64.const -2)) (i64.const -2))
    (call $assert_test_i64 (call $div_s (i64.const -5) (i64.const -2)) (i64.const 2))
    (call $assert_test_i64 (call $div_s (i64.const 7) (i64.const 3)) (i64.const 2))
    (call $assert_test_i64 (call $div_s (i64.const -7) (i64.const 3)) (i64.const -2))
    (call $assert_test_i64 (call $div_s (i64.const 7) (i64.const -3)) (i64.const -2))
    (call $assert_test_i64 (call $div_s (i64.const -7) (i64.const -3)) (i64.const 2))
    (call $assert_test_i64 (call $div_s (i64.const 11) (i64.const 5)) (i64.const 2))
    (call $assert_test_i64 (call $div_s (i64.const 17) (i64.const 7)) (i64.const 2))
    
    (call $assert_test_i64 (call $div_u (i64.const 1) (i64.const 1)) (i64.const 1))
    (call $assert_test_i64 (call $div_u (i64.const 0) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $div_u (i64.const -1) (i64.const -1)) (i64.const 1))
    (call $assert_test_i64 (call $div_u (i64.const 0x8000000000000000) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $div_u (i64.const 0x8000000000000000) (i64.const 2)) (i64.const 0x4000000000000000))
    (call $assert_test_i64 (call $div_u (i64.const 0x8ff00ff00ff00ff0) (i64.const 0x100000001)) (i64.const 0x8ff00fef))
    (call $assert_test_i64 (call $div_u (i64.const 0x8000000000000001) (i64.const 1000)) (i64.const 0x20c49ba5e353f7))
    (call $assert_test_i64 (call $div_u (i64.const 5) (i64.const 2)) (i64.const 2))
    (call $assert_test_i64 (call $div_u (i64.const -5) (i64.const 2)) (i64.const 0x7ffffffffffffffd))
    (call $assert_test_i64 (call $div_u (i64.const 5) (i64.const -2)) (i64.const 0))
    (call $assert_test_i64 (call $div_u (i64.const -5) (i64.const -2)) (i64.const 0))
    (call $assert_test_i64 (call $div_u (i64.const 7) (i64.const 3)) (i64.const 2))
    (call $assert_test_i64 (call $div_u (i64.const 11) (i64.const 5)) (i64.const 2))
    (call $assert_test_i64 (call $div_u (i64.const 17) (i64.const 7)) (i64.const 2))
    
    (call $assert_test_i64 (call $rem_s (i64.const 0x7fffffffffffffff) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_s (i64.const 1) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_s (i64.const 0) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_s (i64.const 0) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_s (i64.const -1) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_s (i64.const 0x8000000000000000) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_s (i64.const 0x8000000000000000) (i64.const 2)) (i64.const 0))
    (call $assert_test_i64 (call $rem_s (i64.const 0x8000000000000001) (i64.const 1000)) (i64.const -807))
    (call $assert_test_i64 (call $rem_s (i64.const 5) (i64.const 2)) (i64.const 1))
    (call $assert_test_i64 (call $rem_s (i64.const -5) (i64.const 2)) (i64.const -1))
    (call $assert_test_i64 (call $rem_s (i64.const 5) (i64.const -2)) (i64.const 1))
    (call $assert_test_i64 (call $rem_s (i64.const -5) (i64.const -2)) (i64.const -1))
    (call $assert_test_i64 (call $rem_s (i64.const 7) (i64.const 3)) (i64.const 1))
    (call $assert_test_i64 (call $rem_s (i64.const -7) (i64.const 3)) (i64.const -1))
    (call $assert_test_i64 (call $rem_s (i64.const 7) (i64.const -3)) (i64.const 1))
    (call $assert_test_i64 (call $rem_s (i64.const -7) (i64.const -3)) (i64.const -1))
    (call $assert_test_i64 (call $rem_s (i64.const 11) (i64.const 5)) (i64.const 1))
    (call $assert_test_i64 (call $rem_s (i64.const 17) (i64.const 7)) (i64.const 3))
    
    (call $assert_test_i64 (call $rem_u (i64.const 1) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_u (i64.const 0) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_u (i64.const -1) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $rem_u (i64.const 0x8000000000000000) (i64.const -1)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $rem_u (i64.const 0x8000000000000000) (i64.const 2)) (i64.const 0))
    (call $assert_test_i64 (call $rem_u (i64.const 0x8ff00ff00ff00ff0) (i64.const 0x100000001)) (i64.const 0x80000001))
    (call $assert_test_i64 (call $rem_u (i64.const 0x8000000000000001) (i64.const 1000)) (i64.const 809))
    (call $assert_test_i64 (call $rem_u (i64.const 5) (i64.const 2)) (i64.const 1))
    (call $assert_test_i64 (call $rem_u (i64.const -5) (i64.const 2)) (i64.const 1))
    (call $assert_test_i64 (call $rem_u (i64.const 5) (i64.const -2)) (i64.const 5))
    (call $assert_test_i64 (call $rem_u (i64.const -5) (i64.const -2)) (i64.const -5))
    (call $assert_test_i64 (call $rem_u (i64.const 7) (i64.const 3)) (i64.const 1))
    (call $assert_test_i64 (call $rem_u (i64.const 11) (i64.const 5)) (i64.const 1))
    (call $assert_test_i64 (call $rem_u (i64.const 17) (i64.const 7)) (i64.const 3))
    
    (call $assert_test_i64 (call $and (i64.const 1) (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $and (i64.const 0) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $and (i64.const 1) (i64.const 1)) (i64.const 1))
    (call $assert_test_i64 (call $and (i64.const 0) (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $and (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i64.const 0))
    (call $assert_test_i64 (call $and (i64.const 0x7fffffffffffffff) (i64.const -1)) (i64.const 0x7fffffffffffffff))
    (call $assert_test_i64 (call $and (i64.const 0xf0f0ffff) (i64.const 0xfffff0f0)) (i64.const 0xf0f0f0f0))
    (call $assert_test_i64 (call $and (i64.const 0xffffffffffffffff) (i64.const 0xffffffffffffffff)) (i64.const 0xffffffffffffffff))
    
    (call $assert_test_i64 (call $or (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $or (i64.const 0) (i64.const 1)) (i64.const 1))
    (call $assert_test_i64 (call $or (i64.const 1) (i64.const 1)) (i64.const 1))
    (call $assert_test_i64 (call $or (i64.const 0) (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $or (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i64.const -1))
    (call $assert_test_i64 (call $or (i64.const 0x8000000000000000) (i64.const 0)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $or (i64.const 0xf0f0ffff) (i64.const 0xfffff0f0)) (i64.const 0xffffffff))
    (call $assert_test_i64 (call $or (i64.const 0xffffffffffffffff) (i64.const 0xffffffffffffffff)) (i64.const 0xffffffffffffffff))
    
    (call $assert_test_i64 (call $xor (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $xor (i64.const 0) (i64.const 1)) (i64.const 1))
    (call $assert_test_i64 (call $xor (i64.const 1) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $xor (i64.const 0) (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $xor (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i64.const -1))
    (call $assert_test_i64 (call $xor (i64.const 0x8000000000000000) (i64.const 0)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $xor (i64.const -1) (i64.const 0x8000000000000000)) (i64.const 0x7fffffffffffffff))
    (call $assert_test_i64 (call $xor (i64.const -1) (i64.const 0x7fffffffffffffff)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $xor (i64.const 0xf0f0ffff) (i64.const 0xfffff0f0)) (i64.const 0x0f0f0f0f))
    (call $assert_test_i64 (call $xor (i64.const 0xffffffffffffffff) (i64.const 0xffffffffffffffff)) (i64.const 0))
    
    (call $assert_test_i64 (call $shl (i64.const 1) (i64.const 1)) (i64.const 2))
    (call $assert_test_i64 (call $shl (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $shl (i64.const 0x7fffffffffffffff) (i64.const 1)) (i64.const 0xfffffffffffffffe))
    (call $assert_test_i64 (call $shl (i64.const 0xffffffffffffffff) (i64.const 1)) (i64.const 0xfffffffffffffffe))
    (call $assert_test_i64 (call $shl (i64.const 0x8000000000000000) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $shl (i64.const 0x4000000000000000) (i64.const 1)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $shl (i64.const 1) (i64.const 63)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $shl (i64.const 1) (i64.const 64)) (i64.const 1))
    (call $assert_test_i64 (call $shl (i64.const 1) (i64.const 65)) (i64.const 2))
    (call $assert_test_i64 (call $shl (i64.const 1) (i64.const -1)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $shl (i64.const 1) (i64.const 0x7fffffffffffffff)) (i64.const 0x8000000000000000))
    
    (call $assert_test_i64 (call $shr_s (i64.const 1) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $shr_s (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $shr_s (i64.const -1) (i64.const 1)) (i64.const -1))
    (call $assert_test_i64 (call $shr_s (i64.const 0x7fffffffffffffff) (i64.const 1)) (i64.const 0x3fffffffffffffff))
    (call $assert_test_i64 (call $shr_s (i64.const 0x8000000000000000) (i64.const 1)) (i64.const 0xc000000000000000))
    (call $assert_test_i64 (call $shr_s (i64.const 0x4000000000000000) (i64.const 1)) (i64.const 0x2000000000000000))
    (call $assert_test_i64 (call $shr_s (i64.const 1) (i64.const 64)) (i64.const 1))
    (call $assert_test_i64 (call $shr_s (i64.const 1) (i64.const 65)) (i64.const 0))
    (call $assert_test_i64 (call $shr_s (i64.const 1) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $shr_s (i64.const 1) (i64.const 0x7fffffffffffffff)) (i64.const 0))
    (call $assert_test_i64 (call $shr_s (i64.const 1) (i64.const 0x8000000000000000)) (i64.const 1))
    (call $assert_test_i64 (call $shr_s (i64.const 0x8000000000000000) (i64.const 63)) (i64.const -1))
    (call $assert_test_i64 (call $shr_s (i64.const -1) (i64.const 64)) (i64.const -1))
    (call $assert_test_i64 (call $shr_s (i64.const -1) (i64.const 65)) (i64.const -1))
    (call $assert_test_i64 (call $shr_s (i64.const -1) (i64.const -1)) (i64.const -1))
    (call $assert_test_i64 (call $shr_s (i64.const -1) (i64.const 0x7fffffffffffffff)) (i64.const -1))
    (call $assert_test_i64 (call $shr_s (i64.const -1) (i64.const 0x8000000000000000)) (i64.const -1))
    
    (call $assert_test_i64 (call $shr_u (i64.const 1) (i64.const 1)) (i64.const 0))
    (call $assert_test_i64 (call $shr_u (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $shr_u (i64.const -1) (i64.const 1)) (i64.const 0x7fffffffffffffff))
    (call $assert_test_i64 (call $shr_u (i64.const 0x7fffffffffffffff) (i64.const 1)) (i64.const 0x3fffffffffffffff))
    (call $assert_test_i64 (call $shr_u (i64.const 0x8000000000000000) (i64.const 1)) (i64.const 0x4000000000000000))
    (call $assert_test_i64 (call $shr_u (i64.const 0x4000000000000000) (i64.const 1)) (i64.const 0x2000000000000000))
    (call $assert_test_i64 (call $shr_u (i64.const 1) (i64.const 64)) (i64.const 1))
    (call $assert_test_i64 (call $shr_u (i64.const 1) (i64.const 65)) (i64.const 0))
    (call $assert_test_i64 (call $shr_u (i64.const 1) (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $shr_u (i64.const 1) (i64.const 0x7fffffffffffffff)) (i64.const 0))
    (call $assert_test_i64 (call $shr_u (i64.const 1) (i64.const 0x8000000000000000)) (i64.const 1))
    (call $assert_test_i64 (call $shr_u (i64.const 0x8000000000000000) (i64.const 63)) (i64.const 1))
    (call $assert_test_i64 (call $shr_u (i64.const -1) (i64.const 64)) (i64.const -1))
    (call $assert_test_i64 (call $shr_u (i64.const -1) (i64.const 65)) (i64.const 0x7fffffffffffffff))
    (call $assert_test_i64 (call $shr_u (i64.const -1) (i64.const -1)) (i64.const 1))
    (call $assert_test_i64 (call $shr_u (i64.const -1) (i64.const 0x7fffffffffffffff)) (i64.const 1))
    (call $assert_test_i64 (call $shr_u (i64.const -1) (i64.const 0x8000000000000000)) (i64.const -1))
    
    (call $assert_test_i64 (call $rotl (i64.const 1) (i64.const 1)) (i64.const 2))
    (call $assert_test_i64 (call $rotl (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $rotl (i64.const -1) (i64.const 1)) (i64.const -1))
    (call $assert_test_i64 (call $rotl (i64.const 1) (i64.const 64)) (i64.const 1))
    (call $assert_test_i64 (call $rotl (i64.const 0xabcd987602468ace) (i64.const 1)) (i64.const 0x579b30ec048d159d))
    (call $assert_test_i64 (call $rotl (i64.const 0xfe000000dc000000) (i64.const 4)) (i64.const 0xe000000dc000000f))
    (call $assert_test_i64 (call $rotl (i64.const 0xabcd1234ef567809) (i64.const 53)) (i64.const 0x013579a2469deacf))
    (call $assert_test_i64 (call $rotl (i64.const 0xabd1234ef567809c) (i64.const 63)) (i64.const 0x55e891a77ab3c04e))
    (call $assert_test_i64 (call $rotl (i64.const 0xabcd1234ef567809) (i64.const 0xf5)) (i64.const 0x013579a2469deacf))
    (call $assert_test_i64 (call $rotl (i64.const 0xabcd7294ef567809) (i64.const 0xffffffffffffffed)) (i64.const 0xcf013579ae529dea))
    (call $assert_test_i64 (call $rotl (i64.const 0xabd1234ef567809c) (i64.const 0x800000000000003f)) (i64.const 0x55e891a77ab3c04e))
    (call $assert_test_i64 (call $rotl (i64.const 1) (i64.const 63)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $rotl (i64.const 0x8000000000000000) (i64.const 1)) (i64.const 1))
    
    (call $assert_test_i64 (call $rotr (i64.const 1) (i64.const 1)) (i64.const 0x8000000000000000))
    (call $assert_test_i64 (call $rotr (i64.const 1) (i64.const 0)) (i64.const 1))
    (call $assert_test_i64 (call $rotr (i64.const -1) (i64.const 1)) (i64.const -1))
    (call $assert_test_i64 (call $rotr (i64.const 1) (i64.const 64)) (i64.const 1))
    (call $assert_test_i64 (call $rotr (i64.const 0xabcd987602468ace) (i64.const 1)) (i64.const 0x55e6cc3b01234567))
    (call $assert_test_i64 (call $rotr (i64.const 0xfe000000dc000000) (i64.const 4)) (i64.const 0x0fe000000dc00000))
    (call $assert_test_i64 (call $rotr (i64.const 0xabcd1234ef567809) (i64.const 53)) (i64.const 0x6891a77ab3c04d5e))
    (call $assert_test_i64 (call $rotr (i64.const 0xabd1234ef567809c) (i64.const 63)) (i64.const 0x57a2469deacf0139))
    (call $assert_test_i64 (call $rotr (i64.const 0xabcd1234ef567809) (i64.const 0xf5)) (i64.const 0x6891a77ab3c04d5e))
    (call $assert_test_i64 (call $rotr (i64.const 0xabcd7294ef567809) (i64.const 0xffffffffffffffed)) (i64.const 0x94a77ab3c04d5e6b))
    (call $assert_test_i64 (call $rotr (i64.const 0xabd1234ef567809c) (i64.const 0x800000000000003f)) (i64.const 0x57a2469deacf0139))
    (call $assert_test_i64 (call $rotr (i64.const 1) (i64.const 63)) (i64.const 2))
    (call $assert_test_i64 (call $rotr (i64.const 0x8000000000000000) (i64.const 63)) (i64.const 1))

    (call $assert_test_i64 (call $clz (i64.const 0xffffffffffffffff)) (i64.const 0))
    (call $assert_test_i64 (call $clz (i64.const 0)) (i64.const 64))
    (call $assert_test_i64 (call $clz (i64.const 0x00008000)) (i64.const 48))
    (call $assert_test_i64 (call $clz (i64.const 0xff)) (i64.const 56))
    (call $assert_test_i64 (call $clz (i64.const 0x8000000000000000)) (i64.const 0))
    (call $assert_test_i64 (call $clz (i64.const 1)) (i64.const 63))
    (call $assert_test_i64 (call $clz (i64.const 2)) (i64.const 62))
    (call $assert_test_i64 (call $clz (i64.const 0x7fffffffffffffff)) (i64.const 1))

    (call $assert_test_i64 (call $ctz (i64.const -1)) (i64.const 0))
    (call $assert_test_i64 (call $ctz (i64.const 0)) (i64.const 64))
    (call $assert_test_i64 (call $ctz (i64.const 0x00008000)) (i64.const 15))
    (call $assert_test_i64 (call $ctz (i64.const 0x00010000)) (i64.const 16))
    (call $assert_test_i64 (call $ctz (i64.const 0x8000000000000000)) (i64.const 63))
    (call $assert_test_i64 (call $ctz (i64.const 0x7fffffffffffffff)) (i64.const 0)) 
    
    (call $assert_test_i64 (call $popcnt (i64.const -1)) (i64.const 64))
    (call $assert_test_i64 (call $popcnt (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $popcnt (i64.const 0x00008000)) (i64.const 1))
    (call $assert_test_i64 (call $popcnt (i64.const 0x8000800080008000)) (i64.const 4))
    (call $assert_test_i64 (call $popcnt (i64.const 0x7fffffffffffffff)) (i64.const 63))
    (call $assert_test_i64 (call $popcnt (i64.const 0xAAAAAAAA55555555)) (i64.const 32))
    (call $assert_test_i64 (call $popcnt (i64.const 0x99999999AAAAAAAA)) (i64.const 32))
    (call $assert_test_i64 (call $popcnt (i64.const 0xDEADBEEFDEADBEEF)) (i64.const 48))

    (call $assert_test_i64 (call $extend8_s (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $extend8_s (i64.const 0x7f)) (i64.const 127))
    (call $assert_test_i64 (call $extend8_s (i64.const 0xff)) (i64.const -1))
    (call $assert_test_i64 (call $extend8_s (i64.const 0x01234567_89abcd_00)) (i64.const 0))
    (call $assert_test_i64 (call $extend8_s (i64.const 0xfedcba98_765432_80)) (i64.const -0x80))
    (call $assert_test_i64 (call $extend8_s (i64.const -1)) (i64.const -1))
    (call $assert_test_i64 (call $extend8_s (i64.const 0x80)) (i64.const -128))

    (call $assert_test_i64 (call $extend16_s (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $extend16_s (i64.const 0x7fff)) (i64.const 32767))
    (call $assert_test_i64 (call $extend16_s (i64.const 0x8000)) (i64.const -32768))
    (call $assert_test_i64 (call $extend16_s (i64.const 0xffff)) (i64.const -1))
    (call $assert_test_i64 (call $extend16_s (i64.const 0x12345678_9abc_0000)) (i64.const 0))
    (call $assert_test_i64 (call $extend16_s (i64.const 0xfedcba98_7654_8000)) (i64.const -0x8000))
    (call $assert_test_i64 (call $extend16_s (i64.const -1)) (i64.const -1))

    (call $assert_test_i64 (call $extend32_s (i64.const 0)) (i64.const 0))
    (call $assert_test_i64 (call $extend32_s (i64.const 0x7fff)) (i64.const 32767))
    (call $assert_test_i64 (call $extend32_s (i64.const 0x8000)) (i64.const 32768))
    (call $assert_test_i64 (call $extend32_s (i64.const 0xffff)) (i64.const 65535))
    (call $assert_test_i64 (call $extend32_s (i64.const 0x7fffffff)) (i64.const 0x7fffffff))
    (call $assert_test_i64 (call $extend32_s (i64.const 0x80000000)) (i64.const -0x80000000))
    (call $assert_test_i64 (call $extend32_s (i64.const 0xffffffff)) (i64.const -1))
    (call $assert_test_i64 (call $extend32_s (i64.const 0x01234567_00000000)) (i64.const 0))
    (call $assert_test_i64 (call $extend32_s (i64.const 0xfedcba98_80000000)) (i64.const -0x80000000))
    (call $assert_test_i64 (call $extend32_s (i64.const -1)) (i64.const -1))

    (call $assert_test_i32 (call $eqz (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $eqz (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $eqz (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $eqz (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $eqz (i64.const 0xffffffffffffffff)) (i32.const 0))

    (call $assert_test_i32 (call $eq (i64.const 0) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $eq (i64.const 1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $eq (i64.const -1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $eq (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $eq (i64.const -1) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $eq (i64.const 1) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const 0) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $eq (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 0))

    (call $assert_test_i32 (call $ne (i64.const 0) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $ne (i64.const 1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $ne (i64.const -1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $ne (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $ne (i64.const -1) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $ne (i64.const 1) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const 0) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $ne (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 1))

    (call $assert_test_i32 (call $lt_s (i64.const 0) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const 1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const -1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $lt_s (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const -1) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const 1) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const 0) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $lt_s (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $lt_s (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $lt_s (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $lt_s (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $lt_s (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 0))

    (call $assert_test_i32 (call $lt_u (i64.const 0) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const -1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const -1) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 1) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 0) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $lt_u (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $lt_u (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $lt_u (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $lt_u (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 1))

    (call $assert_test_i32 (call $le_s (i64.const 0) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const 1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const -1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const -1) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const 1) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $le_s (i64.const 0) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $le_s (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $le_s (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $le_s (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 0))

    (call $assert_test_i32 (call $le_u (i64.const 0) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const 1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const -1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $le_u (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const -1) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const 1) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $le_u (i64.const 0) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $le_u (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $le_u (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $le_u (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $le_u (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 1))

    (call $assert_test_i32 (call $gt_s (i64.const 0) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const 1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const -1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const -1) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const 1) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $gt_s (i64.const 0) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $gt_s (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $gt_s (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $gt_s (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 1))

    (call $assert_test_i32 (call $gt_u (i64.const 0) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const 1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const -1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $gt_u (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const -1) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const 1) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $gt_u (i64.const 0) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $gt_u (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $gt_u (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $gt_u (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $gt_u (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 0))

    (call $assert_test_i32 (call $ge_s (i64.const 0) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const 1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const -1) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $ge_s (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const -1) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const 1) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const 0) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $ge_s (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 0))
    (call $assert_test_i32 (call $ge_s (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $ge_s (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $ge_s (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 0))
    (call $assert_test_i32 (call $ge_s (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 1))

    (call $assert_test_i32 (call $ge_u (i64.const 0) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const -1) (i64.const 1)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 0x8000000000000000) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 0x7fffffffffffffff) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const -1) (i64.const -1)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 1) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 0) (i64.const 1)) (i32.const 0))
    (call $assert_test_i32 (call $ge_u (i64.const 0x8000000000000000) (i64.const 0)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 0) (i64.const 0x8000000000000000)) (i32.const 0))
    (call $assert_test_i32 (call $ge_u (i64.const 0x8000000000000000) (i64.const -1)) (i32.const 0))
    (call $assert_test_i32 (call $ge_u (i64.const -1) (i64.const 0x8000000000000000)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 0x8000000000000000) (i64.const 0x7fffffffffffffff)) (i32.const 1))
    (call $assert_test_i32 (call $ge_u (i64.const 0x7fffffffffffffff) (i64.const 0x8000000000000000)) (i32.const 0))
  )

)