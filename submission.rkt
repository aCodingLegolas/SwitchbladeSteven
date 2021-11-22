;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname submission) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Switchblade Stephen
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


(define-struct character [y temp image])
; A Character is a structure:
;    (make-character y temp image)                          
; interpretation: (make-character y temp image) specificies the y position, the
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


;TEST GAME

(define BACKGROUND (empty-scene 200 200))
(define HEIGHT (image-height BACKGROUND))
(define WIDTH (image-height BACKGROUND))
(define CHARACTER_X (/ (image-width BACKGROUND) 2))
(define lavaCharShape (circle 10 "solid" "orange"))
(define lavaChar (make-character 120 #false lavaCharShape))
(define objImg (circle 10 "solid" "green"))
(define objImg2 (square 10 "solid" "green"))
(define object1 (make-object 50 50 objImg #false))
(define object2 (make-object 150 150 objImg2 #false))
(define enImg1 (circle 12 "solid" "black"))
(define enemy1 (make-enemy 320 20 enImg1 5))
(define testState (make-ugs #false 1 lavaChar 1 (list object1 object2 enemy1)))




;FUNCTIONS

; helper function to make a gamestate
(define (makeGS gs thing)
  (cond
    [(character? thing) (make-ugs
                         (ugs-menu gs)
                         (ugs-world gs)
                         thing
                         (ugs-level gs)
                         (ugs-objects gs))]
    [else gs]))


;Gamestate -> Boolean
; determines when the character has reached the end of the level
; (define (complete-level gs) bool)
; given ugs..., expect #true
; given ugs..., expect #false
(define (complete-level gs)
  gs)

; Gamestate, Boolean -> Gamestate
; increases the level of the gamestate after a player completes a level
; or calls a function to end the world if the levels are all completed
;(define (level-up gs bool) gs)
; given ugs-level 1, #true, expect ugs-level 2
; given ugs-level 5, #true, expect ugs-level 5
; given ugs-level 1, #false, expect ugs-level 1
(define (level-up gs bool)
  gs)


; Mouse-event,Gamestate -> Gamestate
; selects the world theme and character and returns the appropiate gamestate
; (define (choose-world gs x y me) gs)
; given x=150,y=150, "button-down", expect (ugs-world 1)
; given x+200, y=150, "button-down", expect (ugs-world 2)
; given x=250, y=150, "button-down", expect (ugs-world 3)
(define (choose-world gs x y me)
  gs)

;(define testState (make-ugs #false 1 lavaChar 1 (list object1 object2)))
; Gamestate -> Gamestate
; increases the character's y coordinate by 2 pixels
; (define (jump char) char)
; given (character-y 25), expect (character-y 27)
; given (character-yy HEIGHT), expect (character-y HEIGHT)
(define (jump gs)
  (if (= (character-y (ugs-character gs)) HEIGHT)
      gs
      (makeGS gs
         (make-character
          (- (character-y (ugs-character gs)) 2)
          (character-temp (ugs-character gs))
          (character-image (ugs-character gs))))))


; Gamestate -> Gamestate
; moves the world forward
; (define (forward gs) gs)
; given ugs-objects-x 150, expect ugs-objects-x 148
; given ugs-objects-x 320, expect ugs-objects-x 318
(define (forward gs)
  (cond
    [(empty? (ugs-objects gs)) '()]
    [else (make-ugs
            (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs)
            (forwardHelper (ugs-objects gs)))]))


; List-of-Objects -> List-of-Objects
; decreases the x coordinate of each object in the world
; given object-x 3, expect object-x 1
; given object-x 198, expect object-x 196
(define (forwardHelper loo)
  (cond
    [(empty? loo) '()]
    [else (cons (cond
                  [(object? (first loo)) (make-object
                                             (- (object-x (first loo)) 2)
                                           (object-y (first loo))
                                           (object-image (first loo))
                                           (object-lethal (first loo)))]
                  [(enemy? (first loo)) (cond
                                          [(checkEnemyX (first loo)) (first loo)]
                                          [else (make-enemy
                                             (- (enemy-x (first loo)) 2)
                                           (enemy-y (first loo))
                                           (enemy-image (first loo))
                                           (enemy-vel (first loo)))])
                                          ])
                (forwardHelper (rest loo)))]))

(define (checkEnemyX en)
  (if (and (< (enemy-x en) WIDTH) (> (enemy-x en) 0)) #true #false))


      
; Gamestate -> Gamestate
; moves the world backwards
; (define (rewind gs) gs)
; given ugs-objects-x 150, expect ugs-objects-x 152
; given ugs-objects-x 320, expect ugs-objects-x 322
(define (rewind gs)
  gs)


; Character -> Character
; updates the character image to simulate moving legs
; (define (move-legs char) char)
; given char-img 1, expect char-img 2
; given char-img 4, expect char-img 1
(define (move-legs char)
  char)


; Gamestate -> Boolean
; Checks for collision between the character and any given object in the world
; (define (collision char object) char)
; given no-collision, expect #false
; given collision, expect #true
(define (collision char object)
  #false)

;adjust-char
; Gamestate -> Gamestate
; Moves the character ontop of the "floor" if the amount of collision is less than the tolerated amount.
; (define (adjust-char gs char) gs char)
; given acceptable collision, expect character to be popped forward up onto the "floor"
; given unacceptable collision, expect character to be prevented from moving forward
(define (adjust-char gs char)
  gs)

; Gamestate -> Gamestate
; Kills the character if the gamestate is such that the character deserves a slow and painful death
; given no-death-gamestate, return normal game-state
; given death-gamestate, return end-game-state
(define (killChar gs)
  gs)


; Character Gamestate -> Gamestate
; accepts a keystroke (Character) and calls an assigned function
; given " " and character-y 25, expect character-y 35
; given ugs-objects-x 150, expect ugs-objects-x 148
(define (onKey gs key)
 (cond
   [(key=? key " ") (jump gs)]
   [(key=? key "left") (rewind gs)]
   [(key=? key "right") (forward gs)]
   [else gs]))


; Gamestate -> Boolean
; evaluates the conditions for the end of the world (whether the user has won or lost) and returns #t or #f
; given object-x-300 and character-x 300, expect #t
; given object-x-300 and character-x 200, expect #f
(define (endWorld gs)
 (cond
   [(collision (ugs-character gs) (ugs-objects gs)) #true]
   [else #false]))


; Gamestate -> Gamestate
; moves the world and its objects and its enemies
; given ugs-object-x 230, expect ugs-object-x 228
; given ugs-enemy-x 118, ugs-enemy-vel 15, expect ugs-enemy-x 133
; (define (tock gs) gs)
(define (tock gs)
  (moveEnemy gs))

(define (enemyApproach x1 x2)
  (* (- x1 x2) .1))


;signature: NUMBER -> NUMBER
;purpose: calculate the value of x in the next world
;header: (define (... x ...))
; examples: given 10 |--> 24
;template: (define (new_x 10) ...24...)
;test function: see below every function 
(define (moveEnemy gs)
  (make-ugs
   (ugs-menu gs)
   (ugs-world gs)
   (ugs-character gs)
   (ugs-level gs)
   (enemyHelper (filter enemy? (ugs-objects gs)))))

(define (enemyHelper loo)
  (cond
    [(empty? loo) '()]
    [else (cons (make-enemy (- (enemy-x (first loo)) (enemyApproach (enemy-x (first loo)) CHARACTER_X))
                      (enemy-y (first loo))
                      (enemy-image (first loo))
                      (enemy-vel (first loo))) (enemyHelper (rest loo)))]))
  


; List-of-Objects, Image -> Image
; places all the objects in a list on the world background
; (define (renderAllObjects obj image) image)
; given (list obj1 obj2) with x,y of (110,110) (78, 60), expect image with objects at (110,110) (78,60)
; given '(), expect image
(define (renderAllObjects obj image)
  (cond
    [(empty? obj) image]
    [(object? (first obj)) (place-image (object-image (first obj))
               (object-x (first obj)) (object-y (first obj))
               (renderAllObjects (rest obj) image))]
    [(enemy? (first obj)) (place-image (enemy-image (first obj))
               (enemy-x (first obj)) (enemy-y (first obj))
               (renderAllObjects (rest obj) image))]
    [else image]))


; Gamestate -> Image
; Renders the entire game-state:
; given game-state, expect image
(define (masterRender gs)
  (place-image
   (character-image (ugs-character gs))
         CHARACTER_X
         (character-y (ugs-character gs))
             (renderAllObjects (ugs-objects gs) BACKGROUND)))




; Main Big Bang function
(define (main gs)
  (big-bang gs
    [on-tick tock .1]
    [on-key onKey]
    [stop-when endWorld killChar]
    [to-draw masterRender]))

; test the program
(main testState)