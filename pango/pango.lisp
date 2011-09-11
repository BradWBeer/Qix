(in-package :pango)

(defclass layout ()
  ((pointer
    :accessor get-pointer)))

(defmethod initialize-instance :before ((this layout)
					&key cairo-context)

  (setf context (or cairo-context
		    cairo:*context*
		    (error "You need a cairo context for pango to write to!")))

  (setf (get-pointer this)
	(pango-bindings::pango_layout_new
	 (pango-bindings::pango_cairo_create_layout
	  (cairo::get-pointer context)))))

(defmethod free ((this layout) &key)
  (pango-bindings::g_object_unref (get-pointer this)))

  