(define (problem ex1)
  (:domain rescue_drone)
  (:objects
    p1 p2 p3 - person
    l1 l2 l3 l4 l5 l6 l7 l8 l9 l10 l11 l12 l13 l14 l15 l16 - location
)
  (:init
    (adjacent l1 l5)
    (adjacent l1 l2)
    (adjacent l2 l6)
    (adjacent l2 l3)
    (adjacent l3 l7)
    (adjacent l3 l4)
    (adjacent l4 l8)
    (adjacent l5 l9)
    (adjacent l5 l6)
    (adjacent l6 l10)
    (adjacent l6 l7)
    (adjacent l7 l11)
    (adjacent l7 l8)
    (adjacent l8 l12)
    (adjacent l9 l13)
    (adjacent l9 l10)
    (adjacent l10 l14)
    (adjacent l10 l11)
    (adjacent l11 l15)
    (adjacent l11 l12)
    (adjacent l12 l16)
    (adjacent l13 l14)
    (adjacent l14 l15)
    (adjacent l15 l16)
    (drone-at l1)
    (safe-zone l14)
    (obstacle l7)
    (obstacle l11)
    (obstacle l16)
    (person-at p1 l4)
    (person-at p2 l5)
    (person-at p3 l10)
    (= (safe-zone-capacity) 3)
    (= (safe-zone-occupancy) 0)
  )
  (:goal (and
    (rescued p1)
    (rescued p2)
    (rescued p3)
))
)
