(let ((image (make-instance 'qix::image)))

  (qix::draw-with-image (image 500 500)
    (qix::cairo-surface-clear 1 1 1 .5)
    (cairo:move-to 0 0)
    (cairo:set-source-rgba 0 1 0 1)
    (cairo:set-line-width 50)
    (cairo:line-to 500 500)
    (cairo:stroke) 
    
    (cairo:move-to 0 500)
    (cairo:set-source-rgba 0 0 1 .5)
    (cairo:line-to 500 0)
    
    (cairo:stroke))

  (qix::update image)

  (defun qix-sdl:*on-idle* ()
  (sleep 0)
  (gl:front-face :cw)
  (gl:enable :blend :texture-2d :polygon-smooth :line-smooth :depth-test :lighting :color-material :light0 :cull-face)
  (gl:blend-func :src-alpha :one-minus-src-alpha)
  (gl:hint :polygon-smooth-hint  :nicest)
  (%gl:clear-color 0 0 0 0)
  (gl:clear :color-buffer-bit :depth-buffer-bit)
  (gl:load-identity)
  (gl:rotate (* 360 (/ (rem (get-internal-real-time) 10000) 10000))
	     0 0 1)
  (when (qix::image->glbuffer image)
    (qix::draw-image-centered (qix::image->glbuffer image) 1 1 0 0 0))))



(qix-sdl::start-threaded 800 600)