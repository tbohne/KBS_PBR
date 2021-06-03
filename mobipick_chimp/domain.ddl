(HybridHTNDomain Mobipick)

(MaxArgs 5)

# PREDICATES
(PredicateSymbols
  # Predicates:
  mobipick_at mobipick_has_arm_posture mobipick_holding on reachable_from
  # Operators:
  !move_base
  !perceive_object
  !pick
  !place
  !move_arm
  !hand_over
  # Methods
  move_object
  get_object
  put_object
)

# OPERATORS

# move_base
(:operator
 (Head !move_base(?source ?destination))
 (Pre p1 mobipick_at(?source))
 (Del p1)
 (Add e1 mobipick_at(?destination))
 (Constraint Duration[4000,INF](task))
)

# move_arm
(:operator
 (Head !move_arm(?arm ?old_posture ?new_posture ?keep_gripper_orientation))
 (Pre p1 mobipick_has_arm_posture(?arm ?old_posture))
 (Del p1)
 (Add e1 mobipick_has_arm_posture(?arm ?new_posture))
 (Constraint Duration[2000,INF](task))
)

# pick
(:operator
 (Head !pick(?object ?area))
 (Pre p1 on(?object ?area))
 (Pre p2 mobipick_at(?waypoint))
 (Pre p3 reachable_from(?area ?waypoint))
 (Pre p4 mobipick_holding(nothing))
 (Del p1)
 (Del p4)
 (Add e1 mobipick_holding(?object))
 (Constraint Duration[2000,INF](task))
)

# place
(:operator
 (Head !place(?object ?area))
 (Pre p1 mobipick_at(?waypoint))
 (Pre p2 mobipick_holding(?object))
 (Pre p3 reachable_from(?area ?waypoint))
 (Del p2)
 (Add e1 mobipick_holding(nothing))
 (Add e2 on(?object ?area))
 (Constraint Duration[2000,INF](task))
)

# move object to destination area
(:method
  (Head move_object(?object ?toArea))
  (Pre p1 on(?object ?fromArea))
  (Sub s1 get_object(?object ?fromArea))
  (Sub s2 put_object(?object ?toArea))
  (Ordering s1 s2)
  (Constraint Before(s1,s2))
  (Constraint Starts(s1,task))
  (Constraint Finishes(s2,task))
  (Constraint Duration[20000,INF](task))
)

(:method
  (Head get_object(?object ?fromArea))
  (Pre p1 on(?object ?fromArea))
  (Pre p2 mobipick_at(?waypoint))
  (Pre p3 reachable_from(?fromArea ?destination))
  (Sub s1 !move_base(?waypoint ?destination))
  (Sub s2 !pick(?object ?fromArea))
  (Ordering s1 s2)
  (Constraint Before(s1,s2))
  (Constraint Starts(s1,task))
  (Constraint Finishes(s2,task))
)

(:method
  (Head put_object(?object ?toArea))
  (Pre p1 mobipick_holding(?object))
  (Pre p2 mobipick_at(?waypoint))
  (Pre p3 reachable_from(?toArea ?destination))
  (Sub s1 !move_base(?waypoint ?destination))
  (Sub s2 !place(?object ?toArea))
  (Ordering s1 s2)
  (Constraint Before(s1,s2))
  (Constraint Starts(s1,task))
  (Constraint Finishes(s2,task))
)
