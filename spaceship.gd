extends KinematicBody2D
class_name player

export(PackedScene) var Bullet
export var verticalspeed : float = 250.0
export var horizontalspeed : float = 400.0

export var isp1 : bool = true
var Velocity : Vector2 = Vector2.ZERO
var direction

func _ready() -> void:
	if isp1:
		modulate = Color.red
	else:
		modulate = Color.blue

func _physics_process(delta: float) -> void:
	var prefix : String = "p1_" if isp1 else "p2_"
	direction = Vector2.ZERO
	direction.x = Input.get_action_strength(prefix+"right") - Input.get_action_strength(prefix+"left")
	direction.y = Input.get_action_strength(prefix+"down") - Input.get_action_strength(prefix+"up")
	direction = direction.normalized()
	Velocity = Velocity.move_toward(direction * 1000, 80 if direction != Vector2.ZERO else 20)
	Velocity.y = clamp(Velocity.y, -verticalspeed, verticalspeed)
	Velocity.x = clamp(Velocity.x, -horizontalspeed, horizontalspeed)
	move_and_slide(Velocity, Vector2.UP)
	position.x = clamp(position.x, 80, 640)
	position.y = clamp(position.y, 512, 720)

func _on_firetime_timeout() -> void:
	fire()
	pass # Replace with function body.

func set_firerate(new : float):
	$firetime.wait_time = new
func get_firerate():
	return $firetime.wait_time

func fire():
	if !canfire:
		return
	$shotpuff.emitting = true
	var projectile : Projectile = Bullet.instance()
	projectile.position = position
	projectile.velocity = Vector2.UP * 1000
	projectile.firer = self
	projectile.modulate = (Color.red if isp1 else Color.blue) * 2
	$projectiles.add_child(projectile)

func _process(delta: float) -> void:
	randomize()
	var newpos = position + Vector2(rand_range(-jitteriness, jitteriness), rand_range(-jitteriness, jitteriness)).normalized() * jitteriness
	while (newpos.x < 80 || newpos.x > 640 || newpos.y < 512 || newpos.y > 720):
		newpos = position + Vector2(rand_range(-jitteriness, jitteriness), rand_range(-jitteriness, jitteriness)).normalized() * jitteriness
	position = newpos
	jitteriness = lerp(jitteriness, 0.0, delta / 2)

var jitteriness = 0.0

var canfire : bool = true
func _hurt():
	get_node("../../CanvasLayer3/score").reduce_score(self, 80)
#	print("shahwhada")
	var newscore : Label = preload('res://scoretext.tscn').instance()
	get_node("../../CanvasLayer3").add_child(newscore)
	newscore.rect_position = position
	newscore.text = "-80"
	newscore.modulate = Color.purple
	var alang = $bang.duplicate()
	add_child(alang)
	alang.emitting = true
	set_physics_process(false)
	canfire = false
	jitteriness += 5
	yield(get_tree().create_timer(1.5),'timeout')
	canfire = true
	alang.queue_free()
	set_physics_process(true)
