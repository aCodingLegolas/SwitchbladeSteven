;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname j_world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;Objects in the ice world:
;   snowmen: they melt quickly. Knocking one over increases the score
;   icicles: deadly on collision
;   fire: hit a fire to warm your body temp
;   the character dies slowly of hypothermia


; Character -> Charcter
; increases the characters temperature +10
; given (character-temp 10), expect (character-temp 20)
; given (character-temp 0), expect (character-temp 10)
(define (warm char)
  (make-character (+ (character-temp (ugs-character char)) 10)))

; Snowman -> Snowman
; makes the snowman disappear by rendering a new image
; given (snowman-size 20), expect (snowman-size 10)
; given (snowman-size SMALL), expect (snowman-size 0)
(define (melt sm)
  (cond
    [(<= (snowman-size sm) SMALL) (snowman-size 0)]
    [else ...]))

(define (die gs)
  gs)