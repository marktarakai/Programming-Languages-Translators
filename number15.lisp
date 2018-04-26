(defun sum357 (x iter_sum)
    (when (or 
    		(or 
    		(= 0 (mod x 3)) 
    		(= 0 (mod x 5))) 
    		(= 0 (mod x 7)))
        (setq iter_sum (+ iter_sum x))
    )
    (when (<= (+ x 1) 2000)
        (setq iter_sum (sum357 (+ x 1) iter_sum))
    )
    (return-from sum357 iter_sum)
)