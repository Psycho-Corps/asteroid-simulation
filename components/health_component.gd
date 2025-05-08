class_name HealthComponent
extends Node

@onready var entity = get_parent()

@export var max_hp : float
var health : float

func set_health() -> void:
	health = max_hp
	
func damage(value : float):
	health -= value
	if entity and health <= 0:
		entity.queue_free()
