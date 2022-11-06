extends Node2D

var bullet_scene = preload("res://scenes/reusable_scenes/base_bullet_scene.tscn")

var gunRotation = 0
var canFire = true
var directionOfBullet = Vector2(0, 0)

const FIRE_RATE = 0.3 # Cooldown in seconds between shots.
const RECOIL = 0.9 # Use small values, around 0.02. Even 1 would be extremely innacurate.

func fire():
	var bullet = bullet_scene.instance()
	directionOfBullet = $Position2D.global_position - global_position
	bullet.direction = directionOfBullet * rand_range(1 - RECOIL, 1 + RECOIL)
	print(directionOfBullet)
	print(directionOfBullet * rand_range(1 - RECOIL, 1 + RECOIL))
	bullet.global_position = $Position2D.global_position
	bullet.look_at(get_global_mouse_position())
	get_tree().get_root().add_child(bullet)
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

