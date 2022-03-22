extends Area2D



func _on_area_area_entered(area: Area2D) -> void:

	direction = direction.bounce(collision.normal)
