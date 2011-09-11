
(defpackage #:pango
  (:nicknames #:pango)
  (:use #:common-lisp #:cffi #:pango-bindings)
;  (:shadow #:char #:float #:byte #:boolean #:string)
  (:export

   #:layout
   #:free
   
   ))
