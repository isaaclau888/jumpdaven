extends Node2D

var platform = preload("res://instances/platform_2.tscn") 
var obstacle_scene = preload("res://scenes/obstacle.tscn")

var width: float
var highest_y = 0.0

var spawn_buffer = 2000.0  

var win_height = -2000.0  

@export var camera: Camera2D

var spawn_timer = 0.0
var obstacle_interval = 2.0

func _ready():
	width = get_viewport().get_visible_rect().size.x
	spawn_platforms_up_to(-spawn_buffer)

func _process(delta):
	if camera:
		var target_y = camera.global_position.y - spawn_buffer
		if target_y < highest_y:
			spawn_platforms_up_to(target_y)
			
		spawn_timer += delta
		if spawn_timer >= obstacle_interval:
			spawn_timer = 0.0
			spawn_obstacle()

func spawn_platforms_up_to(limit_y: float):
	while highest_y > limit_y and highest_y >= (win_height - 300.0):
		var new_platform = platform.instantiate()
		new_platform.position = Vector2(randf_range(-width / 2.0, width / 2.0), highest_y)
		add_child(new_platform)
		
		highest_y -= randf_range(30, 80)

func spawn_obstacle():
	if not camera:
		return
		
	var obstacle = obstacle_scene.instantiate()
	var spawn_x = randf_range(-width / 2.0, width / 2.0)
	var spawn_y = camera.global_position.y - 400.0 
	
	obstacle.position = Vector2(spawn_x, spawn_y)
	add_child(obstacle)
