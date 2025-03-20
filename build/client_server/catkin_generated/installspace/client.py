#!/usr/bin/env python3

import rospy
from std_srvs.srv import SetBool, SetBoolRequest
from client_server.srv import mult, multRequest

def client():
    rospy.init_node('client')
    client = rospy.ServiceProxy('mult_server', mult)
    rospy.wait_for_service('mult_server')

    request = multRequest()
    
    request.a = 5
    request.b = 10
    response = client(request)
    print(response.result)
    print("------------")

    request.a = 3
    request.b = -7
    response = client(request)
    print(response.result)

if __name__ == '__main__':
    client()    
