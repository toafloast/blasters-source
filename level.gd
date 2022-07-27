extends Node



func _ready() -> void:
	randomize()
	get_tree().paused = true
	yield(get_tree().create_timer(3.0), 'timeout')
	get_tree().paused = false
#	$musico.play()

func _process(delta: float) -> void:
	if !get_tree().paused:
		$CanvasLayer3/countdown.modulate.a = move_toward($CanvasLayer3/countdown.modulate.a, 0, delta)

var basicenemy = preload('res://enemyspaceship1.tscn')
func _on_basicenemyspawner_timeout() -> void:
	$CanvasLayer2.add_child(basicenemy.instance())
	if randi()%3 == 0:
		$CanvasLayer2.add_child(preload('res://shooter.tscn').instance())
		yield(get_tree().create_timer(0.5),'timeout')
		$CanvasLayer2.add_child(basicenemy.instance())
	if randi()%14 == 0:
		$CanvasLayer2.add_child(preload('res://blocker.tscn').instance())
		yield(get_tree().create_timer(0.5),'timeout')
		$CanvasLayer2.add_child(preload('res://shooter.tscn').instance())
	pass # Replace with function body.

func endgame():
	$CanvasLayer2/basicenemyspawner.stop()
	for enemies in get_tree().get_nodes_in_group("enemies"):
		enemies.kill()
