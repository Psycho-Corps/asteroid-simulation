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
	var components = asteroid.find_child("Components")
	var health_component = components.find_child("Health")
	match group:
		"Big":
			health_component.hp = 30
			var random_position = Vector2(randf_range(0, window_size.x), randf_range(0, window_size.y))
			asteroid.global_position = random_position
			asteroid.add_to_group("Big")
		"Medium":
			health_component.hp = 20
			asteroid.modulate = Color(1, 0, 1, 1)
			asteroid.global_position = s_position
			asteroid.add_to_group("Medium")
		"Small":
			health_component.hp = 10
			asteroid.modulate = Color(0, 1, 1, 1)
			asteroid.global_position = s_position
			asteroid.add_to_group("Small")
	asteroid.call_deferred("connect", "body_entered", _on_body_entered)
	call_deferred("add_child", asteroid)
			
func _on_body_entered(body: Node) -> void:
	if body.has_node("Components"):
		var components = body.find_child("Components")
		if components.find_child("Health"):
			if components.find_child("Health").hp <= 0:
				if body.is_in_group("Big"):
					for _i in range(2):
						spawn_asteroids("Medium", body.global_position)
				elif body.is_in_group("Medium"):
					for _i in range(4):
						spawn_asteroids("Small", body.global_position)
				body.queue_free()
			else:
				components.find_child("Health").hp -= 10
