extends Node2D

var window_size : Vector2
var i = 0
var NUM_ASTEROIDS = 100
var asteroid_scene : PackedScene = preload("res://asteroid-simulation/scenes/Asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_window().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	while i < NUM_ASTEROIDS:
		spawn_asteroids()
		i += 1
	
func spawn_asteroids() -> void:
	var asteroid = asteroid_scene.instantiate()
	asteroid.body_entered.connect(_on_body_entered)
	var random_position = Vector2(randf_range(0, window_size.x), randf_range(0, window_size.y))
	asteroid.global_position = random_position
	add_child(asteroid)

func _on_body_entered(body: Node) -> void:
	if body.has_node("Components"):
		var components = body.find_child("Components")
		if components.find_child("Health"):
			if components.find_child("Health").hp <= 0:
				body.queue_free()
			else:
				components.find_child("Health").hp -= 10
