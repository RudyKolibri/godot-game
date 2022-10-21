extends Node2D
var can_dash = true
export var ghost_scene : PackedScene
onready var duration_timer = $Durationtimer
onready var ghost_timer = $GhostTimer
const dash_delay = 5
signal dashdone
var sprite
func _ready():
	duration_timer.connect("timeout", self, "_on_Durationtimer_timeout")
func start_dash(sprites, duration):
	duration_timer.wait_time = duration
	duration_timer.start()
	ghost_timer.start()
	self.sprite = sprites
	instance_ghost()
func is_dashing():
	return !duration_timer.is_stopped()
func candash():
	return can_dash
func end_dash():
	ghost_timer.stop()
	can_dash = false
	emit_signal("dashdone")
	yield(get_tree().create_timer(dash_delay), 'timeout')
	can_dash = true


func _on_Durationtimer_timeout():
	end_dash()
func instance_ghost():
	var ghost: Sprite = ghost_scene.instance()
	get_parent().get_parent().add_child(ghost)
	ghost.scale.x = 0.5
	ghost.scale.y = 0.5
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h


func _on_GhostTimer_timeout():
	instance_ghost()
