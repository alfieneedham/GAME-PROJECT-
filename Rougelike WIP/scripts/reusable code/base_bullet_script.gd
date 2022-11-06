extends Area2D

var direction = Vector2.RIGHT
var speed = 2500
onready var bulletDirection = direction.normalized()

func _process(delta):	
	translate(bulletDirection * speed * delta)

func _on_base_bullet_body_entered(body):
	queue_free()

