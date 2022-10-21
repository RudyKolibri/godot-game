extends Node2D
onready var test = $"../../pointer"
func _physics_process(delta):
	look_at(test.position)
