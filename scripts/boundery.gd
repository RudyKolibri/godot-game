extends KinematicBody2D

onready var player = $"../Player"

func _physics_process(_delta):
	self.position = player.position
