;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct ugs [menu world character level objects])
; A ugs is a structure:
;    (make-ugs menu world character level objects)
; interpretation: (make-ugs menu world character level objects)
; represents the complete state of a space invader game


; A Menu is a Boolean:
; interpretation: represents whether the game state is in play mode or menu mode


; A World is a Number:
; interpretation: the world determines the theme and challenges of the game


(define-struct character [attributes])
; A Character is a structure:
;    (make-character attributes)                          ;need to decide what the attributes are
; interpretation: (make-character attributes) specificies the attributes of the character


; A Level is a Number:
; interpretation: the Level is the current level that the player has advanced to


; An Objects is a List-of-Objects
(define-struct object [attributes])                   ;need to decide what the attributes are
; An Object is a structure:
;     (make-object attributes)
; interpretation: (make-object attributes) specifies the attributes of the object