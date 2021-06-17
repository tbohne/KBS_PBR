#!/usr/bin/env python3

import rospy, tf, actionlib
import actionlib_msgs.msg

from rosplan_planning_system.ActionInterfacePy.RPActionInterface import RPActionInterface
from std_srvs.srv import Empty
from geometry_msgs.msg import PoseStamped
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal

from high_level_robot_api import robot as robot_class


# dictionary of waypoints to poses (position + orientation)
DICT = {
    'wp0': [15.383493, 2.940689, [0.0, 0.0, 0.0, 1.0]], # robot start pos
    'wp1': [18.022, 4.014, [0.0, 0.0, 1.0, 0.008]], # source table
    'wp2': [19.9902, 8.0762, [0.0, 0.0, 1.0, 0.008]], # goal table
    'wp3': [18.022, 4.014, [0.0, 0.0, 1.0, 0.008]],
    'wp4': [18.022, 4.014, [0.0, 0.0, 1.0, 0.008]],
    'wp5': [18.022, 4.014, [0.0, 0.0, 1.0, 0.008]]
}


class RPMoveBasePy(RPActionInterface):
    def __init__(self):
        # call parent constructor
        RPActionInterface.__init__(self)
        # get waypoints reference frame from param server
        self.waypoint_frameid = rospy.get_param('~waypoint_frameid', 'map')
        self.wp_namespace = rospy.get_param('~wp_namespace', '/rosplan_demo_waypoints/wp')
        # instantiating Robot object
        self.robot = robot_class.Robot(enabled_components=['navigation'])

    def concreteCallback(self, msg):

        # parameters: (0: robot, 1: source pos, 2: goal pos)
        rospy.loginfo("msg: %s", msg.parameters[2].value)
        goal_coords = DICT[msg.parameters[2].value]

        # send navigation goal
        if self.robot.navigation.go_to_2d_pose(x=goal_coords[0], y=goal_coords[1], quaternion=goal_coords[2], timeout=40.0):
            rospy.loginfo('goal pos %s reached!', goal_coords)
            return True
        else:
            rospy.loginfo('goal was not achieved')
            return False

def main():
    rospy.init_node('rosplan_interface_movebase', anonymous=False)
    rpmb = RPMoveBasePy()
    rpmb.runActionInterface()
