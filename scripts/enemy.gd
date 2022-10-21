extends KinematicBody2D

onready var path_to_player := get_node("../../Player")

var _velocity := Vector2.ZERO
signal shake
onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _timer := $Timer
onready var _sprite := $Sprite
export var move_speed : = 100
onready var _player := get_node("../../Player")
signal gun

func _ready() -> void:
	var gun = 1 + randi() % 3 # returns a number between 0 and 3
	var _bla = _timer.connect("timeout", self, "_update_pathfinding")
	emit_signal("gun", gun)
	
func _physics_process(_delta: float) -> void:
	look_at(_player.position)
	if _agent.is_navigation_finished():
		return

	var target_global_position := _agent.get_next_location()
	_velocity = global_position.direction_to(target_global_position) * move_speed
	
	_velocity = move_and_slide(_velocity)
	
func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_position)

func _on_hurtbox_body_entered(body):
	if body.is_in_group("bullet"):
		queue_free()
		body.hit()


func _on_bulletspawn_enemy_shake():
	emit_signal("shake")
