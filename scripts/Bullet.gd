extends KinematicBody2D

const speed = 800

export var smokeScene : PackedScene
export var bulletImpact : PackedScene

var direction = Vector2.ZERO

func _ready():
	set_as_toplevel(true)

func _process(delta):
	var collisionResult = move_and_collide(direction * speed * delta)
	if collisionResult != null:
		queue_free()
func hit():
	queue_free()
