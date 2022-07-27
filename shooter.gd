extends "res://enemyspaceship1.gd"

export(PackedScene) var bullet

func shootabullet():
	var newbullet : Projectile= bullet.instance()
	newbullet.position = position
	
	if victim:
		newbullet.look_at(victim.position)
	else:
		newbullet.look_at(Vector2(720/2, 720))
	
	newbullet.velocity = (Vector2.DOWN * 500).rotated(newbullet.rotation - PI/2)
	get_node("..").add_child(newbullet)

func _on_Timer_timeout() -> void:
	if $Sprite.visible:
		shootabullet()
	pass # Replace with function body.
