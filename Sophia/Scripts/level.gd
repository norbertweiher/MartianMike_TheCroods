extends Node2D
@onready var Player = $Player
#var Player = null
@onready var PlayerStart = $StartPoint
@onready var level_end = $EndLevel
var lives = 99
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#Player = get_tree().get_first_node_in_group("player")
	Player.global_position = PlayerStart.get_global_position()
	
	var traps = get_tree().get_nodes_in_group("traps")
	print(traps)
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

	var checkpoints = get_tree().get_nodes_in_group("checkpoint")
	print(checkpoints)
	for checkpoint in checkpoints:
		checkpoint.checkpoint_reached.connect(_on_checkpoint_reached)

	var goldcoins = get_tree().get_nodes_in_group("goldcoin")
	print(goldcoins)
	for goldcoin in goldcoins:
		goldcoin.picked_up_coin.connect(_on_pickedup_goldcoin)

	level_end.end_of_level_reached.connect(_on_end_of_level_reached)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

func _on_death_zone_body_entered(body):
	reset_player()

func _on_jump_pad_jump_pad_triggered():
	Player.velocity.y = 300


func _on_trap_touched_player():
	lives = lives - 1
	print(lives)
	if lives == 0:
		reset_player() # Replace with function body.

func _on_pickedup_goldcoin():
	print("COLLECTED")
	points+=10
	print("POINTS: "+str(points))

func reset_player():
	Player.global_position = PlayerStart.get_global_position()
	Player.velocity = Vector2.ZERO

func _on_end_of_level_reached():
	print("YOUWIN")

func _on_checkpoint_reached(position):
	print("CHECKPOINT")
	PlayerStart.global_position = position
