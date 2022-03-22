extends Node2D


var ray_list: = [$ray1, $ray2, $ray3, $ray4, $ray5, $ray6, $ray7, $ray8]

 
var origin: = global_position
var most_close = null
var surrounded = null
var too_far = null


func _physics_process(delta: float) -> void:
	for raycast in ray_list:
		if ray_list[0].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[1].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[2].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[3].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[4].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[5].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[6].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[7].is_colliding():
			most_close = raycast.get_collision_point()
			
		if ray_list[8].is_colliding():
			most_close = raycast.get_collision_point()
