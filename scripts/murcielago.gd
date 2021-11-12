extends RigidBody2D
class_name murcielago

var hp: = 100
var agro: = false
var dead: = false
var isAtacking: = false 

func _physics_process(delta: float) -> void:
	
	if hp <= 0:
		dead = true
		$anim_chobi.play("dead")

	if !dead and agro:
		$spr_chobi.play("angry")
	elif !dead:
		$spr_chobi.play("idle")

func _on_area_chobi_area_entered(area: Area2D) -> void:
	if area.is_in_group("ataques"):
		hp = hp - 25
	$coll_chobi.set_modulate(Color(0.764706, 0.058824, 0.058824))

func _on_area_agro_area_entered(area: Area2D):
	var distance: = get_global_position().distance_to(area.get_global_position())
	if area.is_in_group("player"):
		agro = true
	if area.is_in_group("player") and distance < 100:
		look_at(area.get_parent_node(.get_global_position()))
	return(distance)

func ataque(distance):
	if distance < 100:
		$anim_chobi.play("ataque")

func _on_anim_chobi_animation_finished(anim_name: String) -> void:
	if anim_name == "dead":
		queue_free()
