(define (domain pick_and_place)
    (:requirements :typing)
    (:types
        location
        robot
        object
        gripper
    )

    (:predicates
        (at ?r - robot ?l - location)
        (on ?o - object ?l - location)
        (holding ?g - gripper ?o - object)
        (gripper_is_free ?g - gripper)
        (heavy ?o - object)
        (perceived ?o - object ?l - location)
    )

    (:action move
        :parameters (?source ?destination - location ?r - robot ?g - gripper)
        :precondition (and (at ?r ?source))
        :effect (and (not (at ?r ?source)) (at ?r ?destination))
    )

    (:action perceive_object
        :parameters (?o - object ?l - location ?r - robot ?g - gripper)
        :precondition (and (at ?r ?l) (on ?o ?l) (gripper_is_free ?g) (not (perceived ?o ?l)))
        :effect (and (perceived ?o ?l))
    )

    (:action pick
        :parameters (?o - object ?l - location ?r - robot ?g - gripper)
        :precondition (and (on ?o ?l) (at ?r ?l) (perceived ?o ?l) (gripper_is_free ?g) (not (heavy ?o)))
        :effect (and (holding ?g ?o) (not (on ?o ?l)) (not (gripper_is_free ?g)))
    )

    (:action place
        :parameters (?o - object ?l - location ?g - gripper ?r - robot)
        :precondition (and (at ?r ?l) (holding ?g ?o))
        :effect (and (gripper_is_free ?g) (on ?o ?l) (not (holding ?g ?o)))
    )
)
