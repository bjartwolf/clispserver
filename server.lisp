(ql:quickload :hunchentoot :silent t)

(defpackage #:clispserver
  (:use #:cl)
  (:export #:start #:stop))

(in-package #:clispserver)

(defvar *acceptor* nil)

(hunchentoot:define-easy-handler (root :uri "/") ()
  (setf (hunchentoot:content-type*) "text/plain")
  "Hello, World!")

(defun start (&key (port 4242))
  (when *acceptor*
    (hunchentoot:stop *acceptor*))
  (setf *acceptor*
        (hunchentoot:start
         (make-instance 'hunchentoot:easy-acceptor :port port)))
  (format t "~&Listening on http://127.0.0.1:~a/~%" port)
  *acceptor*)

(defun stop ()
  (when *acceptor*
    (hunchentoot:stop *acceptor*)
    (setf *acceptor* nil)))
