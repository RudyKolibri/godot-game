extends KinematicBody2D

export var move_speed : = 250.0
export var push_speed : = 125.0
onready var pointer = $"../pointer"
onready var dash = $dash
onready var sprite = $Sprite
const dash_speed = 3000
const dash_duration = 0.2
signal shake
var vector = Vector2()
var hp = 10
func _physics_process(_delta: float) -> void:
	var input := Vector2()
	vector.x = 0
	vector.y = 0
	look_at(pointer.position)
	input.x = float(Input.get_action_strength("move_right")) - float(Input.get_action_strength("move_left"))
	input.y = float(Input.get_action_strength("move_down")) - float(Input.get_action_strength("move_up"))
	if Input.is_action_just_pressed("dash"):
		if not dash.is_dashing() and dash.candash():
			$hurtbox/CollisionShape2D.disabled = true
			$dashattack/CollisionShape2D.disabled = false
			$ScreenShake/CollisionShape2D.disabled = false
			dash.start_dash(sprite, dash_duration)
	var speed = 0
	if dash.is_dashing():
		speed = dash_speed
	else:
		speed= move_speed
	if dash.is_dashing() and input.normalized() == vector:
		input = - (self.position - global_position).normalized()
		print(input)
	var _bla = move_and_slide(input.normalized() * speed, Vector2())
	if get_slide_count() > 0:
		check_box_collision(input)
func check_box_collision(input: Vector2) -> void:
	if abs(input.x) + abs(input.y) > 1:
		return
	var box : = get_slide_collision(0).collider as Box
	if box:
		box.push(push_speed * input)
func _on_hurtbox_body_entered(body):
	if body.is_in_group("bulletenemy"):
		hp -= 1
		if hp == 0:
			var _bla = get_tree().reload_current_scene()
		body.hit()
func _on_dash_dashdone():
	$hurtbox/CollisionShape2D.disabled = false
	$dashattack/CollisionShape2D.disabled = true
	$ScreenShake/CollisionShape2D.disabled = true
func _on_ScreenShake_body_entered(_body):
	emit_signal("shake")
