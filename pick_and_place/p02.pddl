(define (problem p02)
    (:domain pick_and_place)
    (:objects
        r2d2 - robot
        arm - gripper
        l1 l2 l3 l4 l5 l6 - location
        o1 o2 o3 o4 - object
    )
    (:init
        (at r2d2 l1)
        (gripper_is_free arm)
        (on o1 l1)
        (on o2 l1)
        (on o3 l1)
        (on o4 l1)
    )
    (:goal (and (on o1 l5) (on o2 l5) (on o3 l6) (on o4 l6)))
)
