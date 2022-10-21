extends RigidBody2D

const speed = 500

export var smokeScene : PackedScene
export var bulletImpact : PackedScene

var direction = Vector2.ZERO
var firstrun = true
var bounci = 0
var max_bounci = 4
func _ready():
	set_as_toplevel(true)


func _integrate_forces(_state):

	if firstrun == true:
		firstrun = false
		linear_velocity = direction * speed
		print(get_bounce())
		set_bounce(1)
		set_friction(0)

func hit():
	queue_free()

func _on_hitcheck_body_entered(body):

	if not body.is_in_group("map"):
		queue_free()
	else:
		bounci += 1
		if bounci >= max_bounci:
			queue_free()


func _on_selfkill_body_entered(body):
	if body.is_in_group("map"):
		queue_free()
