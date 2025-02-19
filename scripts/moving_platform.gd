extends AnimatableBody2D

@export var speed = 100

# These Define where the Platform should loop
@export var start_node2d: Node2D = null
@export var end_node2d: Node2D = null

var move_towards_endpoint: Node2D = null
var going_start_to_end = true
var min_dist_sq = 4

func _ready() -> void:
	assert(start_node2d != null, "MovingPlatform is not assigned endpoints!")
	assert(end_node2d != null, "MovingPlatform is not assigned endpoints!")
	
	global_position = start_node2d.global_position
	move_towards_endpoint = end_node2d

func _physics_process(delta: float) -> void:
	
	var direction = global_position.direction_to(move_towards_endpoint.global_position)
	global_position += speed * direction * delta
	
	if global_position.distance_squared_to(move_towards_endpoint.global_position) < min_dist_sq:
		if going_start_to_end:
			move_towards_endpoint = start_node2d
			going_start_to_end = false
		else:
			move_towards_endpoint = end_node2d
			going_start_to_end = true
