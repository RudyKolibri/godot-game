extends KinematicBody2D
var state = "MOUSE"
var move_speed
var multi = 50
var mousevector = Vector2.ZERO
onready var target = position
var vector = Vector2.ZERO
onready var player = $"../Player"
var slowmo_active: bool = false

func _physics_process(delta):
	calculate_speed(delta)
	if state == "MOUSE":
		mouse()
	if state == "GAMEPAD":
		vector = gamepad()
	var input := Vector2()
	input.x = float(Input.get_action_strength("move_right")) - float(Input.get_action_strength("move_left"))
	input.y = float(Input.get_action_strength("move_down")) - float(Input.get_action_strength("move_up"))

	var _bla = move_and_slide(input.normalized() * move_speed, Vector2())
	var _bla2 = move_and_slide(vector.normalized() * move_speed, Vector2())
	
func mouse():
	target = get_global_mouse_position()
	mousevector = position.direction_to(target)
	if position.distance_to(target) > 5:
		mousevector = move_and_slide(mousevector * move_speed)
		
func gamepad() -> Vector2:
	var input := Vector2()
	input.x = float(Input.get_action_strength("aim_right")) - float(Input.get_action_strength("aim_left"))
	input.y = float(Input.get_action_strength("aim_down")) - float(Input.get_action_strength("aim_up"))

	return input
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		state = "MOUSE"
	if (event.is_action_pressed("aim_right")) or (event.is_action_pressed("aim_left")) or (event.is_action_pressed("aim_up") or (event.is_action_pressed("aim_down"))):
		state = "GAMEPAD"

func _on_map_pointer2player():
	self.position = player.position

func calculate_speed(_delta):
	var r = position.distance_to(player.position)
	var edge = (r * 2) * 3.14
	var speed = edge / 3
	move_speed = speed * 4
