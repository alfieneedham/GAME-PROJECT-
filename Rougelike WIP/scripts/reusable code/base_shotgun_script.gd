extends Node2D

var bullet_scene = preload("res://scenes/reusable_scenes/base_bullet_scene.tscn")

var gunRotation = 0
var canFire = true

const FIRE_RATE = 0.3 # Cooldown in seconds between shots.
const BLOOM = 0.02 # Use small values, around 0.02. Even 1 would be extremely innacurate.

func fire():
	var bullet = bullet_scene.instance()
	bullet.direction = $Position2D.global_position - (global_position * rand_range(1 - BLOOM, 1 + BLOOM))
	bullet.global_position = $Position2D.global_position
	bullet.look_at(get_global_mouse_position())
	get_tree().get_root().add_child(bullet)
	
	var bullet2 = bullet_scene.instance()
	bullet2.direction = $Position2D2.global_position - (global_position * rand_range(1 - BLOOM, 1 + BLOOM))
	bullet2.global_position = $Position2D2.global_position
	bullet2.look_at(get_global_mouse_position())
	get_tree().get_root().add_child(bullet2)
	
	var bullet3 = bullet_scene.instance()
	bullet3.direction = $Position2D3.global_position - (global_position * rand_range(1 - BLOOM, 1 + BLOOM))
	bullet3.global_position = $Position2D3.global_position
	bullet3.look_at(get_global_mouse_position())
	get_tree().get_root().add_child(bullet3)
	
	canFire = false
	yield(get_tree().create_timer(FIRE_RATE), "timeout")
	canFire = true

func _physics_process(delta):
	
	if Input.is_action_just_pressed("fire") and canFire == true:
		fire()
		
	gunRotation = get_global_rotation_degrees()
	if gunRotation <-90 or gunRotation >90:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false    
	look_at(get_global_mouse_position())

