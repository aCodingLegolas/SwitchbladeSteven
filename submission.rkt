;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname submission) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Switchblade Steven
; created by JB, Friedrich, and June

;Project requirements:
;   1. Same as last submission
;   2. See below
;   3. Same as last submission

; The required packages:
(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/abstraction)


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


; An Objects is a List-of-Objects-and-Enemies


(define-struct object [x y image lethal])
; An Object is a structure:
;     (make-object x y image lethal)
; interpretation: (make-object x y image lethal) specifies the x & y coordinates of
; the object, it's associated graphic, and whether or not the object is lethal to
; the character

(define-struct enemy [x y image vel])
; An Enemy is a structure:
;     (make-enemy x y image vel)
; interpretation: (make-enemy x y image vel) specifies the x & y coordinates of
; the object, its associated graphic, and its velocity


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


; Mouse-event,Gamestate -> Gamestate
; selects the world theme and character and returns the appropiate gamestate
; (define (choose-world gs x y me) gs)
; given x=150,y=150, "button-down", expect (ugs-world 1)
; given x+200, y=150, "button-down", expect (ugs-world 2)
; given x=250, y=150, "button-down", expect (ugs-world 3)
(define (choose-world gs x y me)
  (...gs...))


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
; moves the world and its objects and its enemies
; according to their velocity
; given ugs-object-x 230, expect ugs-object-x 228
; given ugs-enemy-x 118, ugs-enemy-vel 15, expect ugs-enemy-x 133
; (define (tock gs) gs)
(define (tock gs)
  (...gs...))

; Gamestate -> Boolean
; Checks for collision between the character and any given object in the world
; (define (collision char object) char)
; given no-collision, expect #false
; given collision, expect #true
(define (collision char object)
  (...char...))

;adjust-char
; Gamestate -> Gamestate
; Moves the character ontop of the "floor" if the amount of collision is less than the tolerated amount.
; (define (adjust-char gs char) gs char)
; given acceptable collision, expect character to be popped forward up onto the "floor"
; given unacceptable collision, expect character to be prevented from moving forward
(define (adjust-char gs char)
  (...gs...char...))

; Gamestate -> Gamestate
; Kills the character if the gamestate is such that the character deserves a slow and painful death
; given no-death-gamestate, return normal game-state
; given death-gamestate, return end-game-state
(define (kill-char char gs object)
  (...char...))

; Gamestate -> Image
; Renders the entire game-state:
; given game-state, expect image
(define (master_render game-struct)
  (place-image
   (character-image (ugs-character game-struct))
   CHARACTER_X
   (character-y (ugs-character game-struct))
   (render_all_objects (ugs-objects game-struct))))


; Character Gamestate -> Gamestate
; accepts a keystroke (Character) and calls an assigned function
; given " " and character-y 25, expect character-y 35
; given ugs-objects-x 150, expect ugs-objects-x 148
(define (on_key a_key gs)
 (...gs...))


; Gamestate -> Boolean
; evaluates the conditions for the end of the world (whether the user has won or lost) and returns #t or #f
; given object-x-300 and character-x 300, expect #t
; given object-x-300 and character-x 200, expect #f
(define (end_world)
 (...Boolean...))
