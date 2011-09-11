(in-package :FreeImage)
(use-package :freeimage-bindings)

(defun get-32bit-dib (path)
  (let* ((drawing-type (freeimage-bindings::freeimage_getfiletype path 0))
	 (image (freeimage-bindings::freeimage_load drawing-type path 0))
	 (image32 (freeimage-bindings::freeimage_convertto32bits image))
	 (freeimage-bindings::freeimage_unload image))
    image32))

(defun unload-dib (bitmap)
  (freeimage-bindings::freeimage_unload bitmap))
