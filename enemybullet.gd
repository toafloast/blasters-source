extends Projectile


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

func _on_bullet_body_entered(body: Node) -> void:
	if !body:
		print_debug("??????")
		return
	if body.is_in_group("players"):
		if body.has_method("_hurt"):
			body._hurt()
			$peng.emitting = true
			$trailer.emitting = false
			$betweencheck.enabled = false
			$CollisionShape2D.disabled = true
			$Sprite.visible = false
			monitorable = false
			monitoring = false
			collision_mask = 0b0
			collision_layer = 0b00
			set_process(false)
			yield(get_tree().create_timer(1.0), 'timeout')
			queue_free()
	pass # Replace with function body.
