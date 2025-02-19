extends Node2D

func _process(delta: float) -> void:
	# Reload with R
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file("res://scenes/first_level.tscn")
