extends KinematicBody2D
class_name bat
onready var anim: = $anim_bat
onready var machine: = $batMachine
onready var timer: = $batMachine/timer
onready var sprite: = $spr_bat


var hp: = 100
var max_hp: = 150

func _ready() -> void:
	sprite.play("idle")
	sprite._set_playing(true)
	

func _physics_process(delta: float) -> void:
	match machine.state:
		
		machine.states.idle:
			move_and_slide(Vector2.ZERO, Vector2.UP)
			
		machine.states.wander:
			
			if machine.motion.x < 0:
					sprite.set_flip_h(true)
			else:
				sprite.set_flip_h(false)
			move_and_slide(machine.motion, Vector2.UP)
			
	




