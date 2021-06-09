(HybridHTNDomain Mobipick)

(MaxArgs 5) # for fluents

(PredicateSymbols
  # predicates
  mobipick_at worker_at mobipick_has_arm_posture mobipick_holding on reachable_from
  # operators
  !move_base !perceive_object !pick !place !move_arm !hand_over
  # methods
  move_object get_object put_object bring
)

###################################################################
############################ OPERATORS ############################
###################################################################

# move_base
(:operator
  (Head !move_base(?source ?destination))
  (Pre p1 mobipick_at(?source))
  (VarDifferent ?source ?destination)
  (Pre p2 mobipick_has_arm_posture(tucked_posture))
  (Del p1)
  (Add e1 mobipick_at(?destination))
  (Constraint Duration[4000,INF](task))
)

# perceive_object
(:operator
  (Head !perceive_object(?object ?location))
  (Pre p1 mobipick_at(?location))
  (Pre p2 on(?object ?area))
  (Pre p3 reachable_from(?area ?location))
  (Add e1 mobipick_has_arm_posture(undefined_posture))
  (Constraint Duration[4000,INF](task))
)

# move_arm
(:operator
  (Head !move_arm(?old_posture ?new_posture))
  (Pre p1 mobipick_has_arm_posture(?old_posture))
  (VarDifferent ?old_posture ?new_posture)
  (Del p1)
  (Add e1 mobipick_has_arm_posture(?new_posture))
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

# hand_over
(:operator
  (Head !hand_over(?object))
  (Pre p1 worker_at(?waypoint))
  (Pre p2 mobipick_at(?waypoint))
  (Pre p3 mobipick_holding(?object))
  (Del p3)
  (Add e1 mobipick_holding(nothing))
  (Constraint Duration[2000,INF](task))
)

###################################################################
############################# METHODS #############################
###################################################################

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

# get_object -> already at correct waypoint
(:method
  (Head get_object(?object ?fromArea))
  (Pre p1 on(?object ?fromArea))
  (Pre p2 reachable_from(?fromArea ?destination))
  (Pre p3 mobipick_at(?destination))
  (Sub s1 !perceive_object(?object ?destination))
  (Sub s2 !pick(?object ?fromArea))
  (Ordering s1 s2)
  (Constraint Starts(s1,task))
  (Constraint Before(s1,s2))
  (Constraint Finishes(s2,task))
)

# get_object -> needs to move there
(:method
  (Head get_object(?object ?fromArea))
  (Pre p1 on(?object ?fromArea))
  (Pre p2 mobipick_at(?waypoint))
  (Pre p3 reachable_from(?fromArea ?destination))
  (Sub s1 !move_arm(undefined_posture tucked_posture))
  (Sub s2 !move_base(?waypoint ?destination))
  (Sub s3 !perceive_object(?object ?destination))
  (Sub s4 !pick(?object ?fromArea))
  (Ordering s1 s2)
  (Ordering s2 s3)
  (Ordering s3 s4)
  (Constraint Before(s1,s2))
  (Constraint Before(s2,s3))
  (Constraint Before(s3,s4))
  (Constraint Starts(s1,task))
  (Constraint Finishes(s4,task))
)

# put_object -> already at correct waypoint
(:method
  (Head put_object(?object ?toArea))
  (Pre p1 mobipick_holding(?object))
  (Pre p2 reachable_from(?toArea ?destination))
  (Pre p3 mobipick_at(?destination))
  (Sub s1 !place(?object ?toArea))
  (Constraint Starts(s1,task))
)

# put_object -> needs to move there
(:method
  (Head put_object(?object ?toArea))
  (Pre p1 mobipick_holding(?object))
  (Pre p2 mobipick_at(?waypoint))
  (Pre p3 reachable_from(?toArea ?destination))
  (Sub s1 !move_arm(undefined_posture tucked_posture))
  (Sub s2 !move_base(?waypoint ?destination))
  (Sub s3 !place(?object ?toArea))
  (Ordering s1 s2)
  (Ordering s2 s3)
  (Constraint Before(s1,s2))
  (Constraint Before(s2,s3))
  (Constraint Starts(s1,task))
  (Constraint Finishes(s3,task))
)

# bring object to worker
(:method
  (Head bring(?object))
  (Pre p1 on(?object ?fromArea))
  (Pre p2 worker_at(?destination))
  (Pre p3 mobipick_at(?source))
  (Sub s1 get_object(?object ?fromArea))
  (Sub s2 !move_arm(undefined_posture tucked_posture))
  (Sub s3 !move_base(?source ?destination))
  (Sub s4 !hand_over(?object))
  (Ordering s1 s2)
  (Ordering s2 s3)
  (Ordering s3 s4)
  (Constraint Before(s1,s2))
  (Constraint Before(s2,s3))
  (Constraint Before(s3,s4))
  (Constraint Starts(s1,task))
  (Constraint Finishes(s4,task))
  (Constraint Duration[20000,INF](task))
)
