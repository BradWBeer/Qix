(in-package :QIX-SDL)


(defun *on-init* (width height fullscreen resize)
  (format t "*on-init* w ~A h ~A fullscreen ~A resize ~A" width height fullscreen resize))

(defun *on-resize* (w h)
  (format t "on-resize: w ~A h ~A~%" w h)
  (sdl:resize-window w h)
  (gl:viewport 0 0 w h))

(defun *on-keydown* (c state scancode key mod mod-key unicode)
  (when (sdl:key= :SDL-KEY-ESCAPE KEY)
    (SDL:PUSH-QUIT-EVENT)))

(defun *on-keyup* (state scancode key mod mod-key))
(defun *on-mousedown* (button state x y))
(defun *on-mouseup* (button state x y))
(defun *on-mousemove* (state x y x-rel y-rel))
(defun *on-joymove* (which axis value))
(defun *on-joydown* (which button state))
(defun *on-joyup* (which button state))
(defun *on-joyhatmove* (which hat value))
(defun *on-joyballmove* (which ball x-rel y-rel))
(defun *on-user-event* (type code data1 data2))

(defun *on-idle* ()
  (sleep 0)
  (gl:enable :blend :line-smooth :depth-test :lighting :color-material :light0)
  (%gl:clear-color 0 0 0 0)
  (gl:clear :color-buffer-bit :depth-buffer-bit)
  (gl:load-identity)
  (gl:rotate (* 360 (/ (rem (get-internal-real-time) 10000) 10000))
	     1 0 0)

  
  )

(defun *on-close* ())

(defun start (width height &key
	       (title "Test Title")
	       (caption "Test Caption")
	       (resize t)
	       (fullscreen nil)
	       (framerate nil))

   (proclaim '(optimize (speed 3) (space 0) (debug 0)))


    (glut:init)

     (sdl:with-init (sdl-cffi::sdl-init-joystick sdl-cffi::sdl-init-audio)
       (sdl-cffi::sdl-joystick-open 0)
       (sdl:window width height
		   :OPENGL t
		   :TITLE-CAPTION title
   		:ICON-CAPTION caption
   		:DOUBLE-BUFFER t
   		:RESIZABLE resize
   		:FULLSCREEN fullscreen
   		:opengl-attributes '(:SDL-GL-RED-SIZE 8
   				     :SDL-GL-GREEN-SIZE 8
   				     :SDL-GL-BLUE-SIZE 8
   				     :SDL-GL-ALPHA-SIZE 8))

   (setf (sdl:frame-rate) framerate)

    (gl:check-error)
    (sdl:enable-unicode)
    (sdl:resize-window width height)
    (gl:viewport 0 0 width height)
    (setf cl-opengl-bindings:*gl-get-proc-address* #'sdl-cffi::sdl-gl-get-proc-address)
    (setf *gl-get-proc-address* #'sdl-cffi::sdl-gl-get-proc-address)

     (sdl-mixer:OPEN-AUDIO)

     (*on-init* width height fullscreen resize)
     (*on-resize* width height)
    
     (unwind-protect
 	 (sdl:with-events ()

 	   (:quit-event ()
 			(*on-close*)
 			t)	   
	   (:video-expose-event () (sdl:update-display))
 	   (:VIDEO-RESIZE-EVENT (:W w :H h)  
 				(sdl:resize-window w h)
 				(*on-resize* w h))

   
	   (:KEY-DOWN-EVENT
 	    (:STATE STATE :SCANCODE SCANCODE :KEY KEY :MOD MOD :MOD-KEY MOD-KEY :UNICODE UNICODE)
 	    (*on-keydown* (code-char unicode) state scancode key mod mod-key unicode))

	   
 	   (:KEY-UP-EVENT
 	    (:STATE STATE :SCANCODE SCANCODE :KEY KEY :MOD MOD :MOD-KEY MOD-KEY)
 	    (*on-keyup* state scancode key mod mod-key))
	   
	   (:MOUSE-BUTTON-DOWN-EVENT (:BUTTON BUTTON :STATE STATE :X X :Y Y)
				     (*on-mousedown* button state x y))
	   
	   (:MOUSE-BUTTON-UP-EVENT (:BUTTON BUTTON :STATE STATE :X X :Y Y)
				   (*on-mouseup* button state x y))
	   
	   (:MOUSE-MOTION-EVENT (:STATE STATE :X X :Y Y :X-REL X-REL :Y-REL Y-REL)
				(*on-mousemove* state x y x-rel y-rel))
	   
	   (:JOY-AXIS-MOTION-EVENT (:WHICH WHICH :AXIS AXIS :VALUE VALUE)
				   (*on-joymove* which axis value))
	   
	   (:JOY-BUTTON-DOWN-EVENT (:WHICH WHICH :BUTTON BUTTON :STATE STATE)
				   (*on-joydown* which button state))
	   
	   (:JOY-BUTTON-UP-EVENT (:WHICH WHICH :BUTTON BUTTON :STATE STATE)
				 (*on-joyup* which button state))
	   
;;	   (:JOY-HAT-MOTION-EVENT (:WHICH WHICH :HAT HAT :VALUE VALUE)
;;				  (*on-joyhatmove* which hat value))
	   
	   (:JOY-BALL-MOTION-EVENT (:WHICH WHICH :BALL BALL :X-REL X-REL :Y-REL Y-REL)
				   (*on-joyballmove* which ball x-rel y-rel))
 	   (:USER-EVENT (:TYPE TYPE :CODE CODE :DATA1 DATA1 :DATA2 DATA2)
 			(*on-user-event* type code data1 data2))
	   
	   (:IDLE ()
		  (*on-idle*)
		  (sdl:update-display)))
      
      (sdl-mixer:Halt-Music)
      (sdl-mixer:Close-Audio t)
      (sdl-mixer:quit-mixer)
      (format t "Did this run?~%"))))


(defmacro start-threaded (&rest args)
  `(bordeaux-threads:make-thread 
    (lambda ()
      (qix-sdl:start ,@args)))) 