#!/usr/bin/env python3

import rospy
import actionlib_msgs.msg

from rosplan_planning_system.ActionInterfacePy.RPActionInterface import RPActionInterface

from high_level_robot_api import robot as robot_class


class RPPlacePy(RPActionInterface):


    def __init__(self):
        # call parent constructor
        RPActionInterface.__init__(self)
        # instantiating Robot object
        self.robot = robot_class.Robot(enabled_components=['manipulation'])


    def concreteCallback(self, msg):

        rospy.loginfo("msg: %s", msg)

        # send manipulation goal
        self.robot.manipulation.go_to_pose("place", wait=True)
        if self.robot.manipulation.open_gripper():
            rospy.loginfo('goal was achieved!')
            # to not knock over the cylinder - go up a bit before home
            self.robot.manipulation.go_to_pose("up", wait=True)
            self.robot.manipulation.go_to_pose("home", wait=True)
            return True
        else:
            rospy.loginfo('goal was not achieved')
            return False

def main():
    rospy.init_node('rosplan_interface_place', anonymous=False)
    rpplace = RPPlacePy()
    rpplace.runActionInterface()
