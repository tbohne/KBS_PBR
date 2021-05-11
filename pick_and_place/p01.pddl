(define (problem p01)
    (:domain pick_and_place)
    (:objects
        r2d2 - robot
        arm - gripper
        l1 l2 l3 l4 l5 l6 - location
        o1 o2 o3 o4 - object
    )
    (:init
        (at r2d2 l6)
        (gripper_is_free arm)
        (on o1 l1)
        (on o2 l4)
        (on o3 l4)
        (on o4 l3)
    )
    (:goal (and (on o1 l6) (on o2 l6) (on o3 l6) (on o4 l6)))
)
