extends KinematicBody2D
class_name player1

export var maxspeed: = 900.0
export var minspeed: = 250.0
export var jumpheight: = 200.0
export var acceleration: = 0.5


onready var jumpforce: float = ((2.0 * jumpheight) / jumptime) * -1.0
onready var jumpfall: float = ((-2.0 * jumpheight) / (jumptime * jumptime)) * -1.0
onready var gravity: float = ((-2.0 * jumpheight) / (fallspeed * fallspeed)) * -1.0
onready var ray: = $coll_player/ray
onready var sprite: = $spr_player
onready var anim_tree = $AnimationTree
onready var anim_stance = anim_tree.get("parameters/playback")
onready var atack_stance = anim_stance.get("parameters/atacks/playback")


var jumptime: = 0.6
var fallspeed: = 0.5

var direction: = Vector2.ZERO

var isAttacking: = false
var combo: = false
var time_out = false


func _physics_process(delta):
	direction.x = get_input_velocity()
	direction.y += get_gravity() * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		jumping()
	
	for index in get_slide_count():
		var collision: = get_slide_collision(index)
		bouncers(collision)
		
	direction = move_and_slide(direction, Vector2.UP)
	animations()


func animations():
	if !isAttacking:
		if is_on_floor() and (Input.is_action_pressed("moveL") or Input.is_action_pressed("moveR")):
			anim_tree["parameters/run/blend_position"] = direction.x
			anim_stance.travel("run")
		elif !is_on_floor():
			if direction.x > 0:
				anim_stance.travel("jump")
			elif direction.x < 0:
				anim_stance.travel("jumpL")
			else:
				anim_stance.travel("jump")
		else:
			anim_stance.travel("idle")
		
	elif isAttacking:
		anim_tree["parameters/atacks/conditions/combo"] = combo
		anim_tree["parameters/atacks/conditions/time_out"] = time_out
		anim_stance.travel("atacks")


func jumping():
	direction.y += jumpforce
func get_input_velocity() -> float:
	if Input.is_action_pressed("moveR"):
		acceleration = 0.2
		
		if direction.x < maxspeed:
			direction.x += minspeed * acceleration
		else:
			direction.x = maxspeed
			
	elif Input.is_action_pressed("moveL"):
		acceleration = 0.2
		
		if direction.x > -maxspeed:
			direction.x += -minspeed * acceleration
		else:
			direction.x = -maxspeed
	else:
		direction.x = 0
	return (direction.x)
func get_gravity() -> float:
	return jumpfall if jumping() else gravity
func bouncers(collision):
	if collision.collider.is_in_group("bouncers"):
		if Input.is_action_pressed("jump") and ray.is_colliding():
			direction.y = jumpforce * 3
		elif ray.is_colliding():
			direction.y = jumpforce * 2


func _on_anim_player_animation_finished(anim_name: String) -> void:
	if anim_name == "atack0":
		$Timer.start()
	elif anim_name == "atack1":
		$Timer.start()
	elif anim_name == "atack2":
		combo = false
		isAttacking = false
		time_out = true

func _on_Timer_timeout() -> void:
	combo = false
	isAttacking = false
	time_out = true


func _on_anim_player_animation_started(anim_name: String) -> void:
	if anim_name == "atack0":
		isAttacking = true
		combo = true
		time_out = false
	elif anim_name == "atack1":
		isAttacking = true
		combo = true
		time_out = false
	elif anim_name == "atack2":
		isAttacking = true
		time_out = false
