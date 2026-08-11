; course: CMPS3500
; lab 08
; date: 05/07/2025
; username: ngallego
; name: Noah Gallego

(defun tokenize (line)
  (labels ((helper (chars acc curr)
             (cond
               ((null chars)
                (if (null curr)
                    (nreverse acc)
                    (nreverse (cons (coerce (nreverse curr) 'string) acc))))
               ((member (car chars) '(#\Space #\Tab #\Newline))
                (if (null curr)
                    (helper (cdr chars) acc '())
                    (helper (cdr chars)
                            (cons (coerce (nreverse curr) 'string) acc)
                            '())))
               (t
                (helper (cdr chars) acc (cons (char-downcase (car chars)) curr))))))
    (helper (coerce line 'list) '() '())))


(defun unique-words (infile outfile)
  (let ((word-list '()))
    (with-open-file (in infile :direction :input)
      (loop for line = (read-line in nil)
            while line
            do (setf word-list (nconc word-list (tokenize line)))))
    (setf word-list (remove-duplicates word-list :test #'string=))
    (with-open-file (out outfile :direction :output :if-exists :supersede)
      (dolist (word word-list)
        (format out "~A~%" word)))
    (format t "Output file has been generated! Please check it out~%")))


(defun reverse-list (lst)
  (if (null lst)
      '()
      (append (reverse-list (cdr lst)) (list (car lst)))))


(defun power-two (n)
  (cond ((= n 0) 1)
        ((evenp n) (let ((half (power-two (/ n 2)))) (* half half)))
        (t (* 2 (power-two (- n 1))))))


(defun power-set (lst)
  (if (null lst)
      (list nil)
      (let ((rest (power-set (cdr lst))))
        (append rest (mapcar (lambda (x) (cons (car lst) x)) rest)))))


(defun intercalate (list1 list2)
  (cond ((not (= (length list1) (length list2)))
         (format t "\"Lists must have the same length, please try again!\"~%"))
        ((null list1) nil)
        (t (cons (car list1)
                 (cons (car list2)
                       (intercalate (cdr list1) (cdr list2)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sample Tests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(format t "~%~%Test unique-words:~%-----------------------~%")
(unique-words "infile.data" "outfile.data")

(format t "~%Test Recursive Reverse:~%-----------------------~%")
(print (reverse-list '(1)))
(print (reverse-list '(1 2 3)))
(print (reverse-list '(1 (2 4 6) 3)))

(format t "~%Test Recursive Power of 2:~%-----------------------~%")
(print (power-two 0))
(print (power-two 5))
(print (power-two 20))

(format t "~%Test Recursive Power of a Set:~%-----------------------~%")
(print (power-set '(1)))
(print (power-set '(1 2 3)))
(print (power-set '(1 2 3 (4))))

(format t "~%Test intercalate:~%-----------------------~%")
(print (intercalate '(1) '(3)))
(print (intercalate '(1 2) '(3 4)))
(print (intercalate '(1 3 5) '(2 4 6)))
(print (intercalate '(1 3 5) '(2)))