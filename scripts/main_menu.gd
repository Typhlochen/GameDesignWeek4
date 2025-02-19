extends Control
@onready var sfx_bgm: AudioStreamPlayer = $sfx_bgm
@onready var sfx_click: AudioStreamPlayer = $sfx_click

func _ready():
	sfx_bgm.play()
	if Global.level1_completed:
		$"VBoxContainer/Level 2".disabled = false  # Enable Level 2 button

func _on_level_1_pressed() -> void:
	sfx_click.play()
	get_tree().change_scene_to_file("res://scenes/first_level.tscn")


func _on_level_2_pressed() -> void:
	sfx_click.play()
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	sfx_click.play()
	get_tree().quit()
