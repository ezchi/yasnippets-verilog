;;; package --- Elisp functions for Verilog Mode Snippets

;;; Commentary:

;;; Code:

(defun get-buffer-name ()
  "Get buffer base name."
  (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))

(defconst pkg-suffix
  (regexp-opt '(
                "item"
                "config"
                "macros"
                "driver"
                "monitor"
                "sequencer"
                "sequence"
                "scoreboard"
                "seq_lib"
                "test_lib"
                "agent"
                "pkg"
                "abs_if"
                "if"
                "abs_if_pkg"
                "env"
                "vseq"
                ) nil))


(defun get-pkg-name (name)
  "Get the package name from NAME."
  (let ((s (substring-no-properties name)))
    ;; (string-match "\\(.*?\\)_\\(agent_pkg\\|agent\\|env\\|item\\|config\\|driver\\|monitor\\|scoreboard\\|abs_if\\|abs_if_pkg\\|if\\|abstract\\|sequencer\\|sequence\\|seq_lib\\|test_lib\\|c\\|pkg\\)" s)
    (if (string-match (concat "\\(.*?\\)_" pkg-suffix) s)
        (match-string 1 s)
      s)))

;; (get-pkg-name "test_abs_if")
;; (get-pkg-name "test_abs_if_pkg")
;; (get-pkg-name "test_agent_pkg")
;; (get-pkg-name "test_pkg")

(defun parse-parameters (string)
  "Parsing the parameter declaration STRING.
Return list of (name . value) of parameter.  If parameter's
default value is not defined in the original string, the value in
return list element will be set to 'nil'"
  (let (param (list ))
    (dolist (p (split-string string ",[ \t\n]*" t "\\s-*"))   ; split string and trim the result
      (let* ((tmp_param (split-string p "=" t "\\s-*"))  ; separate the parameter name and value
             (val (cdr tmp_param))
             (name (car (last (split-string (car tmp_param) nil t)))))
          (add-to-list 'param (cons name val))))
    (reverse param)))

;; (setq my-str "int P_DATA_WIDTH = 10,
;;               int P_ADDR_WIDTH = 12,
;;               int P_NO_VAL,
;;               int P_DEPTH      = 8, int P_SAME_LINE_NO_VALUE, int P_SAME_LINE_WITH_VALUE, 
;;               int unsigned P_UNSIGNED_DATA = \"OK\"")

;; (parse-parameters my-str)

(defun make-parameter-assign (param)
  "Create parameter assignment format string.
For example, for parameter `P_D1', the return value should be `.P_D1(P_D1)'
PARAM should be list of parameter name and value: (name . value)"
  (let ((param-name (car param)))
    (format ".%s(%s)" param-name param-name)))

(defun make-parameter-assign-list (params &optional separator)
  "Create the list of parameter assignments and separated by `separator`.
PARAMS is the list of parameter name and value pairs.
If SEPARATOR is nil, `, ' will be used as default separator."
  (let ((sep (or separator
                 ", ")))
    (mapconcat 'make-parameter-assign params sep)))

;; (make-parameter-assign (car (parse-parameters my-str)))
;; (format "#(%s)" (make-parameter-assign-list (parse-parameters my-str)))
;; (format "#(\n%s\n)" (make-parameter-assign-list (parse-parameters my-str) ",\n"))

;; (cdr (list 1))
;; (car (list "1" "2"))
;; (nth 0 (list "1" "2"))


(defun make-abbrev (s)
  "Make abbreviation of S by take first character of each word separated by `_'."
  (interactive)
  (let ((ss (split-string s "_"))
        (abbrev ""))
    (dolist (v ss)
      (setq abbrev (concat abbrev (downcase (substring v 0 1)))))
    abbrev))


