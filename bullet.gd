extends Area2D
class_name Projectile

var velocity := Vector2.ZERO
var damage = 1;
var firer

func _process(delta: float) -> void:
	$betweencheck.cast_to = velocity * delta
	if $betweencheck.is_colliding():
		print($betweencheck.get_collider())
		_on_bullet_body_entered($betweencheck.get_collider())
		return
	position += velocity * delta
	

func _on_bullet_body_entered(body: Node) -> void:
	if !body:
		print_debug("??????")
		return
	if body.is_in_group("enemy"):
		if body.has_method("_hurt"):
			body._hurt(damage, firer)
			$peng.emitting = true
			$trailer.emitting = false
			$betweencheck.enabled = false
			$CollisionShape2D.disabled = true
			$Sprite.visible = false
			monitorable = false
			monitoring = false
			collision_mask = 0b0
			set_process(false)
			yield(get_tree().create_timer(1.0), 'timeout')
			queue_free()
	pass # Replace with function body.
