extends Area2D
class_name EnemyBullet

@onready var anim_player_node = $AnimationPlayer

@export var speed = 200
@export var direction := Vector2.ZERO
@export var damage = 50

var is_parried = false

func _ready() -> void:
	anim_player_node.play("normal")

func _process(delta: float) -> void:
	# Move the Bullet
	global_position += direction * speed * delta
	

## BULLET FUNCTIONS

func shoot(shoot_direction: Vector2):
	direction = shoot_direction

func get_parried():
	# Move Down
	direction = Vector2.DOWN
	is_parried = true

func start_parryable_indicator():
	# This indicator can visually inform the Player that the bullet is close
	# enough to be parried. It also acts as a warning that if not parried, the 
	# bullet may kill the player if it hits them.
	
	# For now, making the Sprite "Blink"
	anim_player_node.play("parryable")

func end_parryable_indicator():
	anim_player_node.play("normal")


## SIGNALS

# Check for any Physics Bodies entering this area
func _on_body_entered(body: Node2D) -> void:
	if body is Player and not is_parried:
		# Notify the Player
		body.collided_with_enemy_bullet(damage)
		# Destroy Self
		queue_free()
