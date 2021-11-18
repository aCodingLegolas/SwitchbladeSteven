;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname menu) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/abstraction)
(require racket/include)


; IMPORTANT:
;  This file is to be used as reference for the new main.rkt file: this file uses a list for the gs


(define menu_background
  (rectangle 1700 800 "solid" "skyblue"))

; The first element of every list should be a string describing the content of the list
; Registered uses:
; square
; worlds
; levels


;Scratchpad

; To cut down on some of the text, and especially when loading levels from the menu,
;  it could work well to store a function as an element in the level-button-list, which
;  calls a pre-defined abstracted function that grabs the physical level-list from the other file

; Need to come up with a standard format of list element ordering

; Handy-dandy functions:

(define (make_s size style color x y)
  (list "square" (square size style color) x y))

(define (make_r width height style color x y)
  (list "rectangle" (rectangle width height style color) x y))


; Variable Definitions and Constants

; The back-button
(define back_button
  (list "square" (square 20 "solid" "red") 10 10))

; Here are the images and locations for the world-buttons
(define f_world
  (list "square" (square 50 "solid" "lightred") 300 500))
(define b_world
  (list "square" (square 50 "solid" "lightblue") 500 500))
(define j_world
  (list "square" (square 50 "solid" "lightgreen") 700 500))

; The list of world-buttons
(define world_list
  (list "worlds" f_world b_world j_world back_button))

; The images and locations for the level-buttons
(define f_l1
  (list "square" (square 50 "solid" "lightred") 300 500))
(define f_l2
  (list "square" (square 50 "solid" "lightred") 500 500))
(define f_l3
  (list "square" (square 50 "solid" "lightred") 700 500))
(define f_l4
  (list "square" (square 50 "solid" "lightred") 900 500))
(define f_l5
  (list "square" (square 50 "solid" "lightred") 1100 500))

(define f_level_list
  (list "levels" f_l1 f_l2 f_l3 f_l4 f_l5 back_button))

(define b_l1
  (list "square" (square 50 "solid" "lightblue") 300 500))
(define b_l2
  (list "square" (square 50 "solid" "lightblue") 500 500))
(define b_l3
  (list "square" (square 50 "solid" "lightblue") 700 500))
(define b_l4
  (list "square" (square 50 "solid" "lightblue") 900 500))
(define b_l5
  (list "square" (square 50 "solid" "lightblue") 1100 500))

(define b_level_list
  (list "levels" b_l1 b_l2 b_l3 b_l4 b_l5 back_button))

(define j_l1
  (list "square" (square 50 "solid" "lightgreen") 300 500))
(define j_l2
  (list "square" (square 50 "solid" "lightgreen") 500 500))
(define j_l3
  (list "square" (square 50 "solid" "lightgreen") 700 500))
(define j_l4
  (list "square" (square 50 "solid" "lightgreen") 900 500))
(define j_l5
  (list "square" (square 50 "solid" "lightgreen") 1100 500))

(define j_level_list
  (list "levels" j_l1 j_l2 j_l3 j_l4 j_l5 back_button))

; Worlds yeet

(define f_1
  (list
   "play"
   (make_s 30 "solid" "red" 500 580)
   (make_r 5000 20 "solid" "black" 1000 600)))


; Game-Changers:

; List -> List or Boolean
(define (back ms)
  (cond
    [(equal? "worlds" (list-ref ms 0)) '()]
    [(equal? "levels" (list-ref ms 0)) world_list]))

; List Num Num MouseEvent -> List
(define (do_mouse ms x y event)
  (cond
    [(mouse=? "button-down" event) (check_list_for_collision ms x y)]
    [else ms]))
     
; Num Num List -> Boolean
(define (collision? x y target)
  (cond
    [(equal? (first target) "square") ; Checks if the target is a square
     (if (and
          (< (abs (- (list-ref target 2) x)) (/ (image-width (list-ref target 1)) 2))  ; Checks x-collision
          (< (abs (- (list-ref target 3) y)) (/ (image-width (list-ref target 1)) 2))) ; Checks y-collision
         #true #false)])) ; Returns either true or false

; Num Num List -> Boolean
(define (check_list_for_collision a_list x y)
  (cond
    [(equal? "worlds" (list-ref a_list 0))
     (cond
       [(collision? x y (list-ref a_list 1)) f_level_list]
       [(collision? x y (list-ref a_list 2)) b_level_list]
       [(collision? x y (list-ref a_list 3)) j_level_list]
       [(collision? x y (list-ref a_list 4)) (back a_list)]
       [else a_list])]
    [(equal? "levels" (list-ref a_list 0))
     (cond
       [(collision? x y (list-ref a_list 6)) (back a_list)]
       [(collision? x y (list-ref a_list 1)) f_1]
       [else a_list])]
    [else a_list]))


; Render Functions:

; List Image -> Image
(define (render_buttons aList im)
  (if (list? aList)
  (place-image
   (list-ref aList 1) 
   (list-ref aList 2)
   (list-ref aList 3) im)
  (square 60 "solid" "green"))) ; error case


(define (render_better lol)
  (cond
    [(empty? lol) menu_background]
    [else (render_buttons (first (filter list? lol)) (render_better (rest (filter list? lol))))]))
                   

; List -> String
(define (stop ms)
  (empty? ms))

; Main and Big-Bang Functions

; List -> Image
(define (main ms)
  (big-bang ms
    [to-draw render_better]
    [on-mouse do_mouse]
    [stop-when stop]
    [close-on-stop #true]))

(main world_list)