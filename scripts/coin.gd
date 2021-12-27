extends Node2D

onready var anim_player: AnimationPlayer = get_node("coin/AnimationPlayer")


func _on_coin_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		anim_player.play("pickup")

