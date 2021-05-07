(define (domain monkey_banana)

  (:requirements
    :typing
    :negative-preconditions
  )

  (:types
    location
    entity
  )

  (:constants
    monkey box knife banana glass watertap
  )

  (:predicates
    (location ?l - location)
    (at ?m - entity ?l - location)
    (low)
    (has_knife)
    (has_banana)
    (has_glass)
    (has_water)
  )

  (:action go
    :parameters (?source ?destination - location)
    :precondition (and (low) (at monkey ?source))
    :effect (and (not (at monkey ?source)) (at monkey ?destination))
  )

  (:action climb_up
    :parameters (?position - location)
    :precondition (and (low) (at monkey ?position) (at box ?position))
    :effect (and (not (low)))
  )

  (:action climb_down
    :parameters (?position - location)
    :precondition (and (not (low)) (at monkey ?position) (at box ?position))
    :effect (and (low))
  )

  (:action take_banana
    :parameters (?position - location)
    :precondition (and (not (low)) (has_knife) (at monkey ?position) (at banana ?position))
    :effect (and (has_banana))
  )

  (:action take_knife
    :parameters (?position - location)
    :precondition (and (at monkey ?position) (at knife ?position))
    :effect (and (has_knife))
  )

  (:action take_glass
    :parameters (?position - location)
    :precondition (and (not (low)) (at monkey ?position) (at glass ?position))
    :effect (and (has_glass))
  )

  (:action release_banana
    :parameters (?position - location)
    :precondition (and (has_banana) (at monkey ?position))
    :effect (and (not (has_banana)) (at banana ?position) (at monkey ?position))
  )

  (:action release_knife
    :parameters (?position - location)
    :precondition (and (has_knife) (at monkey ?position))
    :effect (and (not (has_knife)) (at knife ?position) (at monkey ?position))
  )

  (:action release_glass
    :parameters (?position - location)
    :precondition (and (has_glass) (at monkey ?position))
    :effect (and (not (has_glass)) (at glass ?position) (at monkey ?position))
  )

  (:action push_box
    :parameters (?source ?destination - location)
    :precondition (and (low) (not (has_banana)) (at monkey ?source) (at box ?source))
    :effect (and (at box ?destination) (not (at box ?source)) (at monkey ?destination) (not (at monkey ?source)))
  )

  (:action fetch_water
    :parameters (?position - location)
    :precondition (and (has_glass) (not (low)) (at monkey ?position) (at watertap ?position) (or (not (has_banana)) (not (has_knife))))
    :effect (and (has_water))
  )
)
