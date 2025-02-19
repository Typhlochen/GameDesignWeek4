extends Control
@onready var sfx_click: AudioStreamPlayer = $sfx_click
@onready var sfx_game_over: AudioStreamPlayer = $sfx_GameOver

func _ready():
	sfx_game_over.play()

func _on_retry_pressed() -> void:
	sfx_click.play()
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()

func _on_main_menu_pressed() -> void:
	sfx_click.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	queue_free()
