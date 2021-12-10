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
(define-struct ugs [menu world character level objects keyboard tockCounter])
(define-struct character [y yVel temp image imageSelector move?])
(define-struct object [x y image lethal])
(define-struct menuButton [x y image highlighted? return])
(define-struct enemy [x y image vel])
(define-struct keyboard [space left right escape])

; Constants:
;(define BACKGROUND (empty-scene 200 200))
(define charY 200)
(define charX 400)
(define mainB (rectangle 1400 700 "solid" "white"))
(define iceB (bitmap "iceWorld.png"))
(define lavaB (bitmap "lavaWorld.png"))
(define highlightImage (square 120 "solid" "black"))
(define steven (make-character charY 0 0 (list (bitmap "Steven0.png") (bitmap "Steven1.png") (bitmap "Steven2.png") (bitmap "Steven3.png") (bitmap "Steven4.png") (bitmap "Steven5.png") (bitmap "Steven6.png") (bitmap "Steven7.png")) 0 #false))
(define clearBoard (make-keyboard #f #f #f #f))

(define ENEMY1 (make-enemy 1700 300 (circle 50 "solid" "red") 10))
; Physics settings:
(define jumpStrength 5)
(define maxFall 10)
(define gravity 0.1)
(define counter 0)

; Level-Definitions:
; Fritz's world
(define world1.1 (make-ugs #f 1 steven 1
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
(define world1.2 (make-ugs #f 1 steven 2
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
(define world1.3 (make-ugs #f 1 steven 3
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
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
                             clearBoard
                             counter))
; Bergen's world
; World 2.1 is where I'm doing my testing -JB

(define world2.1 (make-ugs #f 2 steven 1
                           (list
                            (make-object 500 500 (rectangle 1000 100 "solid" "green") #f)
                            (make-object 300 400 (rectangle 100 300 "solid" "black") #f)
                            ENEMY1) clearBoard counter))
(define world2.2 (make-ugs #f 2 steven 2
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
(define world2.3 (make-ugs #f 2 steven 3
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
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
                             clearBoard
                             counter))
; June's world
(define world3.1 (make-ugs #f 3 steven 1
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
(define world3.2 (make-ugs #f 3 steven 2
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
(define world3.3 (make-ugs #f 3 steven 3
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter))
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
                             clearBoard
                             counter))
; Main menu
(define mainMenu (make-ugs #t 0 steven 0
                             (list
                              (make-menuButton (* (image-width mainB) 1/4)
                                               (/ (image-height mainB) 2)
                                               (bitmap "iceIcon.png")
                                               #f
                                               world1Menu)
                              (make-menuButton (* (image-width mainB) 1/2)
                                               (/ (image-height mainB) 2)
                                               (bitmap "lavaIcon.png")
                                               #f
                                               world2Menu)
                              (make-menuButton (* (image-width mainB) 3/4)
                                               (/ (image-height mainB) 2)
                                               (square 100 "solid" "green")
                                               #f
                                               world3Menu))
                             clearBoard
                             counter))

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
                         (ugs-keyboard gs)
                         (ugs-tockCounter gs))]
    [else gs]))


;Gamestate -> Boolean
(define (complete-level gs)
  gs)

; Gamestate, Boolean -> Gamestate
; increases the level of the gamestate after a player completes a level
; or calls a function to end the world if the levels are all completed
(define (level-up gs bool)
  gs)

;(define (checkEnemyX en)
 ; (if (and (< (enemy-x en) WIDTH) (> (enemy-x en) 0)) #true #false))

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
  (make-ugs (ugs-menu gs)
            (ugs-world gs)
            (make-character
             (character-y (ugs-character gs))
             (character-yVel (ugs-character gs))
             (character-temp (ugs-character gs))
             (character-image (ugs-character gs))
             (character-imageSelector (ugs-character gs))
             (if (keyboard-right (ugs-keyboard gs)) #true #false))
            (ugs-level gs)
            (ugs-objects gs)
            (make-keyboard
             (if (key=? key " ") value (keyboard-space (ugs-keyboard gs)))
             (if (key=? key "left") value (keyboard-left (ugs-keyboard gs)))
             (if (key=? key "right") value (keyboard-right (ugs-keyboard gs)))
             (if (key=? key "escape") value (keyboard-escape (ugs-keyboard gs))))
            (ugs-tockCounter gs)))

;(or (key=? key "right") (and (key=? key "right") (key=? key " ")))

; Gamestate -> Gamestate --- Exits the world if menu-state == #f, backs up a level in menu-state,
;                             exits the game if were're in the mainMenu
(define (escapeKey gs)
  (if (ugs-menu gs)
      (if (> (ugs-world gs) 0)
          mainMenu
          (make-ugs (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs) '() clearBoard counter))
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
            clearBoard
            counter))

; (define-struct menuButton [x y image return])

; X Y Gamestate -> Boolean --- This checks if a x and y collides with a menuButton
(define (overButton? x y b)
  (and 
   (<  (abs (- x (menuButton-x b))) (/ (image-width (menuButton-image b)) 2))
   (<  (abs (- y (menuButton-y b))) (/ (image-height (menuButton-image b)) 2))))

;(mouse=? "button-down" event)
; Gamestate -> Boolean --- evaluates the conditions for the end of the world (whether the user has won or lost) and returns #t or #f
;(define (endWorld gs)
 ;(cond
  ; [(collision (ugs-character gs) (ugs-objects gs)) #true]
   ;[else #false]))



;-----------------Tock Functions-----------------
; Gamestate -> Gamestate --- moves the world and its objects and its enemies

;----------CHARACTER UPDATE FUNCTIONS--------------

;(define-struct ugs [menu world character level objects keyboard])
; Gamestate -> Gamestate --- this function adds the jumpStrength to the y-value of the character
(define (jump gs)
  (make-ugs (ugs-menu gs) (ugs-world gs)
  (make-character
   (character-y (ugs-character gs))
   (- jumpStrength)
   (character-temp (ugs-character gs))
   (character-image (ugs-character gs))
   (character-imageSelector (ugs-character gs))
   (character-move? (ugs-character gs)))
  (ugs-level gs)
  (ugs-objects gs)
  (ugs-keyboard gs)
  (ugs-tockCounter gs)))

; Animate Tock
; Character -> imageSelector
; Updates and returns the imageSelector of the input dude to determine which image will be rendered for animation

(define (animateCharacter dude cntr)
  (if (character-move? dude)
       (modulo (if (= 1 (modulo cntr 4)) (+ 1 (character-imageSelector dude)) (character-imageSelector dude)) (length (character-image dude)))
       0))

 ;POTENTIAL FIX FOR FAST MOVEMENT 

; Character -> Character --- effects gravity on the world
; CURRENTLY, THIS IS FUNCTIONING AS THE MASTER CHARACTER TOCK...
(define (gravityHappens char cntr)
  (make-character
   (+ (character-y char) (character-yVel char))
   (if (<= (character-yVel char) maxFall) (+ (character-yVel char) gravity) (character-yVel char))
   (character-temp char)
   (character-image char)
   (animateCharacter char cntr)
   (character-move? char)))


;-----------------MASTER TOCKS------------------

(define (tock gs)
  (if (ugs-menu gs) gs  ;Don't move anything if we're in the menu

      ; Here is the collision functionality:
      ;  If the next gs contains collision, then return a modified game-state wherein there is no collision
      (make-ugs (ugs-menu gs)
                (ugs-world gs)
                (place_char_based_on_object_collision gs (gravityHappens (ugs-character gs) (ugs-tockCounter gs)))
                (ugs-level gs)
                (move gs)
                (ugs-keyboard gs)
                (+ 1 (ugs-tockCounter gs))
                )))

; Gamestate -> Gamestate
; This function loops through the list of objects (for now just one), and returns a modified gs if there's collision
(define (place_char_based_on_object_collision gs futureCharY)
  (cond
    [(and
      (>=
       (+
        (character-y futureCharY)
        (/ (image-height (first (character-image (ugs-character gs)))) 2))
       (- (object-y (first (ugs-objects gs))) (/ (image-height (object-image (first (ugs-objects gs)))) 2)))
      (<=
       (abs (- (object-x (first (ugs-objects gs))) charX))
       (/ (image-width (object-image (first (ugs-objects gs)))) 2)))
      (ugs-character gs)]
;(make-character
    ;200 0
    ;(character-temp (ugs-character gs))
    ;(character-image (ugs-character gs))
    ;(character-imageSelector (ugs-character gs))
    ;(character-move? (ugs-character gs)))]
    [else futureCharY]))


; Gamestate -> Gamestate --- moves the world forward
(define (move gs)
  (cond
    [(and (keyboard-right (ugs-keyboard gs)) (not (keyboard-left (ugs-keyboard gs)))) (moveHelper (ugs-character gs) (ugs-objects gs) -)]
    [(and (keyboard-left (ugs-keyboard gs)) (not (keyboard-right (ugs-keyboard gs)))) (moveHelper (ugs-character gs) (ugs-objects gs) +)]
    [else (ugs-objects gs)]))
   

; List-of-Objects -> List-of-Objects --- decreases the x coordinate of each object in the world
(define (moveHelper char loo direction)
  (cond
    [(empty? loo) '()]
    [else (cons (cond
                  [(object? (first loo)) (make-object
                                             (direction (object-x (first loo)) 2)
                                           (object-y (first loo))
                                           (object-image (first loo))
                                           (object-lethal (first loo)))]
                  [(enemy? (first loo)) (cond
                                         [(checkEnemyX (first loo)) (enemyAttack (first loo) char)]
                                         [(enemyMissed? (first loo)) (enemyContinue (first loo))]
                                         [else (make-enemy
                                                (direction (enemy-x (first loo)) 2)
                                                (enemy-y (first loo))
                                                (enemy-image (first loo))
                                                (enemy-vel (first loo)))])]
                  [else loo])
                (moveHelper char (rest loo) direction))]))


; check to see if the enemy has entered the world
(define (checkEnemyX enemy)
  (and (< (enemy-x enemy) (image-width mainB)) (> (enemy-x enemy) (+ 20 charX))))

; if the enemy is on the screen and has not missed, attack the character
(define (enemyAttack enemy char)
  (make-enemy (- (enemy-x enemy) (closeInX enemy))
              (- (enemy-y enemy) (closeInY enemy char))
              (enemy-image enemy)
              (enemy-vel enemy)))

; calculate distance to move on x axis towards the character
(define (closeInX enemy)
  (* (- (enemy-x enemy) charX) .05))


; calculate distance to move on y axis towards the character
(define (closeInY enemy char)
  (* (- (enemy-y enemy) (character-y char)) .05))


; check to see if the enemy is in the world but has missed the character
(define (enemyMissed? enemy)
  (< (enemy-x enemy) (+ 10 charX)))


; enemy continues direction off screen
(define (enemyContinue enemy)
  (make-enemy (- (enemy-x enemy) (fadeOutX enemy))
              (- (enemy-y enemy) (fadeOutY enemy))
              (enemy-image enemy)
              (enemy-vel enemy)))


; calculate distance to move on x axis to move enemy off screen
(define (fadeOutX enemy)
  (* (- (enemy-x enemy) (- 0 (image-width (enemy-image enemy)))) .05))


; calculate distance to move on y axis to move enemy off screen
(define (fadeOutY enemy)
  (* (- (enemy-y enemy) (- (image-height mainB) (image-width (enemy-image enemy)))) .05))



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

;(renderAllObjects looe mainB)
; Gamestate -> Image
; takes a character and renders instructed images
; The directionSelector determines which render takes place: 0 for standing, 1 for front walking, 2 for back walking
; The imageSelector determines which image to render
(define (characterRender gs)
  (place-image (list-ref (character-image (ugs-character gs)) (character-imageSelector (ugs-character gs)))
               charX
               (character-y (ugs-character gs))
               (renderAllObjects (ugs-objects gs) (worldDeterminer (ugs-world gs)))))

; World -> Image
; Takes the current world indicator and returns the appropriate image
(define (worldDeterminer wrld)
  (cond
    [(= wrld 0) mainB]
    [(= wrld 1) iceB]
    [(= wrld 2) lavaB]
    [(= wrld 3) mainB])) ;wrld 3 should be something else once an image is drawn for this world

; Gamestate -> Image --- Renders the entire game-state:
(define (masterRender gs)
  (if (ugs-menu gs) ;Don't render the character in menu-state
      (renderAllObjects (ugs-objects gs) (worldDeterminer (ugs-world gs)))
      (characterRender gs)))

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