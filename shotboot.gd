extends Node2D

var timepassed = 0
func _process(delta: float) -> void:
	timepassed += delta
	position.y += 50 * delta
	position.x += sin(timepassed * 4) * 250 * delta

func _on_Area2D_body_entered(body: Node) -> void:
	print(body)
	if body is player:
		$AudioStreamPlayer2D.play()
		body.buff()
		$powerup.emitting = true
		$Sprite.visible = false
		$Area2D.queue_free()
		set_process(false)
		yield(get_tree().create_timer(2.0), 'timeout')
		queue_free()
	pass # Replace with function body.
