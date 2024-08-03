extends Node2D
@onready var Player = $Player
@onready var PlayerStart = $StartPoint
@onready var checkpoint = $Checkpoints/CheckPoint
@onready var levelend = $LevelEnd
@export var lives = 3
@export var next_level: PackedScene
@onready var level_end = $LevelEnd
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
		checkpoint.check_point_reached.connect(_update_start_position)

	level_end.end_of_level_reached.connect(_on_end_of_level_reached)


		
func _update_start_position(position):
	print("CHECK POINT REACHED" + str(position))
	PlayerStart.global_position = position



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
	lives = lives -1
	print(lives)
	if lives <=0:
		reset_player()
		lives = 3 # Replace with function body.

func reset_player():
	Player.global_position = PlayerStart.get_global_position()
	Player.velocity = Vector2.ZERO

func _on_end_of_level_reached():
	if next_level != null:
		get_tree().change_scene_to_packed(next_level)
