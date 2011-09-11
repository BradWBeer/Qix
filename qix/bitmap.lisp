(defclass bitmap () 
  ((surface
    :initform nil)
   (context
    :initform nil)
   (id
    :initform nil
    :reader id)
   (size
    :initform 0
    :initarg :size
    :reader size)
   (data-type
    :initform :float
    :initarg :data-type
    :reader data-type)
   (target 
    :initform :array-buffer
    :initarg :target
    :reader target)
   (number-of-fields
    :initform 3
    :initarg :number-of-fields
    :accessor number-of-fields)
   (usage 
    :initarg :usage
    :initform :stream-copy
    :accessor usage)
   (buffer 
    :initform nil
    :reader buffer)))


(defmethod initialize-instance :after ((this bitmap) &key (data nil))
  (when data
    (set-data this data)))

(defmethod release-id ((this bitmap))
  (when (id this)
    (gl:delete-buffers (list (id this)))))

(defmethod get-id ((this bitmap))
  (if (id this)
      (gl:delete-buffers (list (id this))))
  (setf (slot-value this 'id)
	(car (gl:gen-buffers 1))))

(defmethod bind ((this bitmap))
  (if (not (id this))
      (get-id this))
  (%gl:bind-buffer (target this) (id this)))

; you don't really need this but....
(defmethod un-bind ((this bitmap))
  (%gl:bind-buffer (target this) (cffi:null-pointer)))


(defmethod set-data ((this bitmap) data &key (number-of-fields nil) (size nil) (data-type nil) (usage nil))
  (if size
      	(setf (slot-value this 'size) size)
	(setf size
	      (setf (slot-value this 'size) 
		    (length data))))

  (if data-type (setf (slot-value this 'data-type) data-type))
  (if (null (data-type this)) 
      (error "Please give this buffer a data-type!"))
  (if number-of-fields (setf (number-of-fields this) number-of-fields))
  (if (null (number-of-fields this)) 
      (error "Please give this buffer an number-of-fields!"))
  (if usage (setf (usage this) usage))
  (if (null (usage this)) 
      (error "Please give this buffer a usage!"))

  (bind this)
  (cffi:with-foreign-object (d (data-type this) (size this))
    (loop for i from 0
	 for index in data
	 do (setf (cffi:mem-aref d (data-type this) i) index))

    (%gl:buffer-data (target this) (* (size this) (cffi:foreign-type-size (data-type this))) d (usage this))))


(defmethod map-buffer ((this bitmap) &key (access :read-write))
  (bind this)
  (setf (slot-value this 'buffer)
	(%gl:map-buffer (target this) :read-write)))


(defmethod unmap-buffer ((this bitmap))
  (setf (slot-value this 'buffer)
	(%gl:unmap-buffer (target this))))	

(defmethod set-vertex-pointer ((this bitmap))
  (gl:enable-client-state :vertex-array)
  (bind this)
  (%gl:vertex-pointer (number-of-fields this)
		      (gl::cffi-type-to-gl (data-type this))
		      0
		      (cffi-sys:null-pointer)))

(defmethod set-normal-pointer ((this bitmap))
  (gl:enable-client-state :normal-array)
  (bind this)
  (%gl:normal-pointer (gl::cffi-type-to-gl (data-type this))
		      0
		      (cffi-sys:null-pointer)))

(defmethod set-color-pointer ((this bitmap))
  (gl:enable-client-state :color-array)
  (bind this)
  (%gl:color-pointer (number-of-fields this)
		     (gl::cffi-type-to-gl (data-type this))
		     0
		     (cffi-sys:null-pointer)))


(defmethod set-secondary-color-pointer ((this bitmap))
  (gl:enable-client-state :secondary-color-array)
  (bind this)
  (%gl:secondary-color-pointer (number-of-fields this)
			       (gl::cffi-type-to-gl (data-type this))
			       0
			       (cffi-sys:null-pointer)))


(defmethod set-edge-pointer ((this bitmap))
  (gl:enable-client-state :edge-flag-array)
  (bind this)
  (%gl:edge-flag-pointer 0 (cffi-sys:null-pointer)))

(defmethod set-tex-pointer ((this bitmap))
  (gl:enable-client-state :texture-coord-array)
  (bind this)
  (%gl:tex-coord-pointer (number-of-fields this)
			 (gl::cffi-type-to-gl (data-type this))
			 0
			 (cffi-sys:null-pointer)))

(defmethod set-fog-coordinate-pointer ((this bitmap))
  (gl:enable-client-state :fog-coordinate-array)
  (bind this)
  (%gl:fog-coord-pointer (gl::cffi-type-to-gl (data-type this))
			 0
			 (cffi-sys:null-pointer)))

(defmacro with-mapped-buffer (buffer var &rest body) 
  `(unwind-protect (let ((,var (map-buffer ,buffer)))
		     ,@body)
     (unmap-buffer ,buffer)))


