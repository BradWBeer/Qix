(defsystem qix
  :depends-on (cffi bordeaux-threads cl-opengl cl-cairo2 cl-glu cl-glut lispbuilder-sdl lispbuilder-sdl-mixer)
  :components
  ((:module "pango"
	    :components
	    ((:file "bindings-package")
	     (:file "bindings" :depends-on ("bindings-package"))
	     (:file "pango-package" :depends-on ("bindings"))
	     (:file "pango" :depends-on ("pango-package"))))
   
   (:module "FreeImage"
	    :components
	    ((:file "bindings-package")
	     (:file "bindings" :depends-on ("bindings-package"))
	     (:file "package" :depends-on ("bindings"))
	     (:file "FreeImage" :depends-on ("package"))))


   (:module "sdl"
	    :components
	    ((:file "package")
	     (:file "sdl" :depends-on ("package"))))

   (:module "buffer"
	    :components
	    ((:file "package")
	     (:file "buffer" :depends-on ("package"))))

   (:module "glue"
	    :components
	    ((:file "package")
	     (:file "glue" :depends-on ("package"))))

   (:module "qix"
	    :components
	    ((:file "package")
	     (:file "buffer" :depends-on ("package"))
	     (:file "bitmap" :depends-on ("buffer"))
	     (:file "qix" :depends-on ("bitmap"))))))



;; (:file "constants" :depends-on ("bindings-package"))
;; (:file "library" :depends-on ("bindings-package"))
;; (:file "bindings" :depends-on ("bindings-package" "constants" "library"))
     ;; (:file "types" :depends-on ("bindings-package"))
     ;; (:file "funcs" :depends-on ("bindings" "constants" "library" "types"))
     ;; ;; Lispifications.
     ;; (:file "package" :depends-on ("bindings-package"))
     ;; (:file "util" :depends-on ("constants" "types" "package"))
     ;; (:file "opengl" :depends-on ("funcs" "util"))
     ;; (:file "rasterization" :depends-on ("funcs" "util"))
     ;; (:file "framebuffer" :depends-on ("funcs" "util"))
     ;; (:file "special" :depends-on ("funcs" "util" "constants"))
     ;; (:file "state" :depends-on ("funcs" "util"))
     ;; (:file "extensions" :depends-on ("funcs" "util"))))))
