(ns cloj.projects.p2)

(defn crawler [n]
  (loop
      [a 0
       b 1
       acc '()]
    (if (>= a n)
      acc
      (recur b (+ b a) (cons a acc)))))

(defn main []
  (reduce + (remove odd? (crawler 4000000))))
