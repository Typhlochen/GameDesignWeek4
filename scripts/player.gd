extends CharacterBody2D
class_name Player

@onready var sfx_hurt: AudioStreamPlayer = $"../sfx_hurt"
@onready var sfx_slash: AudioStreamPlayer = $"../sfx_slash"
@onready var sfx_parry: AudioStreamPlayer = $"../sfx_parry"
@onready var sfx_jump: AudioStreamPlayer = $"../sfx_jump"

@onready var sprite_node = $Sprite2D
@onready var anim_player_node = $AnimationPlayer

@export var move_speed = 300.0
@export var jump_speed = -400.0
@export var parry_jump_speed = -600.0

@export_category("Health and Damage")
@export var health_ui_label_node: Label = null
@export var health = 100

# Death Screen
var death_screen = preload("res://scenes/death_screen.tscn")

# Parrying Information
var can_parry = false
var parryable_enemy_bullet_node: EnemyBullet = null

func _ready() -> void:
	# Make Sure a Label node is attached to display Health
	assert(health_ui_label_node != null, "Player's Health UI node is not set!")
	health_ui_label_node.text = str(health)

func _process(_delta: float) -> void:
	if velocity.is_equal_approx(Vector2.ZERO):
		if anim_player_node.current_animation != "parry":
			anim_player_node.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		sfx_jump.play()
		velocity.y = jump_speed
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
		
		# Animate Left and Right Movement
		if direction < 0:
			if anim_player_node.current_animation != "parry":
				anim_player_node.play("move_left")
			sprite_node.flip_h = true
		else:
			if anim_player_node.current_animation != "parry":
				anim_player_node.play("move_right")
			sprite_node.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	# Parrying Mechanic
	if Input.is_action_just_pressed("parry"):
		perform_parry()
	
	move_and_slide()

## PLAYER FUNCTIONS

func decrease_health(value: int):
	sfx_hurt.play()
	health -= value
	health_ui_label_node.text = str(health)
	if health <= 0:
		# Pause the game
		get_tree().paused = true

		# Show the death screen
		var death_screen_instance = death_screen.instantiate()
		get_tree().root.add_child(death_screen_instance)

func perform_parry():
	sfx_slash.play()
	# Play Animation
	anim_player_node.play("parry")
	
	if can_parry and parryable_enemy_bullet_node != null:
		# Jump Upwards
		sfx_jump.play()
		velocity.y = parry_jump_speed
		
		# Deflect Bullet
		sfx_parry.play()
		parryable_enemy_bullet_node.get_parried()

## SIGNALS

# EnemyBullet can only be parried if it is inside the Sensor and hasn't collided with the Player Body 
func _on_enemy_bullet_sensor_area_entered(area: Area2D) -> void:
	if area is EnemyBullet:
		parryable_enemy_bullet_node = area
		parryable_enemy_bullet_node.start_parryable_indicator()
		can_parry = true

func _on_enemy_bullet_sensor_area_exited(area: Area2D) -> void:
	if area is EnemyBullet and parryable_enemy_bullet_node == area:
		parryable_enemy_bullet_node.end_parryable_indicator()
		parryable_enemy_bullet_node = null
		can_parry = false

# Collision with an Enemy Bullet
func collided_with_enemy_bullet(damage_by_bullet: int):
	decrease_health(damage_by_bullet)
