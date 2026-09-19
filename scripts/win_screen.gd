extends Control

func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
