;;; .yas-setup.el --- Elisp functions for Verilog Mode Snippets  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun get-buffer-name ()
  "Get buffer base name."
  (file-name-base (buffer-file-name)))

(defconst pkg-suffix
  (regexp-opt '(
                "abs_if"
                "abs_if_pkg"
                "agent"
                "config"
                "driver"
                "env"
                "if"
                "intf"
                "item"
                "macros"
                "monitor"
                "pkg"
                "scoreboard"
                "seq_lib"
                "sequence"
                "sequencer"
                "tb"
                "test_lib"
                "vseq"
                ) nil))


(defun get-pkg-name (name)
  "Get the package name from NAME."
  (let ((s (substring-no-properties name)))
    (if (string-match (concat "\\(.*?\\)_" pkg-suffix) s)
        (match-string 1 s)
      s)))

(defun parse-parameters (string)
  "Parsing the parameter declaration STRING.
Return list of (name . value) of parameter.  If parameter's
default value is not defined in the original string, the value in
return list element will be set to 'nil'"
  (let (params
        (lines (split-string string ",[ \t\n]*" t "\\s-*")))   ; split string and trim the result
    (dolist (l lines)
      (let* ((param (split-string l "=" t "\\s-*"))  ; separate the parameter name and value
             (val (cdr param))
             (name (car (last (split-string (car param) nil t)))))
          (add-to-list 'params (cons name val))))
    (reverse params)))

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

(defun make-abbrev (s)
  "Make abbreviation of S by take first character of each word separated by `_'."
  (interactive)
  (let ((ss (split-string s "_"))
        (abbrev ""))
    (dolist (v ss)
      (setq abbrev (concat abbrev (downcase (substring v 0 1)))))
    abbrev))
