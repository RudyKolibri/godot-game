extends Node2D
var direction = null
onready var pos = $"../../../Player"
var can_shout = true

signal shake
signal shootgun1
signal shootgun2
signal shootgun3

var gun = 3

func _physics_process(_delta):
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
	if $RayCast2D.is_colliding() and can_shout == true:
		can_shout = false
		$Timer.stop()
		$Timer.start()
		match gun:
			1:
				emit_signal("shake")
				emit_signal("shootgun1", posit , global)
			2:
				emit_signal("shake")
				emit_signal("shootgun2", posit , global)
			3:
				emit_signal("shake")
				emit_signal("shootgun3", posit , global)
func _ready():
	var _bla = $Timer.connect("timeout", self, "timeout")
	
func timeout():
	can_shout = true


func _on_enemy_gun(gunn):
	self.gun = gunn
