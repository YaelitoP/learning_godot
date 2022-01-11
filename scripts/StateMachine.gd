extends Node2D
class_name StateMachine

onready var state: Object

const DEBUG = true

var _history = []

func _ready():
	# Set the initial state to the first child node
	state = get_child(0)
	call_deferred("_enter_state")
	
func change_to(new_state):
	_history.append(state.name)
	state = get_node(new_state)
	_enter_state()

func back():
	if _history.size() > 0:
		state = _history.pop_back()
		_enter_state()

func _enter_state():
	# Give the new state a reference to this state machine script
	state.machine = self
	state.enter()


#func random_state(state_list):
#	state_list.shuffle()
#	return state_list.pop_back()


# Route Game Loop function calls to
# current state handler method if it exists
#func _process(delta):
	#if state.has_method("process"):
		#state.process(delta)

#func _physics_process(delta):
	#if state.has_method("physics_process"):
	#	state.physics_process(delta)
