#!/usr/bin/env python3

import rospy
from client_server.srv import mult, multResponse


def callback(request):
    response = multResponse()
    response.result = request.a * request.b
    return response


def server():
    rospy.init_node('server2')
    rospy.Service('mult_server', mult, callback)
    rospy.spin()

if __name__ == '__main__':
    server()
