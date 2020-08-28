;;; yasnippet-verilog.el --- Yasnippets for Verilog

;; Copyright (C) 2019 Enze Chi

;; Author: Enze Chi
;; Version: 0.2.1
;; URL: https://github.com/ezchi/yasnippets-verilog.git
;; Package-Requires: ((yasnippet "0.8.0"))

;;; Commentary:

;;; Code:

(require 'yasnippet)

(defvar yasnippets-verilog-root
  (file-name-directory (or load-file-name (buffer-file-name))))

;;;###autoload
(defun yasnippets-verilog-initialize ()
  "Add yasnippets-verilog directory to YAS."
  (let ((snip-dir (expand-file-name "snippets" yasnippets-verilog-root)))
    (when (boundp 'yas-snippet-dirs)
      (add-to-list 'yas-snippet-dirs snip-dir t))
    (yas-load-directory snip-dir)))

;;;###autoload
(with-eval-after-load 'yasnippet
  (yasnippets-verilog-initialize))

(provide 'yasnippets-verilog)

;;; yasnippets-verilog.el ends here
