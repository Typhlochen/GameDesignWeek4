extends CharacterBody2D
class_name ShooterEnemy

@onready var sfx_laser: AudioStreamPlayer = $"../../sfx_laser"

@onready var bullet_spawn_left_node = $BulletSpawnLeft
@onready var bullet_spawn_right_node = $BulletSpawnRight

@export_category("Shooting")
@export var fire_rate_sec = 2.0
@export var health = 100

var activated = false
var bullet_scn = preload("res://scenes/enemy_bullet.tscn")
var bullet_direction = Vector2.LEFT
var fire_rate_timer = 0.0

func _process(delta: float) -> void:
	
	if not activated:
		return
	
	# Shoot
	fire_rate_timer += delta
	if fire_rate_timer > fire_rate_sec:
		sfx_laser.play()
		var new_bullet_node = bullet_scn.instantiate()
		new_bullet_node.shoot(bullet_direction)
		bullet_spawn_left_node.add_child(new_bullet_node)
		fire_rate_timer = 0.0

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	activated = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	activated = false
