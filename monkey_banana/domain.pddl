(define (domain monkey_banana)

  (:requirements
    :typing
    :negative-preconditions
  )

  (:types
    location
  )

  (:predicates
    (at_monkey ?l - location)
  )

  (:action move_monkey
    :parameters (?source ?destination - location)
    :precondition (at_monkey ?source)
    :effect (and (not (at_monkey ?source))
                 (at_monkey ?destination)
            )
  )
)
