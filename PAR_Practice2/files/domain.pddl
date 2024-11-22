(define (domain robot-chef)
  (:requirements :strips :typing :negative-preconditions)
  
  (:types 
    item 
    tool ingredient - item
        
    location    
    action
  )

  (:predicates
    (robot-at ?loc - location)
    (item-at ?item - item ?loc - location)

(tool-clean ?tool - tool) 
    (robot-holding ?item - item)
    (is-robot-holding-something)
    
    (adjacent ?loc1 - location ?loc2 - location)
    
    
    ; for locations
    (location-is-PA ?loc - location)
    (location-is-SVA ?loc - location)
    (location-is-DWA ?loc - location)
    
    ; dish
    (dish-is-served ?dish - ingredient)
    (needs-ingredient ?dish - ingredient ?ingredient - ingredient)
    (already-crafted ?ing - ingredient)

    ; for preparing ingredient
    (ingredient-needs-action ?ingredient - ingredient ?a - action)
    (ingredient-is-ready ?ingredient - ingredient)

    ; logistics
    (action-predecence-for-ingredient ?act_pre -action ?act_post - action ?ingredient - ingredient)
    (loc-for-action ?loc - location ?a - action)
    (tool-for-action ?tool - tool ?a - action)
  )

  (:action move
      :parameters (
        ?from - location ?to - location
      )
      :precondition (and 
        (robot-at ?from)
        (or
          (adjacent ?from ?to)
          (adjacent ?to ?from)
        )
      )
      :effect (and 
        (not (robot-at ?from))
        (robot-at ?to)
      )
  )

  (:action pick-up-item
      :parameters (?loc - location ?item - item)
      :precondition (and 
        (robot-at ?loc)
        (item-at ?item ?loc)
        (not (is-robot-holding-something))
      )
      :effect (and 
        (not (item-at ?item ?loc))
        (robot-holding ?item)
        (is-robot-holding-something)
      )
  )

  (:action drop-off-item
      :parameters (?loc - location ?item - item)
      :precondition (and 
        (robot-at ?loc)
        (robot-holding ?item)
        (is-robot-holding-something)
      )
      :effect (and 
        (item-at ?item ?loc)
        (not (robot-holding ?item))
        (not (is-robot-holding-something))
      )
  )

  (:action clean-tool
      :parameters (?tool - tool ?loc - location)
      :precondition (and 
        (robot-at ?loc)
        (location-is-DWA ?loc)
        (robot-holding ?tool)
        (not (tool-clean ?tool))
      )
      :effect (and 
        (tool-clean ?tool)
      )
  )


  (:action action-on-ingredient
      :parameters (?loc - location ?ingredient - ingredient ?tool - tool ?a - action)
      :precondition (and 
        (robot-at ?loc)
        (item-at ?ingredient ?loc)
        (robot-holding ?tool)
        (tool-clean ?tool)

        (ingredient-needs-action ?ingredient ?a)
        (tool-for-action ?tool ?a)
        (loc-for-action ?loc ?a)

        ; Check that all prerequisite actions for this one are fulfilled
        (not 
          (exists (?pre_action - action) 
            (and
              (action-predecence-for-ingredient ?pre_action ?a ?ingredient)
              (ingredient-needs-action ?ingredient ?pre_action)
            )
          )
        )
      )
      :effect (and 
        (not (tool-clean ?tool))
        (not (ingredient-needs-action ?ingredient ?a))
        ; If there are no other actions left fot this ingredient, mark it as ready  
        (when ;when (a) => (b)
          (not 
            (exists (?action_to_do - action)
              (and (ingredient-needs-action ?ingredient ?action_to_do)
                   (not (= ?action_to_do ?a)) ; current action is not deleted imediately
              )
            )
          )
          (ingredient-is-ready ?ingredient)
        ) 
      )
  )

  (:action prepare
      :parameters (?loc - location ?result - ingredient)
      :precondition (
        and
          (not (already-crafted ?result))
          (robot-at ?loc)
          (location-is-PA ?loc)
          ; The result requires at least one ingredient (to prevent the solver from crafting stuff
          ; from nothing)
          (exists (?ing - ingredient) (needs-ingredient ?result ?ing))
          ; Check that all all ingredients are either ready or do not require any action on them
          (forall (?ingredient - ingredient)
            (or
              (not (needs-ingredient ?result ?ingredient))
              (and
                ; Either the ingredient is ready or it does not need any action
                (or (ingredient-is-ready ?ingredient)
                    (not (exists (?a - action) (ingredient-needs-action ?ingredient ?a)))
                )
                (item-at ?ingredient ?loc)
              )
            )
          )
      )
      :effect (
        and
          ; "Remove" items by not placing them anywhere (not accesible by robot)
          (forall (?ingredient - ingredient)
            (when 
              (needs-ingredient ?result ?ingredient) 
              (not (item-at ?ingredient ?loc)) ; disappears
            )
          )
          (robot-holding ?result) ; hold == prepared!!
          (already-crafted ?result)
      )
  )
  
  (:action serve-dish
      :parameters (?loc - location ?dish_ingredint - ingredient)
      :precondition (
        and
          (robot-at ?loc) 
          (location-is-SVA ?loc)
          (robot-holding ?dish_ingredint)

      )
      :effect (
        and 
          (dish-is-served ?dish_ingredint)
          (not (robot-holding ?dish_ingredint))
      )
  )
)