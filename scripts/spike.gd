extends Area2D
class_name Spike

@export var damage = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:
	# Don't Collide with Enemy
	if body is ShooterEnemy:
		return
	
	if body is Player:
		# Notify the Player
		body.collided_with_enemy_bullet(damage)
	# Destroy Self
	queue_free()
