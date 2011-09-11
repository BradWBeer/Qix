(defpackage #:FreeImage
  (:nicknames #:FI)
  (:use #:common-lisp #:cffi #:FreeImage-Bindings)
;  (:shadow #:char #:float #:byte #:boolean #:string)
  (:export

   #:FreeImageBitmap
   ))
