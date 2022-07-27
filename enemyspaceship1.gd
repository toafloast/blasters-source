extends KinematicBody2D

export var speed : float = 150.0
export(Curve) var speedCurve : Curve
var timepassed = 0.0;
export var Health : int = 1
export var value : int = 100;
export var flipped : bool = false

signal on_kill(killer, scored)

var victim : Node2D
func _ready() -> void:
	randomize()
	flipped = randi()%2
	if !victim:
		randomize()
		var possible =  get_tree().get_nodes_in_group("players")
		if possible.size() > 0:
			victim = possible[randi()%possible.size()]
	connect('on_kill', get_node("../../CanvasLayer3/score"), "give_score")

func _physics_process(delta: float) -> void:
	if $pather/Path2D/PathFollow2D.unit_offset != 1.0:
		follow_path(delta)
	else:
		follow_player(delta)

func follow_path(delta : float) -> void:
	var curvedspeed : float = speed
	if speedCurve:
		curvedspeed = speedCurve.interpolate($pather/Path2D/PathFollow2D.unit_offset) * speed
	$pather/Path2D/PathFollow2D.offset += curvedspeed * delta
	position = $pather/Path2D/PathFollow2D.position + $pather/Path2D.position
	if flipped:
		position.x = 720 - position.x
	if victim:
		look_at(victim.position)
		rotate(-PI/2)

func follow_player(delta : float) -> void:
	#pick a random player, go after them
	if victim:
		position = position.move_toward(victim.position, speed * speedCurve.interpolate(1.0) * delta)
		look_at(victim.position)
		rotate(-PI/2)

func _hurt(amount, damager):
	Health -= amount
	if Health <= 0:
		emit_signal('on_kill', damager, value)
		if damager:
			var newscore : Label = preload('res://scoretext.tscn').instance()
			get_node("../../CanvasLayer3").add_child(newscore)
			newscore.rect_position = position
			newscore.text = "+" + str(value)
		kill()

func kill():
	$AnimationPlayer.play('death')

var off = false
func _on_Area2D_body_entered(body: Node) -> void:
	if body is player and !off:
		body._hurt()
		set_physics_process(false)
		kill()
		off = true
	pass # Replace with function body.
