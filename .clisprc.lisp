(defun compile-and-load (filename)
  (and 
    (compile-file filename)
    (load filename)))

(defun cpe ()
  (compile-and-load #p"project-euler"))
(defun lpe ()
  (load #p"project-euler.lisp"))
