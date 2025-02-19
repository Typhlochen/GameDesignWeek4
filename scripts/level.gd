extends Node2D
@onready var sfx_bgm: AudioStreamPlayer = $sfx_bgm

@export var current_scene_path = "res://scenes/first_level.tscn"

func _ready():
	sfx_bgm.play()

func _process(delta: float) -> void:
	# Reload with R
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file(current_scene_path)

func _on_dead_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file(current_scene_path)
