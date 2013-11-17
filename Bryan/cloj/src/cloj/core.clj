(ns cloj.core)

(defn keywordize [kvp]
  (let [[k v] kvp]
    [(keyword (clojure.string/replace k #"^-+" "")) v]))

(defn parse-args [args]
  (into {} (map keywordize (partition 2 args))))

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))
