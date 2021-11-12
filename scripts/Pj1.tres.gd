extends KinematicBody2D
class_name player1

export var maxspeed: = 400.0
export var minspeed: = 100.0
export var jumpheight: = 150.0
export var jumptime: = 0.5
export var fallspeed: = 0.4

onready var jumpforce : float = ((2.0 * jumpheight) / jumptime) * -1.0
onready var jumpfall : float = ((-2.0 * jumpheight) / (jumptime * jumptime)) * -1.0
onready var gravity : float = ((-2.0 * jumpheight) / (fallspeed * fallspeed)) * -1.0

var direction: = Vector2.ZERO
var acceleration: = 0.5
var isAttacking: = false
var atackCombo: = 0
func _physics_process(delta):
	direction.x = get_input_velocity()
	direction.y += get_gravity() * delta
	
	animations()
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		jumping()
	
	for index in get_slide_count():
		var collision: = get_slide_collision(index)
		bouncers(collision)
	
	direction = move_and_slide(direction, Vector2.UP)
	var collide: = move_and_collide(direction * delta)
	

func animations():
	if !isAttacking:
		if direction.x != 0 and is_on_floor():
			if direction.x > 0:
				$anim_player.play("run")
			elif direction.x < 0:
				$anim_player.play("runL")
		elif direction.y < 0:
			$spr_player.play("jump")
		elif direction.y > 0 and !is_on_floor():
			$spr_player.play("fall")
		else:
			$anim_player.play("idle")
	if Input.is_action_just_pressed("attaque"):
		ataques()
		isAttacking = true

func ataques():
	if atackCombo == 0 and Input.is_action_just_pressed("attaque"):
		$anim_player.play("atack0")
	if atackCombo == 1 and Input.is_action_just_pressed("attaque"):
		$anim_player.play("atack1")
	if atackCombo == 2 and Input.is_action_just_pressed("attaque"):
		$anim_player.play("atack2")

func jumping():
	direction.y += jumpforce
	return(direction.y)

func get_input_velocity() -> float:
	
	if Input.is_action_pressed("moveR"):
		acceleration = 0.2
		if direction.x < maxspeed:
			direction.x += lerp(minspeed, maxspeed, acceleration)
		else:
			direction.x = maxspeed
		
	elif Input.is_action_pressed("moveL"):
		acceleration = 0.2
		if direction.x > -maxspeed:
			direction.x += -lerp(minspeed, maxspeed, acceleration)
		else:
			direction.x = -maxspeed
		
	else:
		acceleration = 0.5
		while direction.x != 0:
			direction.x -= lerp(direction.x, 0, acceleration)
	return (direction.x)

func get_gravity() -> float:
	return jumpfall if jumping() else gravity

func bouncers(collision):
	if collision.collider.is_in_group("bouncers"):
		if Input.is_action_pressed("jump"):
			direction.y = jumpforce + jumpforce
		else:
			direction.y = jumpforce + jumpforce/2
	return(direction.y)

func _on_anim_player_animation_finished(anim_name: String) -> void:
	if anim_name == "atack0":
		$Timer.start()
		atackCombo = 1
		isAttacking = false
	elif anim_name == "atack1":
		$Timer.start()
		atackCombo = 2
		isAttacking = false
	elif anim_name == "atack2":
		atackCombo = 0
		isAttacking = false


func _on_Timer_timeout() -> void:
	atackCombo = 0


func _on_anim_player_animation_started(anim_name: String) -> void:
	if anim_name == "atack0":
		isAttacking = true
	elif anim_name == "atack1":
		isAttacking = true
	elif anim_name == "atack2":
		isAttacking = true
