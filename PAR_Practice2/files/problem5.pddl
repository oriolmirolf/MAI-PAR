(define (problem multiple)
  (:domain robot-chef)

  (:objects
    ; GENERIC OBJECTS
    knife pot spoon - tool
    SA PA CA SVA DWA CTA MIXA - location
    cutting mixing cooking - action

    ; PROBLEM SPECIFIC OBJECTS
    fish1 sashimi sushi rice seaweed fish2 - ingredient
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

    ; Sashimi instructions
    (already-crafted fish1)
    (item-at fish1 SA)
    (ingredient-needs-action fish1 cutting)
    (needs-ingredient sashimi fish1)

    ; Sushi instructions
    (already-crafted rice)
    (already-crafted fish2)
    (already-crafted seaweed)

    (item-at rice SA)
    (item-at fish2 SA)
    (item-at seaweed SA)
    
    (ingredient-needs-action fish2 cutting)
    (ingredient-needs-action fish2 cooking)
    (ingredient-needs-action rice cooking)
    (ingredient-needs-action rice mixing)

    (action-predecence-for-ingredient cooking mixing rice)
    (action-predecence-for-ingredient cutting cooking fish2)

    (needs-ingredient sushi fish2)
    (needs-ingredient sushi rice)
    (needs-ingredient sushi seaweed)
  )

  (:goal
    (and
      (dish-is-served sashimi)
      (dish-is-served sushi)
    )
  )
)
