(ns cloj.projects.p1)


(defn multiple-of
  ([n first & rest]
     (multiple-of n (cons first rest)))
  ([n xs]
     (loop [xs xs]
       (if (empty? xs)
         false
         (if (= (mod n (first xs)) 0)
           true
           (recur (rest xs)))))))

(defn main []
  (reduce + (remove  #(not (multiple-of % 3 5)) (range 1 1000))))
