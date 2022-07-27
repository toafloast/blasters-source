extends Control


var time = 100
# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if !get_tree().paused:
		time -= delta
		$Label.text = "TIME\n" + str("%0.1f" % time)
		if time <= 0:
			timeup()

func _ready() -> void:
	$endgamescore.visible = false

func timeup():
	set_process(false)
	$Label.text = "TIME\n0.0"
	get_node("../..").endgame()
	get_tree().paused = true
	$endgamescore.visible = true
	$endgamescore/finalscore.text = "FINAL SCORE\nP1 - " + str(p1score) + "\nP2 - " + str(p2score)

var p1score : int = 0
var p2score : int = 0

func give_score(scorer : player, points : int = 100):
	if scorer.isp1:
		p1score += points
		$p1.text = "P1 SCORE\n" + str("%08d" % p1score)
	else:
		p2score += points
		$p2.text = "P2 SCORE\n" + str("%08d" % p2score)

func reduce_score(scorer, points):
	if scorer.isp1:
		p1score -= points
		$p1.text = "P1 SCORE\n" + str("%08d" % p1score)
	else:
		p2score -= points
		$p2.text = "P2 SCORE\n" + str("%08d" % p2score)


func _on_Button_pressed() -> void:
	get_tree().change_scene("res://mainmenu.tscn")
	pass # Replace with function body.


func _on_agan_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
