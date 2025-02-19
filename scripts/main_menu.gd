extends Control

func _ready():
	if Global.level1_completed:
		$"VBoxContainer/Level 2".disabled = false  # Enable Level 2 button

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/first_level.tscn")


func _on_level_2_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
