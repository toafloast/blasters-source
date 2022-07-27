extends "res://enemyspaceship1.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func _physics_process(delta: float) -> void:
	follow_path(delta)

func follow_path(delta : float) -> void:
	var curvedspeed : float = speed
	if speedCurve:
		curvedspeed = speedCurve.interpolate($pather/Path2D/PathFollow2D.unit_offset) * speed
	$pather/Path2D/PathFollow2D.offset += curvedspeed * delta
	position = $pather/Path2D/PathFollow2D.position + $pather/Path2D.position
	if flipped:
		position.x = 720 - position.x

func kill():
	.kill()
	#spawn somethin
	var powerup = preload('res://shotboot.tscn').instance()
	powerup.position = position
	get_parent().add_child(powerup)
