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

(deffacts users
    (user (name "User 1") (interest "Mystery"))
    (user (name "User 2") (interest "Science Fiction"))
    ; Add more user facts here
)

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
