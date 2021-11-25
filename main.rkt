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

; Structures:
(define-struct ugs [menu world character level objects keyboard])
(define-struct character [y temp image])
(define-struct object [x y image lethal])
(define-struct menuButton [x y image return])
(define-struct enemy [x y image vel])
(define-struct keyboard [space left right escape])

; Constants:
(define charY 200)
(define mainB
  (rectangle 1400 700 "solid" "lightgreen"))
(define steven (make-character charY 0 (rectangle 20 80 "solid" "brown")))
(define clearBoard (make-keyboard #f #f #f #f))

; Level-Definitions: 
(define world1.1 (make-ugs #f 1 steven 1
  (list
   (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
   (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world1.2 (make-ugs #f 1 steven 2
  (list
   (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
   (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world1.3 (make-ugs #f 1 steven 3
  (list
   (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
   (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world1.4 (make-ugs #f 1 steven 4
  (list
   (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
   (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world1.5 (make-ugs #f 1 steven 5
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world1Menu (make-ugs #t 1 steven 0
                             (list
                              (make-menuButton (* (image-width mainB) 1/6)
                                               (/ (image-width mainB) 2)
                                               (square 40 "solid" "red")
                                               world1.1)
                              (make-menuButton (* (image-width mainB) 1/3)
                                               (/ (image-width mainB) 2)
                                               (square 40 "solid" "red")
                                               world1.2)
                              (make-menuButton (* (image-width mainB) 1/2)
                                               (/ (image-width mainB) 2)
                                               (square 40 "solid" "red")
                                               world1.3)
                              (make-menuButton (* (image-width mainB) 2/3)
                                               (/ (image-width mainB) 2)
                                               (square 40 "solid" "red")
                                               world1.4)
                              (make-menuButton (* (image-width mainB) 5/6)
                                               (/ (image-width mainB) 2)
                                               (square 40 "solid" "red")
                                               world1.5))
                             clearBoard))


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

(define (checkEnemyX en)
  (if (and (< (enemy-x en) WIDTH) (> (enemy-x en) 0)) #true #false))
      
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


; Tock Functions
; Gamestate -> Gamestate --- moves the world and its objects and its enemies
(define (tock gs)
  (if (ugs-menu gs) gs  ;Don't move anything if we're in the menu
  (cond
    [(and (keyboard-right (ugs-keyboard gs)) (not (keyboard-left (ugs-keyboard gs)))) (move gs -)]
    [(and (keyboard-left (ugs-keyboard gs)) (not (keyboard-right (ugs-keyboard gs)))) (move gs +)]
    [else gs])))

; Gamestate -> Gamestate --- moves the world forward
(define (move gs direction)
  (cond
    [(empty? (ugs-objects gs)) '()]
    [else (make-ugs
            (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs)
            (moveHelper (ugs-objects gs) direction) (ugs-keyboard gs))]))

; List-of-Objects -> List-of-Objects --- decreases the x coordinate of each object in the world
(define (moveHelper loo direction)
  (cond
    [(empty? loo) '()]
    [else (cons (cond
                  [(object? (first loo)) (make-object
                                             (direction (object-x (first loo)) 2)
                                           (object-y (first loo))
                                           (object-image (first loo))
                                           (object-lethal (first loo)))]
                  [(enemy? (first loo)) (cond
                                          [(checkEnemyX (first loo)) (first loo)]
                                          [else (make-enemy
                                                 (direction (enemy-x (first loo)) 2)
                                                 (enemy-y (first loo))
                                                 (enemy-image (first loo))
                                                 (enemy-vel (first loo)))])]
                  [else loo])
                (moveHelper (rest loo) direction))]))


; List-of-Objects, Image -> Image --- places all the objects in a list on the world background
(define (renderAllObjects obj image)
  (cond
    [(empty? obj) image]
    [(menuButton? (first obj)) (place-image (menuButton-image (first obj))
               (menuButton-x (first obj)) (menuButton-y (first obj))
               (renderAllObjects (rest obj) image))]
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
    [on-tick tock .01]
    [on-key onKey]
    [on-release onRelease]
    [stop-when endWorld killChar]
    [to-draw masterRender]))

; test the program
(main world1Menu)