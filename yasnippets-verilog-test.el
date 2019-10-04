;;; yasnippets-verilog-test.el --- Tests for yasnippets-verilog

;;; Commentary:

;;; Code:
(load-file "snippets/verilog-mode/.yas-setup.el")

(ert-deftest test-get-pkg-name()
  "Tests get package name."
  (should (equal (get-pkg-name "test_abs_if") "test"))
  (should (equal (get-pkg-name "test_abs_if_pkg") "test"))
  (should (equal (get-pkg-name "test_agent_pkg") "test"))
  (should (equal (get-pkg-name "test_pkg") "test")))

(ert-deftest test-parse-parameters ()
  "Tests parsing parameter string."
  (should (equal (parse-parameters "int DWIDTH = 10")
                 (list '("DWIDTH" "10"))))
  (should (equal (parse-parameters "int P_NO_VAL,")
                 (list '("P_NO_VAL"))))
  (should (equal (parse-parameters "int P1 = 1, int P2, int P3, parameter int P4 = 4")
                 (list '("P1" "1")
                       '("P2")
                       '("P3")
                       '("P4" "4"))))
  (should (equal (parse-parameters "int P_DATA_WIDTH = 10,
              int P_ADDR_WIDTH = 12,
              int P_NO_VAL,
              int P_DEPTH      = 8, int P_SAME_LINE_NO_VALUE, int P_SAME_LINE_WITH_VALUE=5,
              int unsigned P_UNSIGNED_DATA = \"OK\"")
                 (list '("P_DATA_WIDTH" "10")
                       '("P_ADDR_WIDTH" "12")
                       '("P_NO_VAL")
                       '("P_DEPTH" "8")
                       '("P_SAME_LINE_NO_VALUE")
                       '("P_SAME_LINE_WITH_VALUE" "5")
                       '("P_UNSIGNED_DATA" "\"OK\"")))))


(ert-deftest test-make-parameter-assign ()
  "Tests `make-parameter-assign'."
  (should (equal (make-parameter-assign '("DWIDTH" "8"))
                 ".DWIDTH(DWIDTH)")))

(ert-deftest test-make-parameter-assign-list ()
  "Tests `make-parameter-assign-list'."
  (should (equal (make-parameter-assign-list (list '("A" "5")
                                                   '("B" "6")))
                 ".A(A), .B(B)"))
  (should (equal (make-parameter-assign-list (list '("A" "5")
                                                   '("B" "6")
                                                   '("C" "7")) " -- ")
                 ".A(A) -- .B(B) -- .C(C)")))

(ert-deftest test-make-abbrev ()
  "Tests `make-abbrev'."
  (should (equal (make-abbrev "snake_case")
                 "sc"))
  (should (equal (make-abbrev "simple_data_driver")
                 "sdd")))

(provide 'yasnippet-verilog-test)
;;; yasnippets-verilog-test.el ends here
