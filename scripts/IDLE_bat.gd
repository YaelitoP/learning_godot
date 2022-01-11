extends Node2D
class_name Idle_Bat

onready var machine: StateMachine
onready var parent: = get_parent()

func _physics_process(_delta: float) -> void:
	pass
	
func enter():
	print("your on idle")
	yield(get_tree().create_timer(2.0), "timeout")
	#parent.random_state(parent.history)
	exit("wander")

func exit(next_state):
	parent.change_to(next_state)

