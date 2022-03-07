extends Node2D
class_name StateMachine


const DEBUG = true

onready var parent: = get_parent()

var state = null setget set_state
var previous_state = null
var states = {}

func _ready():
	# Set the initial state to the first child node
	pass

func state_back():
	set_state(previous_state)

func set_state(new_state):
	previous_state = state
	state = new_state

	
func add_state(state_name):
	states[state_name] = states.size()
