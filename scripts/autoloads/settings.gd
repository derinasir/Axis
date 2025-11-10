extends Node


var mouse_sensitivity := 2.0
var gamepad_sensitivity := 5.0
var camera_invert_h := false
var camera_invert_v := false


var connected_gamepads: Array = Input.get_connected_joypads()

func has_connected_gamepads() -> bool:
	return connected_gamepads.size() != 0

func _init() -> void:
	if has_connected_gamepads():
		print("Gamepads connected: " + str(connected_gamepads))
	else:
		print("No gamepads connected")
