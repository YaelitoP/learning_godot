extends KinematicBody2D

export var maxspeed: = 400.0
export var minspeed: = 100.0
export var jumpheight: = 150.0
export var jumptime: = 0.5
export var fallspeed: = 0.6
onready var jumpforce : float = ((2.0 * jumpheight) / jumptime) * -1.0
onready var jumpfall : float = ((-2.0 * jumpheight) / (jumptime * jumptime)) * -1.0
onready var gravity : float = ((-2.0 * jumpheight) / (fallspeed * fallspeed)) * -1.0

var direction: = Vector2.ZERO
var acceleration: = 0.5

func _physics_process(delta):
	direction.x = get_input_velocity()
	direction.y += get_gravity() * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		jumping()
	animations()
	
	
	direction = move_and_slide(direction, Vector2.UP)

func ataques():
	if Input.is_action_just_pressed("attaque"):
		$spr_player.play("atack")

func jumping():
	direction.y += jumpforce
	return(direction.y)

func animations():
	if direction.x != 0 and is_on_floor():
		$spr_player.play("walk")
	elif direction.y < 0:
		$spr_player.play("jump")
	elif direction.y > 0 and !is_on_floor():
		$spr_player.play("fall")
	else:
		$spr_player.play("idle")

func get_input_velocity() -> float:
	if Input.is_action_pressed("moveR"):
		acceleration = 0.2
		if direction.x < maxspeed:
			direction.x += lerp(minspeed, maxspeed, acceleration)
		else:
			direction.x = maxspeed
		$spr_player.set_flip_h(false)
		$coll_player.set_position(Vector2( 0, 0 ))
	elif Input.is_action_pressed("moveL"):
		acceleration = 0.2
		if direction.x > -maxspeed:
			direction.x += -lerp(minspeed, maxspeed, acceleration)
		else:
			direction.x = -maxspeed
		$spr_player.set_flip_h(true)
		$coll_player.set_position(Vector2(-12.557, 0))
	else:
		acceleration = 0.5
		while direction.x != 0:
			direction.x -= lerp(direction.x, 0, acceleration)
	return (direction.x)

func get_gravity() -> float:
	return jumpfall if jumping() else gravity
