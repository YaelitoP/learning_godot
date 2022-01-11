extends Node2D
class_name Wander_Bat

export(int) var move_range: = 40

onready var parent: = get_parent()
onready var start_pos: = global_position
var target_pos: = Vector2.ZERO
var direction: = Vector2.ZERO
var machine: StateMachine
var speed: = 130


func _ready() -> void:
	pass

func enter():
	create_target()
	print("your on wander")
	yield(get_tree().create_timer(4.0), "timeout")
	exit("idle")

func get_direction():
	var _current_pos: = global_position
	if _current_pos.distance_to(start_pos) <= 300:
		direction = target_pos * speed
		_current_pos = global_position
		create_target()
	elif _current_pos.distance_to(start_pos) <= 300:
		print("cerca del target")
		direction = target_pos * speed
		_current_pos = global_position
		create_target()

func create_target():
	target_pos = Vector2(rand_range(-move_range, move_range), rand_range(-move_range, move_range)).normalized()


func exit(next_state):
	parent.change_to(next_state)
