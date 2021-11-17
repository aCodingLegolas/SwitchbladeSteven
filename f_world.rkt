;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname f_world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/abstraction)


(define-struct character [x_loc y_loc image superpower])
(define BACKGROUND (image))
(define-struct object [x_loc y_loc image fatal])

; [character struct] [background] [list of objects]
; 
(define-struct wl [character background objects])