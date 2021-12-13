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
(define-struct character [y yVel temp image])
(define-struct object [x y image lethal])
(define-struct menuButton [x y image highlighted? return])
(define-struct enemy [x y image vel])
(define-struct keyboard [space left right escape])

; Constants:
(define charY 200)
(define mainB (rectangle 1400 700 "solid" "white"))
(define highlightImage (square 120 "solid" "black"))
<<<<<<< Updated upstream
(define steven (make-character charY 0 0 (rectangle 20 80 "solid" "brown")))
=======
(define steven (make-character charY 0 0 (bitmap "Steven.png")))
(define fakeSteven (make-character charY 0 0 (rectangle 30 100 "solid" "brown")))
(define (charH gs) (image-height (character-image (ugs-character gs))))
(define (charW gs) (image-width (character-image (ugs-character gs))))
>>>>>>> Stashed changes
(define clearBoard (make-keyboard #f #f #f #f))

; Physics:
(define jumpStrength 7)
(define maxFall 4)
(define gravity 0.2)

; Level-Definitions:
; Fritz's world
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
(define world1Menu (make-ugs #t 1 steven 0
                             (list
                              (make-menuButton (* (image-width mainB) 1/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "red")
                                               #f
                                               world1.1)
                              (make-menuButton (* (image-width mainB) 1/2)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "red")
                                               #f
                                               world1.2)
                              (make-menuButton (* (image-width mainB) 3/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "red")
                                               #f
                                               world1.3))
                             clearBoard))
; Bergen's world
(define world2.1 (make-ugs #f 2 fakeSteven 1
                           (list
<<<<<<< Updated upstream
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 1500 5 "solid" "green") #f)) clearBoard))
=======
                            (make-object 600 670 (rectangle 1000 30 "solid" "black") #f)
                            (make-object 1000 200 (square 100 "solid" "black") #f)
                            (make-object 1600 550 (rectangle 1000 50 "solid" "black") #f)
                            (make-object 2600 400 (rectangle 800 200 "solid" "black") #f)
                            (make-object 3000 6500 (square 100 "solid" "black") #f)
                            ENEMY1) clearBoard counter))
>>>>>>> Stashed changes
(define world2.2 (make-ugs #f 2 steven 2
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world2.3 (make-ugs #f 2 steven 3
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world2Menu (make-ugs #t 2 steven 0
                             (list
                              (make-menuButton (* (image-width mainB) 1/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "blue")
                                               #f
                                               world2.1)
                              (make-menuButton (* (image-width mainB) 1/2)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "blue")
                                               #f
                                               world2.2)
                              (make-menuButton (* (image-width mainB) 3/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "blue")
                                               #f
                                               world2.3))
                             clearBoard))
; June's world
(define world3.1 (make-ugs #f 3 steven 1
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world3.2 (make-ugs #f 3 steven 2
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world3.3 (make-ugs #f 3 steven 3
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard))
(define world3Menu (make-ugs #t 3 steven 0
                             (list
                              (make-menuButton (* (image-width mainB) 1/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "green")
                                               #f
                                               world3.1)
                              (make-menuButton (* (image-width mainB) 1/2)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "green")
                                               #f
                                               world3.2)
                              (make-menuButton (* (image-width mainB) 3/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "green")
                                               #f
                                               world3.3))
                             clearBoard))
; Main menu
(define mainMenu (make-ugs #t 0 steven 0
                             (list
                              (make-menuButton (* (image-width mainB) 1/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "red")
                                               #f
                                               world1Menu)
                              (make-menuButton (* (image-width mainB) 1/2)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "blue")
                                               #f
                                               world2Menu)
                              (make-menuButton (* (image-width mainB) 3/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "green")
                                               #f
                                               world3Menu))
                             clearBoard))


;TEST GAME
(define BACKGROUND (empty-scene 200 200))
(define HEIGHT (image-height BACKGROUND))
(define WIDTH (image-height BACKGROUND))
(define CHARACTER_X (/ (image-width BACKGROUND) 2))
(define lavaCharShape (circle 10 "solid" "orange"))
(define lavaChar (make-character 0 120 #false lavaCharShape))
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
                   clearBoard))




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
;(define (jump gs)
 ; (if (= (character-y (ugs-character gs)) HEIGHT)           !!!! idk maybe delete this
  ;    gs
   ;   (makeGS gs
    ;     (make-character
     ;     (- (character-y (ugs-character gs)) 2)
      ;    (character-temp (ugs-character gs))
       ;   (character-image (ugs-character gs))))))

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

; Character Gamestate Keyevent -> Gamestate --- accepts a keystroke (Character) and updates the keyboard
(define (onKey gs key)
  (cond
    [(key=? key "escape") (escapeKey gs)]
    [(key=? key " ") (jump gs)]
    [else (updateKeyboard gs key #t)]))

; Character Gamestate Keyevent -> Gamestate --- accepts a keystroke (Character) and updates the keyboard
(define (onRelease gs key)
  (updateKeyboard gs key #f))

; Character Gamestate Keyevent Boolean -> Gamestate --- updates the keyboard according to onKey and onRelease
(define (updateKeyboard gs key value)
  (make-ugs (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs) (ugs-objects gs)
            (make-keyboard
              (if (key=? key " ") value (keyboard-space (ugs-keyboard gs)))
              (if (key=? key "left") value (keyboard-left (ugs-keyboard gs)))
              (if (key=? key "right") value (keyboard-right (ugs-keyboard gs)))
              (if (key=? key "escape") value (keyboard-escape (ugs-keyboard gs))))))

; Gamestate -> Gamestate --- Exits the world if menu-state == #f, backs up a level in menu-state,
;                             exists the game if were're in the mainMenu
(define (escapeKey gs)
  (if (ugs-menu gs)
      (if (> (ugs-world gs) 0)
          mainMenu
          (make-ugs (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs) '() clearBoard))
      (cond
        [(equal? (ugs-world gs) 1) world1Menu]
        [(equal? (ugs-world gs) 2) world2Menu]
        [(equal? (ugs-world gs) 3) world3Menu])))

; Onkey-Event Gamestate -> Gamestate --- accepts a mouse-event, the x and y of the event, and a gamestate
;  it only modifies the game-state if we're in menu-state
(define (onMouse gs x y event)
  (if (ugs-menu gs) ; Check for menu-state
      (if (mouse=? "button-down" event)
      (loadWorld gs x y)
      (highlightButton gs x y))
      gs)) ; Return unmodified game-state by default

; Returns the world value of the button
(define (loadWorld gs x y)
  (cond
    [(overButton? x y (first (ugs-objects gs))) (menuButton-return (first (ugs-objects gs)))]
    [(overButton? x y (second (ugs-objects gs))) (menuButton-return (second (ugs-objects gs)))]
    [(overButton? x y (third (ugs-objects gs))) (menuButton-return (third (ugs-objects gs)))]
    [else gs]))

; This returns an updated list depending on collision between on-mouse x&y and the menuButtons
(define (highlightButton gs x y)
  (make-ugs (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs)
      (for/list ([b (ugs-objects gs)])
        (make-menuButton
         (menuButton-x b)
         (menuButton-y b)
         (menuButton-image b)
         (if (overButton? x y b) #t #f)
         (menuButton-return b)))
      clearBoard))

; (define-struct menuButton [x y image return])

; X Y Gamestate -> Boolean --- This checks if a x and y collides with a menuButton
(define (overButton? x y b)
  (and 
   (<  (abs (- x (menuButton-x b))) (/ (image-width (menuButton-image b)) 2))
   (<  (abs (- y (menuButton-y b))) (/ (image-height (menuButton-image b)) 2))))

;(mouse=? "button-down" event)
; Gamestate -> Boolean --- evaluates the conditions for the end of the world (whether the user has won or lost) and returns #t or #f
(define (endWorld gs)
 (cond
   [(collision (ugs-character gs) (ugs-objects gs)) #true]
   [else #false]))


; Tock Functions
; Gamestate -> Gamestate --- moves the world and its objects and its enemies

(define (tock gs)
  (if (ugs-menu gs) gs  ;Don't move anything if we're in the menu
      (make-ugs (ugs-menu gs)
                (ugs-world gs)
<<<<<<< Updated upstream
                (gravityHappens (ugs-character gs))
                (ugs-level gs)
                (move gs)
                (ugs-keyboard gs)
                ))) 
  
=======
                (place_char_based_on_object_collision gs (ugs-objects gs) (gravityHappens (ugs-character gs) (ugs-tockCounter gs)))
                (ugs-level gs)
                (move gs)
                (ugs-keyboard gs)
                (+ 1 (ugs-tockCounter gs))
                )))

; Gamestate -> Gamestate
; This function loops through the list of objects (for now just one), and returns a modified gs if there's collision
(define (place_char_based_on_object_collision gs obs futureCharY)
  (cond
    [(empty? (ugs-objects gs)) #f]
    [(or
      (and
       (>=
        (+
         (character-y futureCharY)
         (/ (image-height (first (character-image (ugs-character gs)))) 2))
        (- (object-y (first obs)) (/ (image-height (object-image (first obs))) 2)))
       (<=
        (abs (- (object-x (first obs)) charX))
        (/ (image-width (object-image (first obs))) 2)))
      (place_char_based_on_object_collision gs (rest obs) futureCharY))
     (ugs-character gs)]
    ;(make-character
    ;200 0
    ;(character-temp (ugs-character gs))
    ;(character-image (ugs-character gs))
    ;(character-imageSelector (ugs-character gs))
    ;(character-move? (ugs-character gs)))]
    [else futureCharY]))

>>>>>>> Stashed changes

; Gamestate -> Gamestate --- moves the world forward
(define (move gs)
  (cond
        [(and (keyboard-right (ugs-keyboard gs)) (not (keyboard-left (ugs-keyboard gs)))) (moveHelper (ugs-objects gs) -)]
        [(and (keyboard-left (ugs-keyboard gs)) (not (keyboard-right (ugs-keyboard gs)))) (moveHelper (ugs-objects gs) +)]
        [else (ugs-objects gs)]))
   

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

;(define-struct ugs [menu world character level objects keyboard])
; Gamestate -> Gamestate --- this function adds the jumpStrength to the y-value of the character
(define (jump gs)
  (make-ugs (ugs-menu gs) (ugs-world gs)
  (make-character
   (character-y (ugs-character gs))
   (- jumpStrength)
   (character-temp (ugs-character gs))
   (character-image (ugs-character gs)))
  (ugs-level gs)
  (ugs-objects gs)
  (ugs-keyboard gs)))

; Gamestate -> Gamestate --- effects gravity on the world
(define (gravityHappens char)
  (make-character
   (+ (character-y char) (character-yVel char))
   (if (<= (character-yVel char) maxFall) (+ (character-yVel char) gravity) (character-yVel char))
   (character-temp char)
   (character-image char)))

; Gamestate -> Gamestate --- checks the list of objects in the world for collision
;                             and returns the new posn of the character



;(define-struct character [y yVel temp image])


; List-of-Objects, Image -> Image --- places all the objects in a list on the world background
(define (renderAllObjects obj image)
  (cond
    [(empty? obj) image]
    [(menuButton? (first obj)) (place-image (if (menuButton-highlighted? (first obj))
                                                (overlay
                                                 (menuButton-image (first obj))
                                                 highlightImage)
                                                (menuButton-image (first obj)))
                                            (menuButton-x (first obj)) (menuButton-y (first obj))
                                            (renderAllObjects (rest obj) image))]
    [(object? (first obj)) (place-image (object-image (first obj))
                                        (object-x (first obj)) (object-y (first obj))
                                        (renderAllObjects (rest obj) image))]
    [(enemy? (first obj)) (place-image (enemy-image (first obj))
                                       (enemy-x (first obj)) (enemy-y (first obj))
                                       (renderAllObjects (rest obj) image))]))


; Gamestate -> Image --- Renders the entire game-state:
(define (masterRender gs)
  (if (ugs-menu gs) ;Don't render the character in menu-state
      (renderAllObjects (ugs-objects gs) mainB)
      (place-image
       (character-image (ugs-character gs))
       CHARACTER_X
       (character-y (ugs-character gs))
       (renderAllObjects (ugs-objects gs) mainB))))

(define (stop gs)
  (empty? (ugs-objects gs)))

; Main Big Bang function
(define (main gs)
  (big-bang gs
    [on-tick tock .01]
    [on-key onKey]
    [on-release onRelease]
    [on-mouse onMouse]
    [stop-when stop]
    [close-on-stop #true]
    [to-draw masterRender]))

; test the program
(main mainMenu)