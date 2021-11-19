;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname main) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Switchblade Steven
; created by JB, Friedrich, and June

;STRUCTURES

(define-struct ugs [menu world character level objects])
; A ugs is a structure:
;    (make-ugs menu world character level objects)
; interpretation: (make-ugs menu world character level objects)
; represents the complete state of a space invader game


; A Menu is a Boolean:
; interpretation: represents whether the game state is in play mode or menu mode


; A World is a Number:
; interpretation: the world determines the theme and challenges of the game


(define-struct character [y temp img])
; A Character is a structure:
;    (make-character y temp img)                          
; interpretation: (make-character y temp img) specificies the y position, the
; temperature of the character in the ice world, and the associated image


; A Level is a Number:
; interpretation: the Level is the current level that the player has advanced to


; An Objects is a List-of-Objects


(define-struct object [x y image lethal])
; An Object is a structure:
;     (make-object x y image lethal)
; interpretation: (make-object x y image lethal) specifies the x & y coordinates of
; the object, it's associated graphic, and whether or not the object is lethal to
; the character



;FUNCTIONS

;Gamestate -> Boolean
; determines when the character has reached the end of the level
; (define (complete-level gs) bool)
; given ugs..., expect #true
; given ugs..., expect #false
(define (complete-level gs)
  (...gs...bool...))

; Gamestate, Boolean -> Gamestate
; increases the level of the gamestate after a player completes a level
; or calls a function to end the world if the levels are all completed
;(define (level-up gs bool) gs)
; given ugs-level 1, #true, expect ugs-level 2
; given ugs-level 5, #true, expect ugs-level 5
; given ugs-level 1, #false, expect ugs-level 1
(define (level-up gs bool)
  (...gs...))


; Gamestate -> Gamestate
; choose-world


; Character -> Character
; increases the character's y coordinate by 2 pixels
; (define (jump char) char)
; given (character-y 25), expect (character-y 27)
; given (character-yy HEIGHT), expect (character-y HEIGHT)
(define (jump char)
  (if (= (character-y char) HEIGHT)
      char
      (make-character (character-temp char)(+ (character-y char) 2))))


; Gamestate -> Gamestate
; moves the world forward
; (define (forward gs) gs)
; given ugs-objects-x 150, expect ugs-objects-x 148
; given ugs-objects-x 320, expect ugs-objects-x 318
(define (forward gs)
  (...gs...))


; Gamestate -> Gamestate
; moves the world backwards
; (define (rewind gs) gs)
; given ugs-objects-x 150, expect ugs-objects-x 152
; given ugs-objects-x 320, expect ugs-objects-x 322
(define (rewind gs)
  (...gs...))


; Character -> Character
; updates the character image to simulate moving legs
; (define (move-legs char) char)
; given char-img 1, expect char-img 2
; given char-img 4, expect char-img 1
(define (move-legs char)
  (...char...))


; Gamestate -> Gamestate

;collision
;adjust-char
;kill-char
;tock
;master-render
;on-key
;end-world
;on-mouse
;stop-when