extends RigidBody2D

@onready var immunity_timer = $Timer
var random_velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	random_velocity = Vector2(randf_range(-100, 100), randf_range(-100, 100))
	linear_velocity = random_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if immunity_timer.is_stopped():
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
