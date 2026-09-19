extends RigidBody2D

@export var camera: Camera2D

var jump_speed = 900.0
var speed = 300.0

var width: float
var height: float

var win_height = -2000.0

@onready var sprite = $Sprite2D

var move_dir = 0.0
var should_jump = false

func _ready():
	lock_rotation = true
	
	var viewport_size = get_viewport().get_visible_rect().size
	width = viewport_size.x
	height = viewport_size.y

func _process(_delta):
	move_dir = Input.get_axis("ui_left", "ui_right")

	if move_dir < 0:
		sprite.flip_h = true
	elif move_dir > 0:
		sprite.flip_h = false

func collision(body):
	if body.is_in_group("Paddles"):
		should_jump = true

func _integrate_forces(state):
	state.linear_velocity.x = move_dir * speed

	if should_jump:
		if state.linear_velocity.y >= -10:
			state.linear_velocity.y = -jump_speed
		should_jump = false

	var current_pos = state.transform.origin

	if current_pos.y <= win_height:
		print("Reached top! Loading win screen...")
		get_tree().call_deferred("change_scene_to_file", "res://scenes/win_screen.tscn")

	if camera:
		var camera_bottom = camera.global_position.y + (height / 2.0)
		if current_pos.y > camera_bottom:
			get_tree().call_deferred("reload_current_scene")
	else:
		if current_pos.y > 1000:
			get_tree().call_deferred("reload_current_scene")

	var half_width = width / 2.0
	if current_pos.x > half_width and state.linear_velocity.x > 0:
		state.transform.origin.x = -half_width
	elif current_pos.x < -half_width and state.linear_velocity.x < 0:
		state.transform.origin.x = half_width
