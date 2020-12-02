;;; -*- lexical-binding: t -*-

(require 'buttercup)
(require 'xmind-org)

(describe "Parse a file"
  (describe "middle.xmind"
    (let ((buffer (create-file-buffer "sample.org")))
      (it "parses a file"
        (unwind-protect
            (with-current-buffer buffer
              (org-mode)
              (xmind-org-insert-file "middle.xmind")
              (expect (org-before-first-heading-p) :to-be nil))
          (kill-buffer buffer))))))

(provide 'xmind-org-test)
