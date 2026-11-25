(eval-when (:compile-toplevel :load-toplevel :execute)
  (ql:quickload '(:hunchentoot :slynk) :silent t))

(defpackage #:clispserver
  (:use #:cl)
  (:export #:start #:stop))

(in-package #:clispserver)

(defvar *acceptor* nil)
(defvar *slynk-started* nil)

(hunchentoot:define-easy-handler (root :uri "/") ()
  (setf (hunchentoot:content-type*) "text/plain")
  "Hello, World!")

(defun start (&key (port 4242) (slynk-port 4005))
  (unless *slynk-started*
    (slynk:create-server
      :port slynk-port
      :dont-close t)
    (setf *slynk-started* t))

  (when *acceptor*
    (hunchentoot:stop *acceptor*))
  (setf *acceptor*
        (hunchentoot:start
         (make-instance 'hunchentoot:easy-acceptor :port port)))
  (format t "~&Listening on http://127.0.0.1:~a/~%" port)
  (format t "~&SLYNK listening on 127.0.0.1:~A~%" slynk-port)
  *acceptor*)

(defun stop ()
  (when *acceptor*
    (hunchentoot:stop *acceptor*)
    (setf *acceptor* nil)))
