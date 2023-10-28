(deftemplate user
   (slot name)
   (slot interest)
)

(deftemplate book
   (slot title)
   (slot genre)
   (slot author)
)

(deffacts books
    (book (title "Book 1") (genre "Mystery") (author "Author 1"))
    (book (title "Book 2") (genre "Science Fiction") (author "Author 2"))
    ; Add more book facts here
)

(deffunction assert-books-from-csv (?csv-file)
   (open ?csv-file "r")
   (loop 
      (bind ?line (readline))
      (if (eq ?line EOF)
         then (return)
         else
            (bind ?fields (str-explode ?line ","))
            (if (= (length$ ?fields) 3)
               then
                  (assert (book (title (nth$ 1 ?fields)) (genre (nth$ 2 ?fields)) (author (nth$ 3 ?fields))))
            )
      )
   )
   (close ?csv-file)
)

(assert-books-from-csv "books.csv")

(deffacts users
    (user (name "User 1") (interest "Mystery"))
    (user (name "User 2") (interest "Science Fiction"))
    ; Add more user facts here
)

(deffunction assert-users-from-csv (?csv-file)
   (open ?csv-file "r")
   (loop 
      (bind ?line (readline))
      (if (eq ?line EOF)
         then (return)
         else
            (bind ?fields (str-explode ?line ","))
            (if (= (length$ ?fields) 2)
               then
                  (assert (user (name (nth$ 1 ?fields)) (interest (nth$ 2 ?fields))))
            )
      )
   )
   (close ?csv-file)
)

(assert-users-from-csv "users.csv")

(defrule recommend-book
    (user (name ?user) (interest ?interest))
    (book (title ?title) (genre ?genre))
    (test (eq ?interest ?genre))
    =>
    (printout t ?user " might enjoy reading " ?title crlf)
)

; Add more rules to make recommendations based on different criteria

(reset)
(run)

(assert (user (name "User 1") (interest "Mystery")))
(run)

