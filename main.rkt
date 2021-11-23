;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname main) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define mainMenuBackground
  (rectangle 1700 800 "solid" "skyblue"))

;STRUCTURES

(define-struct ugs [menu world character level objects keyboard])
(define-struct character [y temp image])
(define-struct object [x y image lethal])
(define-struct enemy [x y image vel])
(define-struct keyboard [space left right escape])

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
(define testState (make-ugs
                   #false
                   1
                   lavaChar
                   1
                   (list object1 object2 enemy1)
                   (make-keyboard #f #f #f #f)))




;FUNCTIONS

; helper function to make a gamestate
(define (makeGS gs thing)
  (cond
    [(character? thing) (make-ugs
                         (ugs-menu gs)
                         (ugs-world gs)
                         thing
                         (ugs-level gs)
                         (ugs-objects gs)
                         (ugs-keyboard gs))]
    [else gs]))


;Gamestate -> Boolean
(define (complete-level gs)
  gs)

; Gamestate, Boolean -> Gamestate
; increases the level of the gamestate after a player completes a level
; or calls a function to end the world if the levels are all completed
(define (level-up gs bool)
  gs)

; Mouse-event,Gamestate -> Gamestate
; selects the world theme and character and returns the appropiate gamestate
(define (choose-world gs x y me)
  gs)

; Gamestate -> Gamestate
(define (jump gs)
  (if (= (character-y (ugs-character gs)) HEIGHT)
      gs
      (makeGS gs
         (make-character
          (- (character-y (ugs-character gs)) 2)
          (character-temp (ugs-character gs))
          (character-image (ugs-character gs))))))


; Gamestate -> Gamestate --- moves the world forward
(define (forward gs)
  (cond
    [(empty? (ugs-objects gs)) '()]
    [else (make-ugs
            (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs)
            (forwardHelper (ugs-objects gs)) (ugs-keyboard gs))]))


; List-of-Objects -> List-of-Objects
; decreases the x coordinate of each object in the world

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
      
; Gamestate -> Gamestate --- moves the world backwards
(define (rewind gs)
  gs)

; Character -> Character --- updates the character image to simulate moving legs
(define (move-legs char)
  char)


; Gamestate -> Boolean --- Checks for collision between the character and any given object in the world
(define (collision char object)
  #false)

;adjust-char
; Gamestate -> Gamestate
; Moves the character ontop of the "floor" if the amount of collision is less than the tolerated amount.
; (define (adjust-char gs char) gs char)
(define (adjust-char gs char)
  gs)

; Gamestate -> Gamestate --- Kills the character if the gamestate is such that the character deserves a slow and painful death
(define (killChar gs)
  gs)

; Character Gamestate -> Gamestate --- accepts a keystroke (Character) and updates the keyboard
(define (onKey gs key)
  (make-ugs (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs) (ugs-objects gs)
            (make-keyboard
              (if (key=? key " ") #t (keyboard-space (ugs-keyboard gs)))
              (if (key=? key "left") #t (keyboard-left (ugs-keyboard gs)))
              (if (key=? key "right") #t (keyboard-right (ugs-keyboard gs)))
              (if (key=? key "escape") #t (keyboard-escape (ugs-keyboard gs))))))

; Character Gamestate -> Gamestate --- accepts a keystroke (Character) and updates the keyboard
(define (onRelease gs key)
  (make-ugs (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs) (ugs-objects gs)
            (make-keyboard
              (if (key=? key " ") #f (keyboard-space (ugs-keyboard gs)))
              (if (key=? key "left") #f (keyboard-left (ugs-keyboard gs)))
              (if (key=? key "right") #f (keyboard-right (ugs-keyboard gs)))
              (if (key=? key "escape") #f (keyboard-escape (ugs-keyboard gs))))))

; Gamestate -> Boolean --- evaluates the conditions for the end of the world (whether the user has won or lost) and returns #t or #f
(define (endWorld gs)
 (cond
   [(collision (ugs-character gs) (ugs-objects gs)) #true]
   [else #false]))

; Gamestate -> Gamestate --- moves the world and its objects and its enemies
(define (tock gs)
  (if (keyboard-right (ugs-keyboard gs)) ; Checks is the right arrow is pressed
      (forward gs)
      gs))

; List-of-Objects, Image -> Image --- places all the objects in a list on the world background
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


; Gamestate -> Image --- Renders the entire game-state:
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
    [on-release onRelease]
    [stop-when endWorld killChar]
    [to-draw masterRender]))

; test the program
(main testState)