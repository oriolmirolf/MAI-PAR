(define (problem sashimi)
  (:domain robot-chef)

  (:objects
    ; GENERIC OBJECTS
    knife pot spoon - tool
    SA PA CA SVA DWA CTA MIXA - location
    cutting mixing cooking - action

    ; PROBLEM SPECIFIC OBJECTS
    fish sashimi - ingredient
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
    (already-crafted fish)

    (item-at fish SA)
    
    (ingredient-needs-action fish cutting)

    (needs-ingredient sashimi fish)
  )

  (:goal
    (and
      (dish-is-served sashimi)
    )
  )
)
