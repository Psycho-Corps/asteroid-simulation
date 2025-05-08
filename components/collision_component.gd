class_name CollisionComponent
extends Node

func _ready() -> void:
	self.call_deferred("connect", "body_entered", _on_body_entered)
	
func _on_body_entered(body: Node) -> void:
	var health_component = body.find_child("HealthComponent") if body.has_node("HealthComponent") else null
	if health_component:
		health_component.damage(10)
