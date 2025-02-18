extends CharacterBody2D

@onready var sprite_node = $Sprite2D
@onready var anim_player_node = $AnimationPlayer

@export var move_speed = 300.0
@export var jump_speed = -400.0

func _process(delta: float) -> void:
	
	if velocity.is_equal_approx(Vector2.ZERO):
		anim_player_node.play("idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * move_speed
		
		# Animate Left and Right Movement
		if direction < 0:
			anim_player_node.play("move_left")
			sprite_node.flip_h = true
		else:
			anim_player_node.play("move_right")
			sprite_node.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	move_and_slide()
