extends RigidBody2D

var random_velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0
	
	random_velocity = Vector2(randf_range(-100, 100), randf_range(-100, 100))
	linear_velocity = random_velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
