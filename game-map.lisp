(in-package #:cl-rltut)

(defclass tile ()
  ((blocked :initarg :blocked
	    :accessor tile/blocked
	    :initform nil)
   (block-sight :initarg :block-sight
		:accessor tile/block-sight
		:initform nil)))

(defmethod initialize-instance :after ((tile tile) &rest initargs)
  (declare (ignore initargs))
  (with-slots (blocked block-sight) tile
    (when (null block-sight)
      (setf block-sight blocked))))

(defclass game-map ()
  ((width :initarg :w :accessor game-map/w)
   (height :initarg :h :accessor game-map/h)
   (tiles :accessor game-map/tiles)))

(defmethod initialize-instance :after ((map game-map) &rest initargs)
  (declare (ignore initargs))
  (setf (game-map/tiles map)
	(make-array (list (game-map/w map)
			  (game-map/h map)))))

(defparameter *map-data*
  (list (list 30 22 t t)
	(list 31 22 t t)
	(list 32 22 t t)))
  
(defmethod initialize-tiles ((map game-map))
  (dotimes (y (game-map/h map))
    (dotimes (x (game-map/w map))
      (setf (aref (game-map/tiles map) x y) (make-instance 'tile))))

  (loop
     for (x y blocked block-sight) in *map-data*
     :do
       (setf (tile/blocked (aref (game-map/tiles map) x y)) blocked
	     (tile/block-sight (aref (game-map/tiles map) x y)) block-sight)))


(defmethod blocked-p ((map game-map) x y)
  (tile/blocked (aref (game-map/tiles map) x y)))
	     
       



		    




