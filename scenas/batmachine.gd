extends StateMachine

export(int) var move_range: = 32
export(int) var speed: = 200

onready var start_pos: = global_position
onready var current_pos: = global_position
onready var timer: = $timer

var objective = null

var next_state: Array

var target_pos: = Vector2.ZERO
var direction: = Vector2.ZERO
var motion: = Vector2.ZERO

var shout: = true

func _ready():
	randomize()
	get_direction()
	add_state("wander")
	add_state("idle")
	add_state("chase")
	
	next_state.append(states.wander)
	next_state.append(states.idle)
	
	timer.call_deferred("start")
	call_deferred("set_state", states.wander)

func _physics_process(delta: float):
	match state:
		
		states.idle:
			get_direction()
			if shout:
				print("idle")
				shout = false
			if timer.time_left == 0:
				next_state.shuffle()
				change_state(next_state.front())
				
		states.wander:
			if shout:
				print("wander")
				shout = false
			if timer.time_left == 0:
				next_state.shuffle()
				change_state(next_state.front())
				
		states.chase:
			if shout:
				print("chase")
				shout = false
			chase_player(delta)
			



func get_direction():
	current_pos = global_position
	update_target()
	direction = current_pos.direction_to(target_pos)
	motion = direction * speed

func update_target():
	target_pos = current_pos + Vector2(rand_range(-move_range, move_range), rand_range(-move_range, move_range))

func change_state(new_state):
	set_state(new_state)
	shout = true
	timer.start(rand_range(2, 3))

func chase_player(delta):
	direction = (objective.global_position - global_position).normalized()
	motion = direction * speed
	

func _on_area_bat_body_entered(body: Node) -> void:
		shout = true
		objective = body
		change_state(states.chase)


func _on_area_bat_body_exited(body: Node) -> void:
	change_state(states.idle)
		
