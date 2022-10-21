
extends Node2D

signal shake
signal shakeshotgun
signal shootgun1
signal shootgun2
signal shootgun3
var gun = 3
var direction
onready var pos = $".."
func _unhandled_input(event):
	var posit = pos.position
	var global = global_position
	match gun:
		1:
			$gun1.visible
			$gun2.hide()
			$gun3.hide()
		2:
			$gun1.hide()
			$gun3.hide()
			$gun2.visible
		3:
			$gun1.hide()
			$gun3.visible
			$gun2.hide()
	if (event.is_action_pressed("fire")):
		match gun:
			1:
				emit_signal("shootgun1", posit , global)
				emit_signal("shake")
			2:
				emit_signal("shootgun2", posit , global)
				emit_signal("shakeshotgun")
			3:
				emit_signal("shootgun3", posit , global)
				emit_signal("shake")
		
