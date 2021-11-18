;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname main) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;end-level
;level-up
;choose-world
;jump
;forward
;rewind
;move-legs
;collision
;adjust-char
;kill-char
;tock
;master-render
;on-key
;end-world
;on-mouse
;stop-when

; The required packages:
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/abstraction)

; Constants:
(define menu_background
  (rectangle 1700 800 "solid" "skyblue"))

; The structures used:
(define-struct ugs [menu world character level objects])
(define-struct character [y temp])
(define-struct object [x y image lethal])

; Lists of objects that represents levels, both in both menu and play-state:
(define m_menu
  (list
   (make-object 300 400 (square 80 "solid" "red") #false)
   (make-object 600 100 (square 50 "solid" "red") #false)
   (make-object 200 200 (square 20 "solid" "red") #false)))

; Renders an object-struct:
(define (render_object ob im)
  (place-image (object-image ob) (object-x ob) (object-y ob) im))

; Renders the list of objects
(define (render_all_objects loo)
  (cond
    [(empty? loo) menu_background]
    [else (render_object (first loo) (render_all_objects (rest loo)))]))




; The start-state:
(define start_state
  (make-ugs #true 0 (make-character 300 1) 0 m_menu))

(render_all_objects (ugs-objects start_state))