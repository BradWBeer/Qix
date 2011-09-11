(in-package :qix)

;; Utility functions (what it says on the tin)
(defun simple-insert (lst pos ins)
  (append (subseq lst 0 pos)
	  ins
	  (subseq lst pos)))

(defun simple-delete (lst pos len)
  (append (subseq lst 0 pos)
	  (subseq lst (+ pos len))))

;; The class to hold the data....
(defclass buffer ()
  ((data
    :initform nil
    :initarg :data)
   (handlers
    :initform nil
    :initarg :handlers)
   (todo
    :initform nil)
   (changes
    :initform nil)))

;; Add an event handler...Returns an id that is necessary to remove it later...
(defmethod add-handler ((this buffer) func)
  (with-slots ((h handlers)) this
    (1- (length (setf h (append h (list func)))))))

;; remove the event handler given the id from before.
(defmethod remove-handler ((this buffer) func)
  (with-slots ((h handlers)) this
    (setf h (remove-if #'(lambda (x)
			   (eq x func))
		       h))))
    
;; Get the current data...
(defmethod get-data ((this buffer))
  (slot-value this 'data))

;; Are there changes waiting to be applied?
(defmethod changed? ((this buffer))
  (slot-value this 'todo))

;; Internal function....
(defmethod add-todo ((this buffer) &rest changes)
  (with-slots ((todo todo)) this
    (push (if changes (car changes)
	      (list t))
	  todo)))
	  
;; get the nth item, like nth only with the buffer...      
(defmethod get-nth-item ((this buffer) &rest args)
  (labels ((my-nth (d i)
	     (if (cdr i)
 		 (my-nth (nth (car i) d) (cdr i))
 		 (nth (car i) d))))
    (my-nth (slot-value this 'data) args)))

;; set the nth item. Remember to call update to commit the change
(defmethod set-nth-item ((this buffer) replacement args)
  (add-todo this (list 's replacement args)))

;; brains of set-nth-item
(defmethod _s ((this buffer) replacement args)
  (labels ((my-nth (d i)
	     (print d)
	     (print i)
	     (if (cdr i)
 	      	 (my-nth (nth (car i) d) (cdr i))
	      	 (setf (nth (car i) d) replacement))))
    (my-nth (slot-value this 'data) args)))


;; Append items. Remember to call update to commit the change
(defmethod append-items ((this buffer) &rest args)
  (add-todo this (list 'a args)))

;; Brains of append item
(defmethod _a ((this buffer) &rest args)
  (setf (slot-value this 'data) (append (slot-value this 'data) args)))

;; Prepend items. Remember to call update to commit the change.
(defmethod prepend-items ((this buffer) &rest args)
  (add-todo this (list 'p args)))

;; brains of prepend
(defmethod _p ((this buffer) args)
  (setf (slot-value this 'data) (append args (slot-value this 'data))))

;; Insert items. Remember to call update to commit the change.
(defmethod insert-items ((this buffer) insertion location)
  (add-todo this (list 'i insertion location)))

;; brains of insert items
(defmethod _i ((this buffer) insertion location)
  (print insertion)
  (print location)
  (labels ((my-nth (d i)
	     (if (cddr i)
 		 (my-nth (nth (car i) d) (cdr i))
		 (progn
		   (setf (nth (car i) d) (simple-insert (nth (car i) d)
							(cadr i)
							insertion))))))
    (if (cdr location)
	(my-nth (slot-value this 'data) location)
	(setf (slot-value this 'data)
	      (simple-insert (slot-value this 'data)
			     (car location)
			     insertion)))
    (get-data this)))

;; delete items. Remember to call update to commit the change.
(defmethod delete-items ((this buffer) length location)
    (add-todo this (list 'd length location)))

;; brains of delete items
(defmethod _d ((this buffer) length location)
  (print this)
  (print length)
  (print location)
  (labels ((my-nth (d i)
	     (if (cddr i)
 		 (my-nth (nth (car i) d) (cdr i))
		 (progn
		   (setf (nth (car i) d) (simple-delete (nth (car i) d)
							(cadr i)
							length))))))
    (if (cdr location)
	(my-nth (slot-value this 'data) location)
	(setf (slot-value this 'data)
	      (simple-delete (slot-value this 'data)
			     (car location)
			     length))))
  (get-data this))
  
;; clear items. Remember to call update to commit the change.
(defmethod clear-items ((this buffer))
  (add-todo this '(c)))

;; brains of clean-items
(defmethod _c ((this buffer))
  (setf (slot-value this 'data) nil))

;; applies the saved updates and notifies the handlers....
(defmethod update ((this buffer) &key)
  (with-slots ((todo todo)
	       (data data)
	       (handlers handlers)) this
    (when todo
      (loop for (cmd . rest) in todo
	 do (print cmd)
	 do (print rest)
      	 do (cond ((eq 'a cmd) (apply #'_a (cons this (car rest))))
		  ((eq 'c cmd) (funcall #'_c this))
		  ((eq 'd cmd) (apply #'_d this rest))
		  ((eq 'i cmd) (apply #'_i this rest))
		  ((eq 'p cmd) (apply #'_p this rest))
		  ((eq 's cmd) (apply #'_s this rest))
		  (t '(this was not found!))))
      (loop for i in handlers
	    do (funcall i this todo))
      (setf todo nil)
      data)))
			 

(defmethod forget-changes ((this buffer))
  (setf (slot-value this 'todo) nil))

; (_A _C _D _I _P _S)


(setf b (make-instance 'buffer :data t))
(setf (slot-value b 'data) '(this is a (test of the (emergency) broad-cast (system)) this is only a test))

