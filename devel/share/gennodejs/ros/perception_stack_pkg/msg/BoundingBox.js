// Auto-generated. Do not edit!

// (in-package perception_stack_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class BoundingBox {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.x1 = null;
      this.y1 = null;
      this.x2 = null;
      this.y2 = null;
      this.confidence = null;
      this.class_name = null;
      this.class_id = null;
      this.x = null;
      this.y = null;
      this.width = null;
      this.height = null;
      this.speed = null;
      this.direction = null;
    }
    else {
      if (initObj.hasOwnProperty('x1')) {
        this.x1 = initObj.x1
      }
      else {
        this.x1 = 0;
      }
      if (initObj.hasOwnProperty('y1')) {
        this.y1 = initObj.y1
      }
      else {
        this.y1 = 0;
      }
      if (initObj.hasOwnProperty('x2')) {
        this.x2 = initObj.x2
      }
      else {
        this.x2 = 0;
      }
      if (initObj.hasOwnProperty('y2')) {
        this.y2 = initObj.y2
      }
      else {
        this.y2 = 0;
      }
      if (initObj.hasOwnProperty('confidence')) {
        this.confidence = initObj.confidence
      }
      else {
        this.confidence = 0.0;
      }
      if (initObj.hasOwnProperty('class_name')) {
        this.class_name = initObj.class_name
      }
      else {
        this.class_name = '';
      }
      if (initObj.hasOwnProperty('class_id')) {
        this.class_id = initObj.class_id
      }
      else {
        this.class_id = 0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0;
      }
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0.0;
      }
      if (initObj.hasOwnProperty('direction')) {
        this.direction = initObj.direction
      }
      else {
        this.direction = new geometry_msgs.msg.Vector3();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BoundingBox
    // Serialize message field [x1]
    bufferOffset = _serializer.int32(obj.x1, buffer, bufferOffset);
    // Serialize message field [y1]
    bufferOffset = _serializer.int32(obj.y1, buffer, bufferOffset);
    // Serialize message field [x2]
    bufferOffset = _serializer.int32(obj.x2, buffer, bufferOffset);
    // Serialize message field [y2]
    bufferOffset = _serializer.int32(obj.y2, buffer, bufferOffset);
    // Serialize message field [confidence]
    bufferOffset = _serializer.float32(obj.confidence, buffer, bufferOffset);
    // Serialize message field [class_name]
    bufferOffset = _serializer.string(obj.class_name, buffer, bufferOffset);
    // Serialize message field [class_id]
    bufferOffset = _serializer.int32(obj.class_id, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.int32(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.int32(obj.y, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.int32(obj.width, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.int32(obj.height, buffer, bufferOffset);
    // Serialize message field [speed]
    bufferOffset = _serializer.float32(obj.speed, buffer, bufferOffset);
    // Serialize message field [direction]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.direction, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BoundingBox
    let len;
    let data = new BoundingBox(null);
    // Deserialize message field [x1]
    data.x1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [y1]
    data.y1 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [x2]
    data.x2 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [y2]
    data.y2 = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [confidence]
    data.confidence = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [class_name]
    data.class_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [class_id]
    data.class_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [speed]
    data.speed = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [direction]
    data.direction = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.class_name);
    return length + 72;
  }

  static datatype() {
    // Returns string type for a message object
    return 'perception_stack_pkg/BoundingBox';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b3294fcf8c14633436ae2e0b4ba8ac4c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 x1
    int32 y1
    int32 x2
    int32 y2
    float32 confidence
    string class_name
    int32 class_id
    int32 x
    int32 y
    int32 width
    int32 height
    float32 speed
    geometry_msgs/Vector3 direction
    
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BoundingBox(null);
    if (msg.x1 !== undefined) {
      resolved.x1 = msg.x1;
    }
    else {
      resolved.x1 = 0
    }

    if (msg.y1 !== undefined) {
      resolved.y1 = msg.y1;
    }
    else {
      resolved.y1 = 0
    }

    if (msg.x2 !== undefined) {
      resolved.x2 = msg.x2;
    }
    else {
      resolved.x2 = 0
    }

    if (msg.y2 !== undefined) {
      resolved.y2 = msg.y2;
    }
    else {
      resolved.y2 = 0
    }

    if (msg.confidence !== undefined) {
      resolved.confidence = msg.confidence;
    }
    else {
      resolved.confidence = 0.0
    }

    if (msg.class_name !== undefined) {
      resolved.class_name = msg.class_name;
    }
    else {
      resolved.class_name = ''
    }

    if (msg.class_id !== undefined) {
      resolved.class_id = msg.class_id;
    }
    else {
      resolved.class_id = 0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0
    }

    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0.0
    }

    if (msg.direction !== undefined) {
      resolved.direction = geometry_msgs.msg.Vector3.Resolve(msg.direction)
    }
    else {
      resolved.direction = new geometry_msgs.msg.Vector3()
    }

    return resolved;
    }
};

module.exports = BoundingBox;
