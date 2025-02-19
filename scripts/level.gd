extends Node2D

@export var current_scene_path = "res://scenes/first_level.tscn"

func _process(delta: float) -> void:
	# Reload with R
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file(current_scene_path)

func _on_dead_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file(current_scene_path)
