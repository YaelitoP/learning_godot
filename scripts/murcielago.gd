extends KinematicBody2D
class_name murcielago

onready var ray: = $area_agro/coll_ray
onready var ray1: = $area_agro/coll_ray1
onready var ray2: = $area_agro/coll_ray2

var hp: = 100
var max_hp: = 150
var speed: = 200
var sight: = 300.0

var wrong_dire: = Vector2.ZERO
var intruder: Vector2
var motion: = Vector2.ZERO

var target: float
var alert: = false
var agro: = false
var dead: = false
var isAtacking: = false 

func _physics_process(_delta: float) -> void:
	
	for collide in $area_agro.get_overlapping_bodies():
		if collide.is_in_group("player"):
			target = .get_global_position().distance_to(intruder)
			check_cast_to(collide)
	
	if hp <= 0:
		dead = true
		$anim_chobi.play("murido")
	if !dead and agro:
		$spr_chobi.play("angry")
	elif !dead:
		$spr_chobi.play("idle")
	
	idle_movement()

func idle_movement():
	
	if wrong_dire != Vector2.ZERO and !agro:
		motion = wrong_dire
		motion = move_and_slide(motion, Vector2.UP)
		
	elif wrong_dire != Vector2.ZERO and agro:
		motion = wrong_dire
		motion = move_and_slide(motion, Vector2.UP)
		
	elif alert:
		motion = move_and_slide(motion, Vector2.UP)
		
	else:
		motion = move_and_slide(motion, Vector2.UP)
	
	for index in get_slide_count():
		var collision: = get_slide_collision(index)


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("ataques") and !dead:
		hp = hp - 25
	$coll_chobi.set_modulate(Color(0.764706, 0.058824, 0.058824))
	

func _on_area_agro_area_exited(area: Area2D) -> void:
	$Timer.start()
	if area.is_in_group("player"):
		alert = true
		agro = false

func _on_area_agro_body_entered(body: Node2D):
	intruder = body.get_global_position()
	agro = true
	$Timer.start()
	return(intruder)


func see_path(object):
	var direction_to_object: = .get_global_position().direction_to(object.get_global_position())
	wrong_dire = -direction_to_object * speed
	
func check_cast_to(bodies):
	var direction_to_player = .get_global_position().direction_to(bodies.get_global_position())
	var cast_direction = direction_to_player * sight
	var collision_object = ray.get_collider()
	var collision_object1 = ray1.get_collider() 
	var collision_object2 = ray2.get_collider()
	ray.set_cast_to(cast_direction)
	ray1.set_cast_to(cast_direction)
	ray2.set_cast_to(cast_direction)
	
	if ray.is_colliding():
		if collision_object.is_in_group("player"):
			wrong_dire = Vector2.ZERO
			motion = direction_to_player * speed
		elif collision_object.is_in_group("plataformas"):
			see_path(collision_object)
	
	if ray1.is_colliding():
		if collision_object1.is_in_group("player"):
			wrong_dire = Vector2.ZERO
			motion = direction_to_player * speed
		elif collision_object1.is_in_group("plataformas"):
			see_path(collision_object1)
	
	if ray2.is_colliding():
		if collision_object2.is_in_group("player"):
			wrong_dire = Vector2.ZERO
			motion = direction_to_player * speed
		elif collision_object2.is_in_group("plataformas"):
			see_path(collision_object2)

func _on_Timer_timeout() -> void:
	if alert:
		alert = false 
	if agro:
		agro = false
	
