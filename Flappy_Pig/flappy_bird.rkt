;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname flappy_bird) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define pig (flip-horizontal (bitmap "pig2.png")))
(define BACKGROUND (bitmap "trees.png"))
(define gSPEED 5)
(define GATE (rectangle 10 600 "solid" "black"))

(define-struct bird [y vel])

(define-struct gate [top bottom loc])

(define-struct gates [gateA gateB gateC gateD])

(define-struct game [bird gates score])

(define (render_bird gs im)
  (place-image pig 150 (bird-y (game-bird gs)) im))

(define (render_gates gs im)
  (place-images
   
   (list
    GATE
    GATE
    
    GATE
    GATE
    
    GATE
    GATE
    
    GATE
    GATE)
   
   (list
    (make-posn (gate-loc (gates-gateA (game-gates gs))) (gate-top (gates-gateA (game-gates gs))))
    (make-posn (gate-loc (gates-gateA (game-gates gs))) (gate-bottom (gates-gateA (game-gates gs))))
    
    (make-posn (gate-loc (gates-gateB (game-gates gs))) (gate-top (gates-gateB (game-gates gs))))
    (make-posn (gate-loc (gates-gateB (game-gates gs))) (gate-bottom (gates-gateB (game-gates gs))))
    
    (make-posn (gate-loc (gates-gateC (game-gates gs))) (gate-top (gates-gateC (game-gates gs))))
    (make-posn (gate-loc (gates-gateC (game-gates gs))) (gate-bottom (gates-gateC (game-gates gs))))
    
    (make-posn (gate-loc (gates-gateD (game-gates gs))) (gate-top (gates-gateD (game-gates gs))))
    (make-posn (gate-loc (gates-gateD (game-gates gs))) (gate-bottom (gates-gateD (game-gates gs)))))
   im))

(define (render gs)
  (overlay/offset
   (text/font (number->string (game-score gs)) 80 "black" "Gill Sans" 'swiss 'normal 'normal #f)
   0 0
   (render_bird gs
                (render_gates gs BACKGROUND))))
   

(define (fly gs)
  (make-bird 
   (+ (bird-vel (game-bird gs)) (bird-y (game-bird gs)))
   (cond
     [(>= (bird-vel (game-bird gs)) 15) (bird-vel (game-bird gs))]
     [else (+ (bird-vel (game-bird gs)) 0.5)])))

(define (build_random_gate gg seed)
  (make-gate
   (- seed 200)
   (+ seed 600)
   (image-width BACKGROUND)))

(define (move_gate gate)
  (make-gate
        (gate-top gate)
        (gate-bottom gate)
        (- (gate-loc gate) gSPEED)))
   
(define (move_gates gg)
  (make-gates
   (if (<= (gate-loc (gates-gateA gg)) 0)
       (build_random_gate gg (random 400))
       (move_gate (gates-gateA gg)))
   
   (if (<= (gate-loc (gates-gateB gg)) 0)
       (build_random_gate gg (random 400))
       (move_gate (gates-gateB gg)))
   
   (if (<= (gate-loc (gates-gateC gg)) 0)
       (build_random_gate gg (random 400))
       (move_gate (gates-gateC gg)))
   
   (if (<= (gate-loc (gates-gateD gg)) 0)
       (build_random_gate gg (random 400))
       (move_gate (gates-gateD gg)))))

;(define (count_score gs)
 ; )
   
(define (tock gs)
  (make-game (fly gs) (move_gates (game-gates gs)) (cond
    [(equal? (abs (- 150 (gate-loc (gates-gateA (game-gates gs))))) 3) (+ (game-score gs) 1)]
    [else (game-score gs)])))

(define (lift gs key) 
  (cond
    [(key=? key " ")
     (make-game (make-bird (bird-y (game-bird gs))
                           (cond
                             [(<= (bird-vel (game-bird gs)) 15) (- 15)]
                             [else (- (bird-vel (game-bird gs)) 15)]))
                (game-gates gs)
                (game-score gs))]
     [else (make-game (game-bird gs) (game-gates gs) (game-score gs))]))

(define (collision gs)
  (or
   (or
    (or 
     (and
      (not
       (and
        (>= (bird-y (game-bird gs)) (+ (gate-top (gates-gateA (game-gates gs))) 300))
        (<= (bird-y (game-bird gs)) (- (gate-bottom (gates-gateA (game-gates gs))) 300))))
      (<= (abs (- (gate-loc (gates-gateA (game-gates gs))) 150)) 10))
     
     (and
      (not
       (and
        (>= (bird-y (game-bird gs)) (+ (gate-top (gates-gateB (game-gates gs))) 300))
        (<= (bird-y (game-bird gs)) (- (gate-bottom (gates-gateB (game-gates gs))) 300))))
      (<= (abs (- (gate-loc (gates-gateB (game-gates gs))) 150)) 10)))
     
     (and
      (not
       (and
        (>= (bird-y (game-bird gs)) (+ (gate-top (gates-gateC (game-gates gs))) 300))
        (<= (bird-y (game-bird gs)) (- (gate-bottom (gates-gateC (game-gates gs))) 300))))
      (<= (abs (- (gate-loc (gates-gateC (game-gates gs))) 150)) 10)))
     
     (and
      (not
       (and
        (>= (bird-y (game-bird gs)) (+ (gate-top (gates-gateD (game-gates gs))) 300))
        (<= (bird-y (game-bird gs)) (- (gate-bottom (gates-gateD (game-gates gs))) 300))))
      (<= (abs (- (gate-loc (gates-gateD (game-gates gs))) 150)) 10))))
    

(define (main gs)
  (big-bang gs
    (to-draw render)
    (on-tick tock)
    (on-key lift)
    (stop-when collision)))

(define start (make-game
               (make-bird 500 10)
               (make-gates
                (make-gate 100 900 650)
                (make-gate -200 600 1000)
                (make-gate 200 1000 1350)
                (make-gate -100 700 1700)
                )
               0))


(main start)