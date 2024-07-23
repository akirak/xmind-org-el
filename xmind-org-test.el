;;; -*- lexical-binding: t -*-

(require 'buttercup)
(require 'xmind-org)

(defvar url-http-end-of-headers)

(defconst xmind-org-test-url
  "https://raw.githubusercontent.com/ivan-kleshnin/frontend-mindmaps/master/middle.xmind")

(defconst xmind-org-test-file-name
  "middle.xmind")

(defun xmind-org-test-download-test-data ()
  (unless (file-exists-p xmind-org-test-file-name)
    (with-current-buffer (url-retrieve-synchronously xmind-org-test-url t t)
      (when (bound-and-true-p url-http-end-of-headers)
        (delete-region (point-min)
                       (if (markerp url-http-end-of-headers)
                           (marker-position url-http-end-of-headers)
                         url-http-end-of-headers)))
      (write-region (point-min) (point-max) xmind-org-test-file-name))))

(describe "Parse a file"
  (describe "middle.xmind"
    (xmind-org-test-download-test-data)
    (let ((buffer (create-file-buffer "sample.org")))
      (it "parses a file"
        (unwind-protect
            (with-current-buffer buffer
              (org-mode)
              (xmind-org-insert-file "middle.xmind")
              (expect (org-before-first-heading-p) :to-be nil))
          (kill-buffer buffer))))))

(provide 'xmind-org-test)
