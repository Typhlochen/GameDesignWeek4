extends Node2D
@onready var sfx_bgm: AudioStreamPlayer = $sfx_bgm

@export var current_scene_path = "res://scenes/first_level.tscn"
# Death and Win Screens
var death_screen = preload("res://scenes/death_screen.tscn")
var win_screen = preload("res://scenes/win_screen.tscn")

func _ready():
	sfx_bgm.play()

func _process(delta: float) -> void:
	# Reload with R
	if Input.is_key_pressed(KEY_R):
		get_tree().change_scene_to_file(current_scene_path)

func _on_dead_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		# Pause the game
		get_tree().paused = true

		# Show the death screen
		var death_screen_instance = death_screen.instantiate()
		get_tree().root.add_child(death_screen_instance)

func _on_end_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		# Update global var
		Global.level1_completed = true
		
		# Pause the game
		get_tree().paused = true
		
		# Show the win screen
		var win_screen_instance = win_screen.instantiate()
		get_tree().root.add_child(win_screen_instance)
