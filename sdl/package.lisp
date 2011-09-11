(defpackage #:Qix-SDL
  (:nicknames #:%QIX-SDL)
  (:use #:common-lisp #:cffi #:cl-opengl)
;  (:shadow #:char #:float #:byte #:boolean #:string)
  (:export

   #:*on-init* #:*on-resize* #:*on-keydown* #:*on-keyup* #:*on-mousedown* #:*on-mouseup* 
   #:*on-mousemove* #:*on-joymove* #:*on-joydown* #:*on-joyup* #:*on-joyhatmove* #:*on-joyballmove* 
   #:*on-user-event* #:*on-idle* #:*on-close* #:start #:start-threaded

   ))


