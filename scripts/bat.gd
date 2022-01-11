extends KinematicBody2D
class_name bat

onready var anim: = $anim_bat
onready var MACHINE: = $stateMachine
onready var IDLE: = $stateMachine/idle
onready var WANDER: = $stateMachine/wander
onready var timer: = $Timer


var hp: = 100
var max_hp: = 150

func _physics_process(delta: float) -> void:
	match MACHINE.state:
		WANDER:
			WANDER.get_direction()
			move_and_slide(WANDER.direction, Vector2.UP)
		IDLE:
			continue
	
	pass

