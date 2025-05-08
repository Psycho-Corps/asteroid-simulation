extends Node2D

var window_size : Vector2
var i = 0
var NUM_ASTEROIDS = 50
var asteroid_scene : PackedScene = preload("res://asteroid-simulation/scenes/Asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_window().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	while i < NUM_ASTEROIDS:
		spawn_asteroids("Big", Vector2(0,0))
		i += 1
						
func spawn_asteroids(group : String, s_position : Vector2) -> void:
	var asteroid = asteroid_scene.instantiate()
	var health_component = asteroid.find_child("HealthComponent")
	match group:
		"Big":
			health_component.max_hp = 30
			health_component.set_health()
			var random_position = Vector2(randf_range(0, window_size.x), randf_range(0, window_size.y))
			asteroid.global_position = random_position
			asteroid.add_to_group("Big")
		#"Medium":
			#health_component.hp = 20
			#asteroid.modulate = Color(1, 0, 1, 1)
			#asteroid.global_position = s_position
			#asteroid.add_to_group("Medium")
		#"Small":
			#health_component.hp = 10
			#asteroid.modulate = Color(0, 1, 1, 1)
			#asteroid.global_position = s_position
			#asteroid.add_to_group("Small")
	call_deferred("add_child", asteroid)
