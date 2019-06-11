;;; yasnippet-verilog.el --- Yasnippets for Verilog

;; Copyright (C) 2019 Enze Chi

;; Author: Enze Chi
;; URL: https://github.com/ezchi/yasnippet-verilog.git
;; Package-Requires: ((yasnippet "0.8.0"))

;;; Commentary:

;;; Code:

(require 'yasnippet)

(defvar yasnippet-verilog-root
  (file-name-directory (or load-file-name (buffer-file-name))))

;;;###autoload
(defun yasnippet-verilog-initialize ()
  (let ((snip-dir (expand-file-name "snippets" yasnippet-verilog-root)))
    (when (boundp 'yas-snippet-dirs)
      (add-to-list 'yas-snippet-dirs snip-dir t))
    (yas-load-directory snip-dir)))

;;;###autoload
(eval-after-load 'yasnippet
  '(yasnippet-verilog-initialize))

(provide 'yasnippet-verilog)

;;; yasnippet-verilog.el ends here
