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
(define-struct ugs [menu world character level objects keyboard tockCounter score])
(define-struct character [y yVel jumps temp image imageSelector moveDirection])
(define-struct object [x y image lethal])
(define-struct prize [x y image points])
(define-struct menuButton [x y image highlighted? return])
(define-struct enemy [x y image vel])
(define-struct keyboard [space left right escape])


; Constants:
;(define BACKGROUND (empty-scene 200 200))
(define charY 200)
(define charX 400)
(define endLevelX -2700)
(define mainB (rectangle 1400 700 "solid" "white"))
(define iceB (bitmap "iceWorld.png"))
(define lavaB (bitmap "lavaWorld.png"))
(define volcanoColor (make-color 18 18 18))
(define highlightImage (square 120 "solid" "black"))
(define stevenImages (list (bitmap "Steven0.png")
                           (bitmap "Steven1.png")
                           (bitmap "Steven2.png")
                           (bitmap "Steven3.png")
                           (bitmap "Steven4.png")
                           (bitmap "Steven5.png")
                           (bitmap "Steven6.png")
                           (bitmap "Steven7.png")))
(define backwardSteven (for/list([im stevenImages]) (flip-horizontal im)))
(define steven (make-character charY 0 2 0 stevenImages 0 #false))
(define animationSpeed 3) ; Bigger numbers mean slower animation speed
(define clearBoard (make-keyboard #f #f #f #f))
(define bottom (- (image-height mainB) (/ (image-height (list-ref stevenImages 1)) 2)))


; Physics settings:
(define jumpStrength 5)
(define maxFall 10)
(define gravity 0.1)
(define counter 0)
(define score 0)

; Level-Definitions:
; Fritz's world
(define world1.1 (make-ugs #f 1 steven 1
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter score))
(define world1.2 (make-ugs #f 1 steven 2
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter score))
(define world1.3 (make-ugs #f 1 steven 3
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter score))
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
                             counter
                             score))
; Bergen's world
(define world2.1 (make-ugs #f 2 steven 1
                           (list
                            (make-object 600 650 (rectangle 1000 100 "solid" volcanoColor) #f)
                            
                            (make-object 1600 600 (rectangle 800 400 "solid" volcanoColor) #f)
                            (make-object 2600 400 (rectangle 800 200 "solid" volcanoColor) #f)
                            (make-object 3000 6500 (square 100 "solid" volcanoColor) #f)
                            
                            ) clearBoard counter score))
(define world2.2 (make-ugs #f 2 steven 2
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter score))
(define world2.3 (make-ugs #f 2 steven 3
                           (list
                            (make-object 300 400 (rectangle 100 30 "solid" "black") #f)
                            (make-object 500 500 (rectangle 600 5 "solid" "green") #f)) clearBoard counter score))
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
                             counter
                             score))
; June's world


(define world3.1 (make-ugs #f 3 steven 1
                           (list
                            ;floor
                            (make-object 500 500 (rectangle 1000 5 "solid" "green") #f)
                            (make-object 1500 400 (rectangle 1000 5 "solid" "green") #f)
                            (make-object 2500 600 (rectangle 1000 5 "solid" "green") #f)
                            (make-object 3500 400 (rectangle 1000 5 "solid" "green") #f)
                            ;icicles
                            (make-object 600 400 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 700 400 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 900 400 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 1600 300 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 1800 300 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 2000 300 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 2300 500 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 2500 500 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 3200 300 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 3500 300 (rectangle 5 200 "solid" "gray") #t)
                            ;snowmen
                            (make-prize 900 100 (ellipse 30 80 "solid" "pink") 20)
                            (make-prize 1300 75 (ellipse 30 80 "solid" "pink") 20)
                            (make-prize 1800 35 (ellipse 20 60 "solid" "pink") 30)
                            ) clearBoard counter score))

(define world3.2 (make-ugs #f 3 steven 2
                           (list
                            ;floor
                            (make-object 400 500 (rectangle 600 5 "solid" "green") #f)
                            (make-object 1400 400 (rectangle 1000 5 "solid" "green") #f)
                            (make-object 2500 600 (rectangle 500 5 "solid" "green") #f)
                            (make-object 3400 700 (rectangle 1000 5 "solid" "green") #f)
                            ;icicles
                            (make-object 500 390 (rectangle 5 220 "solid" "gray") #t)
                            (make-object 1100 290 (rectangle 5 220 "solid" "gray") #t)
                            (make-object 1600 290 (rectangle 5 220 "solid" "gray") #t)
                            (make-object 1800 290 (rectangle 5 220 "solid" "gray") #t)
                            (make-object 2400 490 (rectangle 5 220 "solid" "gray") #t)
                            (make-object 2500 490 (rectangle 5 220 "solid" "gray") #t)
                            (make-object 3200 600 (rectangle 5 220 "solid" "gray") #t)
                            (make-object 3500 600 (rectangle 5 220 "solid" "gray") #t)
                            ;snowmen
                            (make-prize 700 100 (ellipse 30 80 "solid" "pink") 20)
                            (make-prize 1300 50 (ellipse 30 80 "solid" "pink") 20)
                            (make-prize 1900 125 (ellipse 40 100 "solid" "pink") 10)
                            (make-prize 2300 100 (ellipse 40 100 "solid" "pink") 30)
                            ;avalanche
                            (make-enemy 600 -60 (circle 50 "solid" "black") 5)
                            (make-enemy 3050 -60 (circle 50 "solid" "black") 12)
                            ) clearBoard counter score))

(define world3.3 (make-ugs #f 3 steven 3
                           (list
                            ;floor
                            (make-object 500 500 (rectangle 300 5 "solid" "green") #f)
                            (make-object 900 400 (rectangle 300 5 "solid" "green") #f)
                            (make-object 1700 600 (rectangle 1000 5 "solid" "green") #f)
                            (make-object 2300 400 (rectangle 200 5 "solid" "green") #f)
                            (make-object 2700 400 (rectangle 200 5 "solid" "green") #f)
                            (make-object 3100 400 (rectangle 600 5 "solid" "green") #f)
                            ;icicles
                            (make-object 600 400 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 1000 285 (rectangle 5 230 "solid" "gray") #t)
                            (make-object 1400 500 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 1500 500 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 1600 500 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 2300 300 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 2400 300 (rectangle 5 200 "solid" "gray") #t)
                            (make-object 2700 325 (rectangle 5 150 "solid" "gray") #t)
                            (make-object 3500 325 (rectangle 5 150 "solid" "gray") #t)
                            ;snowmen
                            (make-prize 1400 100 (ellipse 30 80 "solid" "pink") 40)
                            (make-prize 1800 325 (ellipse 40 100 "solid" "pink") 10)
                            (make-prize 1800 325 (ellipse 40 100 "solid" "pink") 10)
                            ;avalanches
                            (make-enemy 900 -60 (circle 20 "solid" "black") 5)
                            (make-enemy 1400 -60 (circle 20 "solid" "black") 2)
                            (make-enemy 1800 -60 (circle 50 "solid" "black") 10)
                            (make-enemy 2400 -60 (circle 50 "solid" "black") 10)
                            ) clearBoard counter score))

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
                             counter
                             score))
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
                             counter
                             score))

(define levelUpList (list world1.1 world1.2 world1.3 world2.1 world2.2 world2.3 world3.1 world3.2 world3.3))
; temporary level up buttons
(define levelUpText (text "You completed this level!\nLevel up?  Yes" 12 "white"))
(define levelUpImage (overlay levelUpText
                              (square 100 "solid" "blue")))

; create menu button for the end of a level with the return value of the next level
(define (makeLevelUpButton currentWorld currentLevel currentScore)
  (make-menuButton
   charX
   (/ (image-height mainB) 2)
   levelUpImage
   #false
   (make-ugs
    #f
    (ugs-world (getNextWorld currentWorld currentLevel))
    (ugs-character (getNextWorld currentWorld currentLevel))
    (ugs-level (getNextWorld currentWorld currentLevel))
    (ugs-objects (getNextWorld currentWorld currentLevel))
    clearBoard
    counter
    currentScore)))


(define (getNextWorld currentWorld currentLevel)
  (first (filter ugs? (for/list ([i (length levelUpList)])
     (if (and (= (ugs-world (list-ref levelUpList i)) currentWorld) (= (ugs-level (list-ref levelUpList i)) currentLevel)) (list-ref levelUpList i) #f)))))

  
; Create button that congratulates player at reaching end of the world
(define completedWorldText (text "Congratulations! \nYou've completed this world." 24 "white"))
(define completedWorldImage (overlay completedWorldText
                              (rectangle 300 100 "solid" "blue")))
(define completedWorldButton (make-menuButton charX (/ (image-height mainB) 2) completedWorldImage #false mainMenu))


;FUNCTIONS

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
             (character-jumps (ugs-character gs))
             (character-temp (ugs-character gs))
             (character-image (ugs-character gs))
             (character-imageSelector (ugs-character gs))
             (cond
               [(key=? key "right") "right"]
               [(key=? key "left") "left"]
               [else (character-moveDirection (ugs-character gs))]))
            (ugs-level gs)
            (ugs-objects gs)
            (make-keyboard
             (if (key=? key " ") value (keyboard-space (ugs-keyboard gs)))
             (if (key=? key "left") value (keyboard-left (ugs-keyboard gs)))
             (if (key=? key "right") value (keyboard-right (ugs-keyboard gs)))
             (if (key=? key "escape") value (keyboard-escape (ugs-keyboard gs))))
            (ugs-tockCounter gs)
            (ugs-score gs)))


; Gamestate -> Gamestate --- Exits the world if menu-state == #f, backs up a level in menu-state,
;                             exits the game if were're in the mainMenu
(define (escapeKey gs)
  (if (ugs-menu gs)
      (if (> (ugs-world gs) 0)
          mainMenu
          (make-ugs (ugs-menu gs) (ugs-world gs) (ugs-character gs) (ugs-level gs) '() clearBoard counter score))
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
            counter
            score))

; X Y Gamestate -> Boolean --- This checks if a x and y collides with a menuButton
(define (overButton? x y b)
  (and 
   (<  (abs (- x (menuButton-x b))) (/ (image-width (menuButton-image b)) 2))
   (<  (abs (- y (menuButton-y b))) (/ (image-height (menuButton-image b)) 2))))


;-----------------Tock Functions-----------------
; Gamestate -> Gamestate --- moves the world and its objects and its enemies

;----------CHARACTER UPDATE FUNCTIONS--------------

;(define-struct ugs [menu world character level objects keyboard])
; Gamestate -> Gamestate --- this function adds the jumpStrength to the y-value of the character
(define (jump gs)
  (if (> (character-jumps (ugs-character gs)) 0)
      (make-ugs (ugs-menu gs) (ugs-world gs)
                (make-character
                 (character-y (ugs-character gs))
                 (- jumpStrength)
                 (- (character-jumps (ugs-character gs)) 1)
                 (character-temp (ugs-character gs))
                 (character-image (ugs-character gs))
                 (character-imageSelector (ugs-character gs))
                 (character-moveDirection (ugs-character gs)))
                (ugs-level gs)
                (ugs-objects gs)
                (ugs-keyboard gs)
                (ugs-tockCounter gs)
                (ugs-score gs))
      gs))


; Animate Tock
; Character -> imageSelector
; Updates and returns the imageSelector of the input dude to determine which image will be rendered for animation
(define (animateCharacter dude cntr)
     (modulo (if (= 1 (modulo cntr animationSpeed)) (+ 1 (character-imageSelector dude)) (character-imageSelector dude)) (length (character-image dude))))
 ;POTENTIAL FIX FOR FAST MOVEMENT 

; Character -> Character --- effects gravity on the world
; CURRENTLY, THIS IS FUNCTIONING AS THE MASTER CHARACTER TOCK...
(define (gravityHappens char cntr)
  (make-character
   (+ (character-y char) (character-yVel char))
   (if (<= (character-yVel char) maxFall) (+ (character-yVel char) gravity) (character-yVel char))
   (character-jumps char)
   (character-temp char)
   (character-image char)
   (animateCharacter char cntr)
   (character-moveDirection char)))


;-----------------MASTER TOCKS------------------

(define (tock gs)
  (cond
    [(ugs-menu gs) gs] ;Don't move anything if we're in the menu
    [(levelUp? gs) (lastLevel? gs)]
    [(hitPrize? gs (gravityHappens (ugs-character gs) (ugs-tockCounter gs))) (increaseScore gs)]
    [(missedPrize? gs) (removePrize gs)]
    [else (returnNextWorld gs)]))

; checks for collision with a prize
(define (hitPrize? gs futureCharY)
    (cond
    [(empty? (ugs-objects gs)) #f]
    [(prize? (first (ugs-objects gs)))
     (and
       (and

        ; Bottem of char is lower than the top of ob
        (>=
         (+
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (- (prize-y (first (ugs-objects gs))) (/ (image-height (prize-image (first (ugs-objects gs)))) 2)))

        ; Top of char is higher than bottem of ob
        (<=
         (-
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (+ (prize-y (first (ugs-objects gs))) (/ (image-height (prize-image (first (ugs-objects gs)))) 2)))
        )
        
       (<=
        (abs (- (prize-x (first (ugs-objects gs))) charX))
        (+ (/ (image-width (prize-image (first (ugs-objects gs)))) 2) 26)))]
      ;                         hehehe graphical hard-coding with that 26 to eliminate a falling bug
    [else      
      ; Recursion
      (hitPrize?
       (make-ugs
        (ugs-menu gs)
        (ugs-world gs)
        (ugs-character gs)
        (ugs-level gs)
        (rest (ugs-objects gs))
        (ugs-keyboard gs)
        (ugs-tockCounter gs)
        (ugs-score gs)) futureCharY)]))

; checks if the character missed a prize
(define (missedPrize? gs)
  (if (empty? (filter prize? (ugs-objects gs))) #f (< (prize-x (first (filter prize? (ugs-objects gs)))) 0)))


; increase the score after hitting a prize
(define (increaseScore gs)
  (removePrize (make-ugs
        (ugs-menu gs)
        (ugs-world gs)
        (ugs-character gs)
        (ugs-level gs)
        (ugs-objects gs)
        (ugs-keyboard gs)
        (ugs-tockCounter gs)
        (+ (prize-points (first (filter prize? (ugs-objects gs)))) (ugs-score gs)))))

; Removes the prize after increasing the score
(define (removePrize gs)
  (make-ugs
        (ugs-menu gs)
        (ugs-world gs)
        (ugs-character gs)
        (ugs-level gs)
        (remove (first (filter prize? (ugs-objects gs))) (ugs-objects gs))
        (ugs-keyboard gs)
        (ugs-tockCounter gs)
        (ugs-score gs)))


; check to see if the player has reached the end of the world
(define (levelUp? gs)
  (= (object-x (first (filter object? (ugs-objects gs)))) endLevelX))


; checks whether player completed level or world
(define (lastLevel? gs)
  (if (= (ugs-level gs) 3)
      (make-ugs #t (ugs-world gs) (ugs-character gs) (ugs-level gs) (list completedWorldButton) (ugs-keyboard gs) (ugs-tockCounter gs) (ugs-score gs)) ;return Completed World Image
      (make-ugs #t (ugs-world gs) (ugs-character gs) (ugs-level gs) (list (makeLevelUpButton (ugs-world gs) (+ 1 (ugs-level gs)) (ugs-score gs))) (ugs-keyboard gs) (ugs-tockCounter gs) (ugs-score gs)) ;return Level Up? option
      )) 


; I moved everything into a secondary function so that we can add parameters as needed
(define (returnNextWorld gs)
  (make-ugs (ugs-menu gs)
            (ugs-world gs)
            (affect_char gs)
            (ugs-level gs)
            (affectLoo gs (move gs) (affect_char gs))
            (ugs-keyboard gs)
            (+ 1 (ugs-tockCounter gs))
            (ugs-score gs)
            ))

; This function returns the character with either a change in y-position or no change
(define (affect_char gs)
  (if
   (char_object_collision? gs (gravityHappens (ugs-character gs) (ugs-tockCounter gs)))
   (make-character
    (character-y (ugs-character gs))
    0
    2
    (character-temp (ugs-character gs))
    (character-image (ugs-character gs))
    (character-imageSelector (ugs-character gs))
    (character-moveDirection (ugs-character gs)))
   (gravityHappens (ugs-character gs) (ugs-tockCounter gs))))

; Gamestate -> Gamestate
; This function loops through the list of objects (for now just one), and returns a modified gs if there's collision
(define (char_object_collision? gs futureCharY)
  (cond
    [(empty? (ugs-objects gs)) #f]
   
    [else
     (or
      (and
       (and

        ; Bottem of char is lower than the top of ob
        (>=
         (+
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (- (object-y (first (ugs-objects gs))) (/ (image-height (object-image (first (ugs-objects gs)))) 2)))

        ; Top of char is higher than bottem of ob
        (<=
         (-
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (+ (object-y (first (ugs-objects gs))) (/ (image-height (object-image (first (ugs-objects gs)))) 2)))
        )
        
       (<=
        (abs (- (object-x (first (ugs-objects gs))) charX))
        (+ (/ (image-width (object-image (first (ugs-objects gs)))) 2) 26)))
      ; Recursion
      (char_object_collision?
       (make-ugs
        (ugs-menu gs)
        (ugs-world gs)
        (ugs-character gs)
        (ugs-level gs)
        (filter object? (rest (ugs-objects gs)))
        (ugs-keyboard gs)
        (ugs-tockCounter gs)
        (ugs-score gs)) futureCharY))]))

; This function returns a list of objects that is either moved or not, depending on collision
(define (affectLoo gs movedLoo futureChar)
  (if (objectMoveCollision? gs (filter object? movedLoo) futureChar)
      (ugs-objects gs)
      movedLoo))

; what does this function do?
(define (objectMoveCollision? gs movedLoo futureChar)
  (cond
    [(empty? movedLoo) #f]
    [else
     (or
      (and
    
       ; The x-axis collision of objects and the char
       (and

        ; Right-edge-char is greater than the left-edge-object
        (>= 
         ; The right-side of the char hit-box (Char-x + half of the image width)
         (+ charX (/ (image-width (first (character-image futureChar))) 2))

         ; The left-side of the first object (ob-x - half the image width)
         (- (object-x (first movedLoo)) (/ (image-width (object-image (first movedLoo))) 2)))

        ; Left-edge-char is less than the right-edge-object
        (<=
         (- charX (/ (image-width (first (character-image futureChar))) 2))
         (+ (object-x (first movedLoo)) (/ (image-width (object-image (first movedLoo))) 2))))

       ; The y-axis collision of objects and the char
       (and
        ; The bottem of the char is lower than the top of the object
        (>=
         ; The bottem of the char hit-box (Char-y + half the image height)
         (+ (character-y futureChar) (/ (image-height (first (character-image futureChar))) 2))

         ; The top of the first object (ob-y - half the image height)
         (- (object-y (first movedLoo)) (/ (image-height (object-image (first movedLoo))) 2)))

        ; The top of the char is higher than the bottem of the object
        (<=
         ; The top of the char hitbox (Char-y + half the image height)
         (- (character-y futureChar) (/ (image-height (first (character-image futureChar))) 2))

         ; The bottem of the object hitbox (ob-y - half the image height)
         (+ (object-y (first movedLoo)) (/ (image-height (object-image (first movedLoo))) 2))
        
        )))
       (objectMoveCollision? gs (rest movedLoo) futureChar))
      ]))
   

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
                  [(prize? (first loo)) (make-prize
                                             (direction (prize-x (first loo)) 2)
                                           (prize-y (first loo))
                                           (prize-image (first loo))
                                           (prize-points (first loo)))]
                  [(enemy? (first loo)) (cond
                                          [(checkEnemyX (first loo)) (enemyAttack (first loo))]
                                          [else (make-enemy
                                                 (direction (enemy-x (first loo)) 2)
                                                 (enemy-y (first loo))
                                                 (enemy-image (first loo))
                                                 (enemy-vel (first loo)))])]
                  [else loo])
                (moveHelper char (rest loo) direction))]))


; check to see if the enemy has entered the world
(define (checkEnemyX enemy)
  (< (enemy-x enemy) charX))

; if the enemy is on the screen and has not missed, attack the character
(define (enemyAttack enemy)
  (make-enemy (- (enemy-x enemy) 2)
              (+ (enemy-y enemy) (enemy-vel enemy))
              (enemy-image enemy)
              (enemy-vel enemy)))



; overlay prize image with points
(define (showPoints prize)
  (overlay (text (number->string (prize-points prize)) 12 "black")
           (prize-image prize)))

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
                                       (renderAllObjects (rest obj) image))]
    [(prize? (first obj)) (place-image (showPoints (first obj))
                                       (prize-x (first obj)) (prize-y (first obj))
                                       (renderAllObjects (rest obj) image))]))

;(renderAllObjects looe mainB)
; Gamestate -> Image
; takes a character and renders instructed images
; The imageSelector determines which image to render
(define (characterRender gs)
  (place-image
   (cond
     [(and
       (equal? (character-moveDirection (ugs-character gs)) "right")
       (= (character-jumps (ugs-character gs)) 2))
      (list-ref (character-image (ugs-character gs)) (character-imageSelector (ugs-character gs)))]
     [(and
       (equal? (character-moveDirection (ugs-character gs)) "left")
       (= (character-jumps (ugs-character gs)) 2))
      (list-ref backwardSteven (character-imageSelector (ugs-character gs)))]
     [(and
       (equal? (character-moveDirection (ugs-character gs)) "right")
       (< (character-jumps (ugs-character gs)) 2))
      (list-ref (character-image (ugs-character gs)) 2)]
     [(and
       (equal? (character-moveDirection (ugs-character gs)) "left")
       (< (character-jumps (ugs-character gs)) 2))
      (list-ref backwardSteven 2)]
     [else (list-ref (character-image (ugs-character gs)) 0)])
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


; Gamestate -> Image
; renders player's score onto the world background
(define (scoreRender score image)
  (place-image (text (number->string score) 28 "black")
               40 40
               image))


; Gamestate -> Image --- Renders the entire game-state:
(define (masterRender gs)
  (if (ugs-menu gs) ;Don't render the character in menu-state
      (renderAllObjects (ugs-objects gs) (worldDeterminer (ugs-world gs)))
      (scoreRender (ugs-score gs) (characterRender gs))))


; rotate the character image 90 degrees for last world scene
(define (renderDeadChar gs)
  (place-image
   (rotate 90 (list-ref (character-image (ugs-character gs)) (character-imageSelector (ugs-character gs))))
   charX
   (if (> (character-y (ugs-character gs)) bottom) 675 (+ (/ (image-height (list-ref (character-image (ugs-character gs)) (character-imageSelector (ugs-character gs)))) 2) (character-y (ugs-character gs))))
   (renderAllObjects (ugs-objects gs) (worldDeterminer (ugs-world gs)))))

; check to see if there's a death collision between lethal object and character
(define (endWorld gs)
  (deathCollision? gs))

; List-of-Objects, Character -> Boolean
; go through list of objects and check if there is a collision with a lethal object
(define (deathCollision? gs)
  (cond
    [(empty? (ugs-objects gs)) #false]
    [(> (character-y (ugs-character gs)) (image-height mainB)) #true]
    [(or (enemy? (first (ugs-objects gs))) (and (object? (first (ugs-objects gs))) (object-lethal (first (ugs-objects gs))))) (collision? gs (gravityHappens (ugs-character gs) (ugs-tockCounter gs)))]
    [else (deathCollision?
           (make-ugs
            (ugs-menu gs)
            (ugs-world gs)
            (ugs-character gs)
            (ugs-level gs)
            (rest (ugs-objects gs))
            (ugs-keyboard gs)
            (ugs-tockCounter gs)
            (ugs-score gs)))]))


; Object, Character -> Boolean
; check to see if the character collides with an object
(define (collision? gs futureCharY)
   (cond
    [(empty? (ugs-objects gs)) #f]
    [(object? (first (ugs-objects gs)))
     (or
      (and
       (and
        ; Bottom of char is lower than the top of ob
        (>=
         (+
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (- (object-y (first (ugs-objects gs))) (/ (image-height (object-image (first (ugs-objects gs)))) 2)))

        ; Top of char is higher than bottem of ob
        (<=
         (-
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (+ (object-y (first (ugs-objects gs))) (/ (image-height (object-image (first (ugs-objects gs)))) 2)))
        )
        
       (<=
        (abs (- (object-x (first (ugs-objects gs))) charX))
        (+ (/ (image-width (object-image (first (ugs-objects gs)))) 2) 26)))
       ; Recursion
      (collision?
       (make-ugs
        (ugs-menu gs)
        (ugs-world gs)
        (ugs-character gs)
        (ugs-level gs)
        (rest (ugs-objects gs))
        (ugs-keyboard gs)
        (ugs-tockCounter gs)
        (ugs-score gs)) futureCharY))]
      ;                         hehehe graphical hard-coding with that 26 to eliminate a falling bug
    [(enemy? (first (ugs-objects gs)))
     (or
      (and
       (and

        ; Bottom of char is lower than the top of ob
        (>=
         (+
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (- (enemy-y (first (ugs-objects gs))) (/ (image-height (enemy-image (first (ugs-objects gs)))) 2)))

        ; Top of char is higher than bottem of ob
        (<=
         (-
          (character-y futureCharY)
          (/ (image-height (first (character-image (ugs-character gs)))) 2))
         (+ (enemy-y (first (ugs-objects gs))) (/ (image-height (enemy-image (first (ugs-objects gs)))) 2)))
        )
        
       (<=
        (abs (- (enemy-x (first (ugs-objects gs))) charX))
        (+ (/ (image-width (enemy-image (first (ugs-objects gs)))) 2) 26)))
      ; Recursion
      (collision?
       (make-ugs
        (ugs-menu gs)
        (ugs-world gs)
        (ugs-character gs)
        (ugs-level gs)
        (rest (ugs-objects gs))
        (ugs-keyboard gs)
        (ugs-tockCounter gs)
        (ugs-score gs)) futureCharY))]
    [(prize? (first (ugs-objects gs)))
     (collision?
       (make-ugs
        (ugs-menu gs)
        (ugs-world gs)
        (ugs-character gs)
        (ugs-level gs)
        (rest (ugs-objects gs))
        (ugs-keyboard gs)
        (ugs-tockCounter gs)
        (ugs-score gs)) futureCharY)]))


; Main Big Bang function
(define (main gs)
  (big-bang gs
    [on-tick tock .01]
    [on-key onKey]
    [on-release onRelease]
    [on-mouse onMouse]
    [stop-when endWorld renderDeadChar]
    [to-draw masterRender]))

; test the program
(main mainMenu)