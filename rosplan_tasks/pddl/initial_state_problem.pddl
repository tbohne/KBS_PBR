(define (problem task)
(:domain kbs_demo)
(:objects
    wp0 wp1 wp2 wp3 wp4 wp5 - waypoint
    mobipick - robot
    cylinder - object
)
(:init
    (robot_at mobipick wp0)
    (object_at cylinder wp1)
    (gripper_free mobipick)
)
(:goal (and
        (object_at cylinder wp2)
    )
)
)
