(module

  ;; Import our myprint function
  (import "myenv" "print" (func $print (param i64 i32)))

  ;; Define a single page memory of 64KB.
  (memory $0 1)

  ;; Store the Hello World (null terminated) string at byte offset 0
  (data (i32.const 100) "Test Passed\n")
  (data (i32.const 116) "#Test Failed\n")

  ;; Debug function
  (func $printd (param $len i32)
    i64.const 0
    (local.get $len)
    (call $print)
  )

  (func $printSuccess
    i64.const 100
    i32.const 12
    (call $print)
  )

  (func $printFail
    i64.const 116
    i32.const 13
    (call $print)
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

  (func $assert_test_f32 (param $expected f32) (param $result f32)
    local.get $expected
    local.get $result
    f32.eq
    (if
      (then
        (call $printSuccess)
      )
      (else
        (call $printFail)
      )
    )
  )

  (func $assert_test_f64 (param $expected f64) (param $result f64)
    local.get $expected
    local.get $result
    f64.eq
    (if
      (then
        (call $printSuccess)
      )
      (else
        (call $printFail)
      )
    )
  )

  (func $dummy)

  (func $type-i32-value (result i32)
    (block (result i32) (i32.ctz (br 0 (i32.const 1))))
  )
  (func $type-i64-value (result i64)
    (block (result i64) (i64.ctz (br 0 (i64.const 2))))
  )
  (func $type-f32-value (result f32)
    (block (result f32) (f32.neg (br 0 (f32.const 3))))
  )
  (func $type-f64-value (result f64)
    (block (result f64) (f64.neg (br 0 (f64.const 4))))
  )
  ;; Skip because multiple return values are not supported
  ;; (func $type-f64-f64-value (result f64 f64)
  ;;   (block (result f64 f64)
  ;;     (f64.add (br 0 (f64.const 4) (f64.const 5))) (f64.const 6)
  ;;   )
  ;; )
  (func $as-block-first
    (block (br 0) (call $dummy))
  )
  (func $as-block-mid
    (block (call $dummy) (br 0) (call $dummy))
  )
  (func $as-block-last
    (block (nop) (call $dummy) (br 0))
  )
  (func $as-block-value (result i32)
    (block (result i32) (nop) (call $dummy) (br 0 (i32.const 2)))
  )

  (func $as-loop-first (result i32)
    (block (result i32) (loop (result i32) (br 1 (i32.const 3)) (i32.const 2)))
  )
  (func $as-loop-mid (result i32)
    (block (result i32)
      (loop (result i32) (call $dummy) (br 1 (i32.const 4)) (i32.const 2))
    )
  )
  (func $as-loop-last (result i32)
    (block (result i32)
      (loop (result i32) (nop) (call $dummy) (br 1 (i32.const 5)))
    )
  )

  (func $as-br-value (result i32)
    (block (result i32) (br 0 (br 0 (i32.const 9))))
  )

  (func $as-br_if-cond
    (block (br_if 0 (br 0)))
  )
  (func $as-br_if-value (result i32)
    (block (result i32)
      (drop (br_if 0 (br 0 (i32.const 8)) (i32.const 1))) (i32.const 7)
    )
  )
  (func $as-br_if-value-cond (result i32)
    (block (result i32)
      (drop (br_if 0 (i32.const 6) (br 0 (i32.const 9)))) (i32.const 7)
    )
  )

  (func $as-br_table-index
    (block (br_table 0 0 0 (br 0)))
  )
  (func $as-br_table-value (result i32)
    (block (result i32)
      (br_table 0 0 0 (br 0 (i32.const 10)) (i32.const 1)) (i32.const 7)
    )
  )
  (func $as-br_table-value-index (result i32)
    (block (result i32)
      (br_table 0 0 (i32.const 6) (br 0 (i32.const 11))) (i32.const 7)
    )
  )

  (func $as-return-value (result i64)
    (block (result i64) (return (br 0 (i64.const 7))))
  )
  ;; Skip because multiple return values are not supported
  ;; (func $as-return-values (result i32 i64)
  ;;   (i32.const 2)
  ;;   (block (result i64) (return (br 0 (i32.const 1) (i64.const 7))))
  ;; )

  (func $as-if-cond (result i32)
    (block (result i32)
      (if (result i32) (br 0 (i32.const 2))
        (then (i32.const 0))
        (else (i32.const 1))
      )
    )
  )
  (func $as-if-then (param i32 i32) (result i32)
    (block (result i32)
      (if (result i32) (local.get 0)
        (then (br 1 (i32.const 3)))
        (else (local.get 1))
      )
    )
  )
  (func $as-if-else (param i32 i32) (result i32)
    (block (result i32)
      (if (result i32) (local.get 0)
        (then (local.get 1))
        (else (br 1 (i32.const 4)))
      )
    )
  )

  (func $as-select-first (param i32 i32) (result i32)
    (block (result i32)
      (select (br 0 (i32.const 5)) (local.get 0) (local.get 1))
    )
  )
  (func $as-select-second (param i32 i32) (result i32)
    (block (result i32)
      (select (local.get 0) (br 0 (i32.const 6)) (local.get 1))
    )
  )
  (func $as-select-cond (result i32)
    (block (result i32)
      (select (i32.const 0) (i32.const 1) (br 0 (i32.const 7)))
    )
  )
  (func $as-select-all (result i32)
    (block (result i32) (select (br 0 (i32.const 8))))
  )

  (func $f (param i32 i32 i32) (result i32) (i32.const -1))
  (func $as-call-first (result i32)
    (block (result i32)
      (call $f (br 0 (i32.const 12)) (i32.const 2) (i32.const 3))
    )
  )
  (func $as-call-mid (result i32)
    (block (result i32)
      (call $f (i32.const 1) (br 0 (i32.const 13)) (i32.const 3))
    )
  )
  (func $as-call-last (result i32)
    (block (result i32)
      (call $f (i32.const 1) (i32.const 2) (br 0 (i32.const 14)))
    )
  )
  (func $as-call-all (result i32)
    (block (result i32) (call $f (br 0 (i32.const 15))))
  )

  (type $sig (func (param i32 i32 i32) (result i32)))
  (table funcref (elem $f))
  (func $as-call_indirect-func (result i32)
    (block (result i32)
      (call_indirect (type $sig)
        (br 0 (i32.const 20))
        (i32.const 1) (i32.const 2) (i32.const 3)
      )
    )
  )
  (func $as-call_indirect-first (result i32)
    (block (result i32)
      (call_indirect (type $sig)
        (i32.const 0)
        (br 0 (i32.const 21)) (i32.const 2) (i32.const 3)
      )
    )
  )
  (func $as-call_indirect-mid (result i32)
    (block (result i32)
      (call_indirect (type $sig)
        (i32.const 0)
        (i32.const 1) (br 0 (i32.const 22)) (i32.const 3)
      )
    )
  )
  (func $as-call_indirect-last (result i32)
    (block (result i32)
      (call_indirect (type $sig)
        (i32.const 0)
        (i32.const 1) (i32.const 2) (br 0 (i32.const 23))
      )
    )
  )
  (func $as-call_indirect-all (result i32)
    (block (result i32) (call_indirect (type $sig) (br 0 (i32.const 24))))
  )

  (func $as-local.set-value (result i32) (local f32)
    (block (result i32) (local.set 0 (br 0 (i32.const 17))) (i32.const -1))
  )
  (func $as-local.tee-value (result i32) (local i32)
    (block (result i32) (local.tee 0 (br 0 (i32.const 1))))
  )
  (global $a (mut i32) (i32.const 10))
  (func $as-global.set-value (result i32)
    (block (result i32) (global.set $a (br 0 (i32.const 1))))
  )

  (memory 1)
  (func $as-load-address (result f32)
    (block (result f32) (f32.load (br 0 (f32.const 1.7))))
  )
  (func $as-loadN-address (result i64)
    (block (result i64) (i64.load8_s (br 0 (i64.const 30))))
  )
  (func $as-store-address (result i32)
    (block (result i32)
      (f64.store (br 0 (i32.const 30)) (f64.const 7)) (i32.const -1)
    )
  )
  (func $as-store-value (result i32)
    (block (result i32)
      (i64.store (i32.const 2) (br 0 (i32.const 31))) (i32.const -1)
    )
  )
  (func $as-store-both (result i32)
    (block (result i32)
      (i64.store (br 0 (i32.const 32))) (i32.const -1)
    )
  )

  (func $as-storeN-address (result i32)
    (block (result i32)
      (i32.store8 (br 0 (i32.const 32)) (i32.const 7)) (i32.const -1)
    )
  )
  (func $as-storeN-value (result i32)
    (block (result i32)
      (i64.store16 (i32.const 2) (br 0 (i32.const 33))) (i32.const -1)
    )
  )
  (func $as-storeN-both (result i32)
    (block (result i32)
      (i64.store16 (br 0 (i32.const 34))) (i32.const -1)
    )
  )

  (func $as-unary-operand (result f32)
    (block (result f32) (f32.neg (br 0 (f32.const 3.4))))
  )

  (func $as-binary-left (result i32)
    (block (result i32) (i32.add (br 0 (i32.const 3)) (i32.const 10)))
  )
  (func $as-binary-right (result i64)
    (block (result i64) (i64.sub (i64.const 10) (br 0 (i64.const 45))))
  )
  (func $as-binary-both (result i32)
    (block (result i32) (i32.add (br 0 (i32.const 46))))
  )

  (func $as-test-operand (result i32)
    (block (result i32) (i32.eqz (br 0 (i32.const 44))))
  )

  (func $as-compare-left (result i32)
    (block (result i32) (f64.le (br 0 (i32.const 43)) (f64.const 10)))
  )
  (func $as-compare-right (result i32)
    (block (result i32) (f32.ne (f32.const 10) (br 0 (i32.const 42))))
  )
  (func $as-compare-both (result i32)
    (block (result i32) (f64.le (br 0 (i32.const 44))))
  )

  (func $as-convert-operand (result i32)
    (block (result i32) (i32.wrap_i64 (br 0 (i32.const 41))))
  )
  (func $as-memory.grow-size (result i32)
    (block (result i32) (memory.grow (br 0 (i32.const 40))))
  )

  (func $nested-block-value (result i32)
    (i32.add
      (i32.const 1)
      (block (result i32)
        (call $dummy)
        (i32.add (i32.const 4) (br 0 (i32.const 8)))
      )
    )
  )

  (func $nested-br-value (result i32)
    (i32.add
      (i32.const 1)
      (block (result i32)
        (drop (i32.const 2))
        (drop
          (block (result i32)
            (drop (i32.const 4))
            (br 0 (br 1 (i32.const 8)))
          )
        )
        (i32.const 16)
      )
    )
  )

  (func $nested-br_if-value (result i32)
    (i32.add
      (i32.const 1)
      (block (result i32)
        (drop (i32.const 2))
        (drop
          (block (result i32)
            (drop (i32.const 4))
            (drop (br_if 0 (br 1 (i32.const 8)) (i32.const 1)))
            (i32.const 32)
          )
        )
        (i32.const 16)
      )
    )
  )

  (func $nested-br_if-value-cond (result i32)
    (i32.add
      (i32.const 1)
      (block (result i32)
        (drop (i32.const 2))
        (drop (br_if 0 (i32.const 4) (br 0 (i32.const 8))))
        (i32.const 16)
      )
    )
  )

  (func $nested-br_table-value (result i32)
    (i32.add
      (i32.const 1)
      (block (result i32)
        (drop (i32.const 2))
        (drop
          (block (result i32)
            (drop (i32.const 4))
            (br_table 0 (br 1 (i32.const 8)) (i32.const 1))
          )
        )
        (i32.const 16)
      )
    )
  )

  (func $nested-br_table-value-index (result i32)
    (i32.add
      (i32.const 1)
      (block (result i32)
        (drop (i32.const 2))
        (br_table 0 (i32.const 4) (br 0 (i32.const 8)))
        (i32.const 16)
      )
    )
  )

  (func (export "_start")
    (call $assert_test_i32 (call $type-i32-value) (i32.const 1))
    (call $assert_test_i64 (call $type-i64-value) (i64.const 2))
    (call $assert_test_f32 (call $type-f32-value) (f32.const 3))
    (call $assert_test_f64 (call $type-f64-value) (f64.const 4))
    
    ;; multiple return values not supported
    ;; (call $assert_test_f64 (call $type-f64-f64-value) (f64.const 4) (f64.const 5))

    (call $assert_test_i32 (call $as-block-value) (i32.const 2))
    (call $assert_test_i32 (call $as-loop-first) (i32.const 3))
    (call $assert_test_i32 (call $as-loop-mid) (i32.const 4))
    (call $assert_test_i32 (call $as-loop-last) (i32.const 5))

    (call $assert_test_i32 (call $as-br-value) (i32.const 9))

    (call $assert_test_i32 (call $as-br_if-value) (i32.const 8))
    (call $assert_test_i32 (call $as-br_if-value-cond) (i32.const 9))

    (call $assert_test_i32 (call $as-br_table-value) (i32.const 10))
    (call $assert_test_i32 (call $as-br_table-value-index) (i32.const 11))

    (call $assert_test_i64 (call $as-return-value) (i64.const 7))
    
    ;; multiple return values not supported
    ;; (call $assert_test_i32 (call $as-return-values) (i32.const 2) (i64.const 7))

    (call $assert_test_i32 (call $as-if-cond) (i32.const 2))
    (call $assert_test_i32 (call $as-if-then (i32.const 1) (i32.const 6)) (i32.const 3))
    (call $assert_test_i32 (call $as-if-then (i32.const 0) (i32.const 6)) (i32.const 6))
    (call $assert_test_i32 (call $as-if-else (i32.const 0) (i32.const 6)) (i32.const 4))
    (call $assert_test_i32 (call $as-if-else (i32.const 1) (i32.const 6)) (i32.const 6))

    (call $assert_test_i32 (call $as-select-first (i32.const 0) (i32.const 6)) (i32.const 5))
    (call $assert_test_i32 (call $as-select-first (i32.const 1) (i32.const 6)) (i32.const 5))
    (call $assert_test_i32 (call $as-select-second (i32.const 0) (i32.const 6)) (i32.const 6))
    (call $assert_test_i32 (call $as-select-second (i32.const 1) (i32.const 6)) (i32.const 6))
    (call $assert_test_i32 (call $as-select-cond) (i32.const 7))
    (call $assert_test_i32 (call $as-select-all) (i32.const 8))

    (call $assert_test_i32 (call $as-call-first) (i32.const 12))
    (call $assert_test_i32 (call $as-call-mid) (i32.const 13))
    (call $assert_test_i32 (call $as-call-last) (i32.const 14))
    (call $assert_test_i32 (call $as-call-all) (i32.const 15))

    (call $assert_test_i32 (call $as-call_indirect-func) (i32.const 20))
    (call $assert_test_i32 (call $as-call_indirect-first) (i32.const 21))
    (call $assert_test_i32 (call $as-call_indirect-mid) (i32.const 22))
    (call $assert_test_i32 (call $as-call_indirect-last) (i32.const 23))
    (call $assert_test_i32 (call $as-call_indirect-all) (i32.const 24))

    (call $assert_test_i32 (call $as-local.set-value) (i32.const 17))
    (call $assert_test_i32 (call $as-local.tee-value) (i32.const 1))
    (call $assert_test_i32 (call $as-global.set-value) (i32.const 1))

    (call $assert_test_f32 (call $as-load-address) (f32.const 1.7))
    (call $assert_test_i64 (call $as-loadN-address) (i64.const 30))

    (call $assert_test_i32 (call $as-store-address) (i32.const 30))
    (call $assert_test_i32 (call $as-store-value) (i32.const 31))
    (call $assert_test_i32 (call $as-store-both) (i32.const 32))
    (call $assert_test_i32 (call $as-storeN-address) (i32.const 32))
    (call $assert_test_i32 (call $as-storeN-value) (i32.const 33))
    (call $assert_test_i32 (call $as-storeN-both) (i32.const 34))

    (call $assert_test_f32 (call $as-unary-operand) (f32.const 3.4))

    (call $assert_test_i32 (call $as-binary-left) (i32.const 3))
    (call $assert_test_i64 (call $as-binary-right) (i64.const 45))
    (call $assert_test_i32 (call $as-binary-both) (i32.const 46))

    (call $assert_test_i32 (call $as-test-operand) (i32.const 44))

    (call $assert_test_i32 (call $as-compare-left) (i32.const 43))
    (call $assert_test_i32 (call $as-compare-right) (i32.const 42))
    (call $assert_test_i32 (call $as-compare-both) (i32.const 44))

    (call $assert_test_i32 (call $as-convert-operand) (i32.const 41))

    (call $assert_test_i32 (call $as-memory.grow-size) (i32.const 40))

    (call $assert_test_i32 (call $nested-block-value) (i32.const 9))
    (call $assert_test_i32 (call $nested-br-value) (i32.const 9))
    (call $assert_test_i32 (call $nested-br_if-value) (i32.const 9))
    (call $assert_test_i32 (call $nested-br_if-value-cond) (i32.const 9))
    (call $assert_test_i32 (call $nested-br_table-value) (i32.const 9))
    (call $assert_test_i32 (call $nested-br_table-value-index) (i32.const 9))
  )
)