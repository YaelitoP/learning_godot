extends StateMachine

var gritar: = true
func _ready():
	
	add_state("idle")

func _physics_process(delta: float):
	match state:
		states.idle:
			if gritar:
				print("idle")
				gritar = false
			if owner.timer.get_time_left() == 0:
				print("cambio a wander")
				gritar = true
				change_state(states.wander)
