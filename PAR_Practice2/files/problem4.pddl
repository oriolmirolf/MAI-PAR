(define (problem ramen)
  (:domain robot-chef)

  (:objects
    ; GENERIC OBJECTS
    knife pot spoon - tool
    SA PA CA SVA DWA CTA MIXA - location
    cutting mixing cooking - action

    ; PROBLEM SPECIFIC OBJECTS
    noodles broth vegetables ramen flavour water - ingredient
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

    (already-crafted vegetables)
    (already-crafted broth)
    (already-crafted flavour)
    (already-crafted water)

    (item-at flavour SA)
    (item-at water SA)
    (item-at broth SA)
    (item-at vegetables SA)
    
    (ingredient-needs-action vegetables cutting)
    (ingredient-needs-action vegetables cooking)
    (ingredient-needs-action noodles cooking)
    (ingredient-needs-action flavour mixing)
    (ingredient-needs-action broth cooking)
    (ingredient-needs-action water cooking)

    (action-predecence-for-ingredient cutting cooking vegetables)

    (needs-ingredient noodles flavour)
    (needs-ingredient noodles water)

    (needs-ingredient ramen vegetables)
    (needs-ingredient ramen noodles)
    (needs-ingredient ramen broth)
  )

  (:goal
    (and
      (dish-is-served ramen)
    )
  )
)
