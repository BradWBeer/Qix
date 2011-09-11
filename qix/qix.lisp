(in-package :qix)


(defun draw-image-centered (texture width height x y layer &optional (angle 0))
    (gl:bind-texture :texture-2d texture)
    (gl:with-pushed-matrix
     (gl:translate x y layer)
     (gl:rotate angle 0 0 -1)
      
      (let ((halfw (/ width 2))
	    (halfh (/ height 2)))
	(gl:with-primitive :quads
	  (gl:tex-coord 0 0) 
	  (gl:Vertex (- halfw) (- halfh))
	  
	  (gl:tex-coord 0 1)
	  (gl:Vertex (- halfw) halfh)
	  
	  (gl:tex-coord 1 1)	  
	  (gl:Vertex halfw halfh)
	  
	  (gl:tex-coord 1 0)
	  (gl:Vertex halfw (- halfh))))))



(defun load-2d-image (texture 
			  data 
			  width 
			  height &key
			  (format :bgra)
			  (data-type :unsigned-byte)
			  (wrap-s :repeat) 
			  (wrap-t :repeat)
			  (mag-filter :nearest)
			  (min-filter :nearest)
			  (perspective-correction-hint :nicest)
			  (stride))
  (unless texture
    (setf texture (car (gl:gen-textures 1))))
  (if stride (gl:pixel-store :unpack-row-length stride))
  (gl:bind-texture  :texture-2d texture)
  (gl:tex-parameter :texture-2d :texture-wrap-s wrap-s)
  (gl:tex-parameter :texture-2d :texture-wrap-t wrap-t)
  (gl:tex-parameter :texture-2d :texture-mag-filter mag-filter)
  (gl:tex-parameter :texture-2d :texture-min-filter min-filter)
  (gl:hint :perspective-correction-hint perspective-correction-hint)
  
  (gl:tex-image-2d :texture-2d 0 :rgba width height 0 format data-type data)
  texture)



(defun draw-rect-centered (color width height x y layer &optional (angle 0))
  (gl:disable :texture-2d)
  (gl:with-pushed-matrix
    (gl:translate x y layer)
    (gl:rotate angle 0 0 -1)
    
    (let ((halfw (/ width 2))
	  (halfh (/ height 2)))
      (gl:with-primitive :quads
	(apply #'gl:color color)
	(gl:Vertex (- halfw) (- halfh))
	(gl:Vertex (- halfw) halfh)
	(gl:Vertex halfw halfh)
	(gl:Vertex halfw (- halfh))
	(gl:color 1 1 1))))
  (gl:enable :texture-2d))




(defclass image ()
  ((surface
    :initform nil
    :initarg :surface)
   (id
    :initform nil)
   (width
    :initform nil
    :initarg :width
    :reader get-width)
   (height
    :initform nil
    :initarg :height
    :reader get-height)
   (updated
    :initform nil)))

(defmethod update ((this image) &key)
  (setf (slot-value this 'updated) t))

(defmacro with-image-surface ((surface-name width height &optional (type :argb32)) &body body)
  (let ((context (gensym))
	(retval (gensym)))
    `(let* ((,surface-name (cairo:create-image-surface ,type ,width ,height))
	    (,context (cairo:create-context ,surface-name)))
       (setf ,retval 
	     (unwind-protect 
		  (cairo:with-context (,context)
		    ,@body)))
       
       (progn (cairo:destroy ,context)
	      (cairo:destroy ,surface-name)
	      ,retval))))



      
(defmethod image->GLBuffer ((this image))
  (if (slot-value this 'updated)
      (setf (slot-value this 'id)
	    (load-2d-image (slot-value this 'id)
			   (cairo:image-surface-get-data (slot-value this 'surface) :pointer-only t) 
			   (get-width this)
			   (get-height this)))
      (cairo:destroy (slot-value this 'surface)))

  (slot-value this 'id))


(defmacro draw-with-image ((image width height) &body body)
  (let ((context (gensym)))
    `(progn
       (unless (slot-value ,image 'surface) 
	 (setf (slot-value ,image 'surface)
	       (cairo:create-image-surface :argb32 ,width ,height)))
       
       (setf (slot-value ,image 'width) ,width)
       (setf (slot-value ,image 'height) ,height)
	      
       (cairo:with-context ((cairo:create-context (slot-value ,image 'surface)))
       ,@body
       (cairo:destroy cairo:*context*)
       (cairo:image-surface-get-data (slot-value ,image 'surface) :pointer-only t))
       ,image)))
 


(defun cairo-surface-clear (&optional (r 1) (g 1) (b 1) (a 0))
  (cairo:save)
  (cairo:set-source-rgba r g b a)
  (cairo:set-operator :source)
  (cairo:paint)
  (cairo:restore))


;; (defun load-dib->image (path)
;;   (let* ((dib    (setf dib (freeimage::get-32bit-dib path)))
;; 	 (width  (freeimage-bindings::freeimage_getwidth dib))
;; 	 (height (freeimage-bindings::freeimage_getheight dib)))
    
;;     (prog1
;; 	(make-instance 'qix::image
;; 		       :surface (cairo:create-image-surface-for-data
;; 				 (freeimage-bindings::freeimage_getbits dib)
;; 				 :argb32
;; 				 width height (* 4 width))
;; 		       :width width
;; 		       :height height)
;;       (freeimage-bindings::freeimage_unload dib))))
	
	
