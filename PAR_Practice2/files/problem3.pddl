(define (problem sushi)
  (:domain robot-chef)

  (:objects
    ; GENERIC OBJECTS
    knife pot spoon - tool
    SA PA CA SVA DWA CTA MIXA - location
    cutting mixing cooking - action

    ; PROBLEM SPECIFIC OBJECTS
    sushi rice seaweed fish - ingredient
  )

  (:init
    ; GENERIC PREDICATES
    (robot-at CA)

    (adjacent SA MIXA)
    (adjacent SA CTA)
    (adjacent MIXA PA)
    (adjacent MIXA CTA)
    (adjacent PA MIXA)
    (adjacent PA CA)
    (adjacent CA DWA)
    (adjacent CA SVA)

    (location-is-PA PA)
    (location-is-SVA SVA)
    (location-is-DWA DWA)

    (tool-for-action knife cutting)
    (tool-for-action pot cooking)
    (tool-for-action spoon mixing)

    (tool-clean knife)
    (tool-clean pot)
    (tool-clean spoon)

    (item-at knife CTA)
    (item-at pot PA)
    (item-at spoon MIXA)
    
    (loc-for-action CTA cutting)
    (loc-for-action CA cooking)
    (loc-for-action MIXA mixing)
    
    ; PROBLEM SPECIFIC PREDICATES

    (already-crafted rice)
    (already-crafted fish)

    (item-at rice SA)
    (item-at fish SA)
    
    (ingredient-needs-action fish cutting)
    (ingredient-needs-action rice cooking)
    (ingredient-needs-action rice mixing)

    (action-predecence-for-ingredient cooking mixing rice)

    (needs-ingredient sushi fish)
    (needs-ingredient sushi rice)
    (needs-ingredient sushi seaweed)
  )

  (:goal
    (and
      (dish-is-served sushi)
    )
  )
)
