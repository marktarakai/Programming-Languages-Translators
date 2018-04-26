; Mark Tarakai
; CS3500: Programming Languages & Translators
; Homework #6: Red-Black Problem Solution in LISP

; This solution strictly emulates the recursive C++ solution provided
; on Canvas by Dr. Jennifer Leopold.

(defun noRedRow(len) ; accommodates the scenario where there are no red units
    (let* ((row ()))
        (dotimes (i len)
            (setf row
                (cons 'b row)
            )
        )
    row
    )
)

(defun singleRow(row) ; construct single row
    (format t "(~{\\~a~})~%" row)
)

(defun allRows(list) ; put the singly constructed rows together
    (loop for row in list
        do (singleRow row)
    )
)

(defun placeRedBlockUnit (minRedBlockUnitSize redBlockUnitSize rowSize start lastConfiguration)
  (setf config (copy-list lastConfiguration))
  (if (>= rowSize (+ redBlockUnitSize start))
    (progn
     (loop for k from 0 to (- redBlockUnitSize 1) by 1 do
        (progn 
          (setf (nth (+ start k) config) 'r) 
        )
      )
      (setf configurations (cons config configurations))
      (loop for nextUnit from minRedBlockUnitSize to rowSize by 1 do
        (placeRedBlockUnit minRedBlockUnitSize nextUnit rowSize
          (+ start redBlockUnitSize 1)
          config
        )
      )
    )
  )
)

(defun placeRedBlocks(rowSize)
    (setf noRed(noRedRow rowSize))
    (setf minRedBlockUnitSize 3)
    (setf configurations(cons noRed nil))

    (defvar redStart 3)
    (loop for redStart from minRedBlockUnitSize to rowSize by 1 do
        (loop for start from 0 to rowSize by 1 do
            (progn
                (placeRedBlockUnit minRedBlockUnitSize redStart rowSize start noRed)
            )
        )
    )

    (return-from placeRedBlocks configurations)
)