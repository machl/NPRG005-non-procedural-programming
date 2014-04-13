#lang scheme

;;; 7. ukol - #1 (mobil) ;;;
;;; Petr Belohlavek ;;;

;;; Jednostranne rameno (delka ramena, zaveseny mobil)
(define (rameno delka_ramena zaveseny_mobil) (cons delka_ramena zaveseny_mobil))

;;; Mobil (delka zavesneho lanka, leve rameno, prave rameno)
(define (mobil delka_lanka leve_rameno prave_rameno) (cons delka_lanka (cons leve_rameno prave_rameno)))
  
;;; Neprima rekurze - porovnaji se delky ramen a potom
;;; se porovnaji mobily na nich visici (ktere znovu
;;; porovnavaji ramena atd)
(define (stejna_ramena leve_rameno prave_rameno) 
	(and 	; zaroven plati
		(equal? (car leve_rameno) (car prave_rameno))	; delky ramen jsou shodne
		(stejne_mobily (cdr leve_rameno) (cdr prave_rameno)); mobily na nich visici jsou shodne
	)
)

;;; Druha cast neprime rekurze - zkusi se vsechny moznosti
;;; jak otocit jednotlive mobily
(define (stejne_mobily levy_mobil pravy_mobil) 
	(cond
		; oba mobily jsou cisla - staci je porovnat 
		((and (number? levy_mobil) (number? pravy_mobil)) (equal? levy_mobil pravy_mobil))

		; levy mobil je opravdu mobil a levy je pouze cislo -> false
		((and (not (number? levy_mobil)) (number? pravy_mobil)) #f)
		; symetricky obracene
		((and (number? levy_mobil) (not (number? pravy_mobil))) #f)

		; oba dva jsou opravdu mobily
		((and (not (number? levy_mobil)) (not (number? pravy_mobil)))
		(and	; musi platit zaroven
			(equal? (car levy_mobil) (car pravy_mobil))	; delky zavesnych lanek jsou shodne
			(or	; plati alespon jedna z moznosti
				(and
					; leva ramena jsou shodna
					(stejna_ramena (car (cdr levy_mobil)) (car (cdr pravy_mobil)))
					; a prava taky
					(stejna_ramena (cdr (cdr levy_mobil)) (cdr (cdr pravy_mobil)))
				)
				; nebo
				(and
					;  leve rameno leveho mobilu je shodne s pravym ramenem praveho mobilu
					(stejna_ramena (car (cdr levy_mobil)) (cdr (cdr pravy_mobil)))
					;  a symetricky obracene
					(stejna_ramena (cdr (cdr levy_mobil)) (car (cdr pravy_mobil)))
				)
			)
		))
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; mobil z prikladu http://ksvi.mff.cuni.cz/~dvorak/vyuka/NPRG005x01/du7.html
;(mobil 2
;	(rameno 1 10)
;	(rameno 3 (mobil 1 (rameno 2 15) (rameno 8 5)))
;)

;;; testy
; trivialni mobily
(cons '------- '-------)
(stejne_mobily 0 0)	; #t
(stejne_mobily 1 2)	; #f
(stejne_mobily 2 1)	; #f
(stejne_mobily 3 3)	; #t


; jednourovnove mobily
(cons '------- '-------)
(define mob_lvl1_a (mobil 1 (rameno 1 10) (rameno 2 20)))
(define mob_lvl1_b (mobil 1 (rameno 2 20) (rameno 1 10)))
(define mob_lvl1_c (mobil 1 (rameno 2 20) (rameno 1 50)))
(stejne_mobily mob_lvl1_a mob_lvl1_b)	; #t
(stejne_mobily mob_lvl1_a mob_lvl1_c)	; #f

; viceurovnove mobily (ze zadani), ruzne otocene + posledni jiny
(cons '------- '-------)
(define mob_lvl2_a
	(mobil 2
		(rameno 1 10)
		(rameno 3 (mobil 1 (rameno 2 15) (rameno 8 5)))
	)
)
(define mob_lvl2_b
	(mobil 2
		(rameno 3 (mobil 1 (rameno 2 15) (rameno 8 5)))
		(rameno 1 10)
	)
)
(define mob_lvl2_c
	(mobil 2
		(rameno 3 (mobil 1 (rameno 8 5) (rameno 2 15)))
		(rameno 1 10)
	)
)
(define mob_lvl2_d
	(mobil 2
		(rameno 3 (mobil 1 (rameno 8 7) (rameno 2 15)))
		(rameno 1 10)
	)
)
(stejne_mobily mob_lvl2_a mob_lvl2_b)	; #t
(stejne_mobily mob_lvl2_a mob_lvl2_c)	; #t
(stejne_mobily mob_lvl2_c mob_lvl2_b)	; #t
(stejne_mobily mob_lvl2_a mob_lvl2_d)	; #f
(stejne_mobily mob_lvl2_c mob_lvl2_d)	; #f
(stejne_mobily mob_lvl2_c mob_lvl1_a)	; #f
