(define (problem ex2)
  (:domain rescue_drone)
  (:objects
    p1 p2 p3 - person
    l1 l2 l3 l4 l5 l6 l7 l8 l9 l10 l11 l12 l13 l14 l15 l16 l17 l18 l19 l20 l21 l22 l23 l24 l25 - location
)
  (:init
    (adjacent l1 l6)
    (adjacent l1 l2)
    (adjacent l2 l7)
    (adjacent l2 l3)
    (adjacent l3 l8)
    (adjacent l3 l4)
    (adjacent l4 l9)
    (adjacent l4 l5)
    (adjacent l5 l10)
    (adjacent l6 l11)
    (adjacent l6 l7)
    (adjacent l7 l12)
    (adjacent l7 l8)
    (adjacent l8 l13)
    (adjacent l8 l9)
    (adjacent l9 l14)
    (adjacent l9 l10)
    (adjacent l10 l15)
    (adjacent l11 l16)
    (adjacent l11 l12)
    (adjacent l12 l17)
    (adjacent l12 l13)
    (adjacent l13 l18)
    (adjacent l13 l14)
    (adjacent l14 l19)
    (adjacent l14 l15)
    (adjacent l15 l20)
    (adjacent l16 l21)
    (adjacent l16 l17)
    (adjacent l17 l22)
    (adjacent l17 l18)
    (adjacent l18 l23)
    (adjacent l18 l19)
    (adjacent l19 l24)
    (adjacent l19 l20)
    (adjacent l20 l25)
    (adjacent l21 l22)
    (adjacent l22 l23)
    (adjacent l23 l24)
    (adjacent l24 l25)
    (drone-at l15)
    (safe-zone l25)
    (obstacle l8)
    (obstacle l9)
    (obstacle l10)
    (obstacle l12)
    (obstacle l19)
    (obstacle l20)
    (person-at p1 l5)
    (person-at p2 l7)
    (person-at p3 l23)
    (= (safe-zone-capacity) 3)
    (= (safe-zone-occupancy) 0)
  )
  (:goal (and
    (rescued p1)
    (rescued p2)
    (rescued p3)
))
)
