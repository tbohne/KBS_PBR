#!/usr/bin/env python3

import rospy
import actionlib_msgs.msg

from rosplan_planning_system.ActionInterfacePy.RPActionInterface import RPActionInterface

from high_level_robot_api import robot as robot_class


class RPPickPy(RPActionInterface):


    def __init__(self):
        # call parent constructor
        RPActionInterface.__init__(self)
        # instantiating Robot object
        self.robot = robot_class.Robot(enabled_components=['manipulation'])


    def concreteCallback(self, msg):

        rospy.loginfo("msg: %s", msg)
        object_to_pick = msg.parameters[0].value

        # send manipulation goal
        if self.robot.manipulation.pick(object_to_pick):
            rospy.loginfo('goal was achieved!')
            self.robot.manipulation.go_to_pose("home", wait=True)
            return True
        else:
            rospy.loginfo('goal was not achieved')
            return False

def main():
    rospy.init_node('rosplan_interface_pick', anonymous=False)
    rppick = RPPickPy()
    rppick.runActionInterface()
