(define (domain kbs_demo)

(:requirements :strips :typing :fluents :disjunctive-preconditions :durative-actions)

(:types
	waypoint
	robot
	object
)

(:predicates
	(robot_at ?r - robot ?wp - waypoint)
    (object_at ?o - object ?wp - waypoint)
    (holding ?r - robot ?o - object)
    (still ?r - robot)
    (gripper_free ?r - robot)
)

; move between any two waypoints
(:durative-action move_base
	:parameters (?r - robot ?from ?to - waypoint)
	:duration ( = ?duration 10)
	:condition (and
		(at start (robot_at ?r ?from))
	)
	:effect (and
		(at start (not (robot_at ?r ?from)))
		(at start (not (still ?r)))
		(at end (robot_at ?r ?to))
		(at end (still ?r))
	)
)

; pick object
(:durative-action pick
    :parameters (?o - object ?wp - waypoint ?r - robot)
    :duration ( = ?duration 10)
    :condition (and
    	(at start (object_at ?o ?wp))
    	(at start (robot_at ?r ?wp))
    	(at start (gripper_free ?r))
    	(over all (still ?r))
    )
    :effect (and
    	(at end (holding ?r ?o))
    	(at end (not (object_at ?o ?wp)))
    	(at end (not (gripper_free ?r)))
    )
)

; place object and retract arm
(:durative-action place
	:parameters (?o - object ?wp - waypoint ?r - robot)
	:duration ( = ?duration 10)
	:condition (and
		(at start (robot_at ?r ?wp))
		(at start (holding ?r ?o))
		(over all (still ?r))
	)
	:effect (and
		(at end (gripper_free ?r))
		(at end (object_at ?o ?wp))
		(at end (not (holding ?r ?o)))
	)
)

)
