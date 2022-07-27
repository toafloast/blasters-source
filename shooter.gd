extends "res://enemyspaceship1.gd"

export(PackedScene) var bullet

func shootabullet():
	$shot.play()
	var newbullet : Projectile= bullet.instance()
	newbullet.position = position
	
	if victim:
		newbullet.look_at(victim.position)
		newbullet.target = victim
	else:
		newbullet.look_at(Vector2(720/2, 720))
	
	newbullet.speed = 300
	get_node("..").add_child(newbullet)

func _on_Timer_timeout() -> void:
	if $Sprite.visible:
		shootabullet()
	pass # Replace with function body.
