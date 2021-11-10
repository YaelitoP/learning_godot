extends RigidBody2D

var hp: = 100
var dmg: = 10

func _physics_process(delta: float) -> void:
	
	if hp == 0:
		$spr_chobi.play("dead")
		queue_free()
	elif hp > 0:
		$spr_chobi.play("idle")
	pass


func _on_area_chobi_area_entered(area: Area2D) -> void:
	if area.is_in_group("ataques"):
		hp = -25


func _on_area_agro_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
