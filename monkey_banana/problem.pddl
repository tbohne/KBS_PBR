(define (problem p01)

  (:domain monkey_banana)

  (:objects
    p1 p2 p3 p4 p5 p6 - location
  )

  (:init
    (at_monkey p1)
  )

  (:goal
    (and (at_monkey p5)
    )
  )
)
