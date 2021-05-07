(define (problem p01)

  (:domain monkey_banana)

  (:objects
    p1 p2 p3 p4 p5 p6 - location
    banana monkey box knife watertap glass - entity
  )

  (:init
    (at monkey p1)
    (low)
    (not(has_banana))
    (not(has_knife))
    (not(has_water))
    (not(has_glass))
    (at banana p3)
    (at box p2)
    (at knife p4)
    (at watertap p5)
    (at glass p5)
  )

  (:goal
    (and (has_banana) (has_water) (or (and (at box p1) (at knife p1)) (and (at box p6) (at knife p6))))
  )
)
