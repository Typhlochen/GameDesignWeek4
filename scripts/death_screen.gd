extends Control

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	queue_free()
