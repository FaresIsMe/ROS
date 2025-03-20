#!/usr/bin/env python3

import rospy
from std_msgs.msg import String

def talker():
    pub = rospy.Publisher('chatter', String, queue_size = 10)
    rospy.init_node('talker', anonymous = True) #The anonymous=True parameter ensures that the node has a unique name by adding random numbers to the end.
    rate = rospy.Rate(1)
    while not rospy.is_shutdown():
        hello_string = "This is 911 what's your emergency? %s" % rospy.get_time()
        rospy.loginfo(hello_string)
        pub.publish(hello_string)
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass

    