(import srfi-4
	x11-colors
	stb-image-write
	(chicken process-context)
	(chicken string))

(define width 100)
(define height width)
(define bytes/color 4)

(for-each (lambda (x)
	    (let ((color (hex-string->color x)))
	      (when color
		(with-output-to-file (conc (substring x 1) ".png")
		  (lambda ()
		    (write-png
		     (u32vector->blob
		      (make-u32vector (* width height)
				      (+ (vector-ref color 0)
					 (* #x100 (vector-ref color 1))
					 (* #x10000 (vector-ref color 2))
					 (* #x1000000 #xff))))
		     width
		     height
		     bytes/color))))))
	  (command-line-arguments))

