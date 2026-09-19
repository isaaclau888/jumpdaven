extends Area2D

@export var fall_speed = 250.0

func _process(delta):
	position.y += fall_speed * delta
	
	var camera = get_viewport().get_camera_2d()
	if camera and global_position.y > camera.global_position.y + 600:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player") or body.name.begins_with("Player"):
		get_tree().call_deferred("reload_current_scene")
