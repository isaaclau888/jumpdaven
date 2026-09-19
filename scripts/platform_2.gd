extends StaticBody2D

func _process(_delta):
	var camera = get_viewport().get_camera_2d()
	if camera:
		if global_position.y > camera.global_position.y + 600:
			queue_free()
