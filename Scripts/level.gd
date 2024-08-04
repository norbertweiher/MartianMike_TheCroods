extends Node2D
@onready var Player = $Player
#var Player = null
@onready var PlayerStart = $StartPoint
#@onready var checkpoint = $Checkpoints/CheckPoint
@export var next_level:PackedScene = null
@onready var levelend = $LevelEnd
@onready var death_zone = $DeathZone
@onready var hud = $UI/HUD
@onready var ui = $UI
@export var level_time = 3
@export var is_final_level: bool = false
var time_left = null
var timer_node = null
var win = false
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Player.global_position = PlayerStart.get_global_position()
	#Init traps
	var traps = get_tree().get_nodes_in_group("traps")
	print(traps)
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
	#Init death zone
	death_zone.body_entered.connect(_on_death_zone_body_entered)
	#Init level end signal
	levelend.end_of_level_reached.connect(_on_levelend_entered)
	#Init Check Points
	var checkpoints = get_tree().get_nodes_in_group("checkpoint")
	print(checkpoints)
	for checkpoint in checkpoints:
		checkpoint.check_point_reached.connect(_update_start_position)
	#Init Gold Coins
	var goldcoins = get_tree().get_nodes_in_group("goldcoin")
	print(goldcoins)
	for goldcoin in goldcoins:
		goldcoin.picked_up_coin.connect(_on_pickedup_goldcoin)
	time_left = level_time
	hud.set_time_label(time_left)
	timer_node = Timer.new()
	timer_node.name="Level Timer"
	timer_node.wait_time = 1
	timer_node.timeout.connect(_on_level_timer_timeout)
	add_child(timer_node)
	timer_node.start()
	ui.show_win_screen(false)

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
	AutoLoad.play_sfx("hurt")
	reset_player() # Replace with function body.

func reset_player():
	Player.global_position = PlayerStart.get_global_position()
	Player.velocity = Vector2.ZERO

func _on_levelend_entered():
	
	print("LEVEL EXIT")
	print(is_final_level)
	print(str(next_level))
	win = true
	if is_final_level or (next_level != null):
		levelend.animate()
		Player.active = false
		await get_tree().create_timer(1.5).timeout
		if is_final_level:
			ui.show_win_screen(true)
		else:
			get_tree().change_scene_to_packed(next_level)
	else:
		print("NO FINAL LEVEL OR NEXT LEVEL DEFINED")

func _on_level_timer_timeout():
	if not win:
		time_left-=1
		hud.set_time_label(time_left)
		if time_left<0:
			AutoLoad.play_sfx("hurt")
			reset_player()
			time_left = level_time
			hud.set_time_label(level_time)

func _update_start_position(position):
	print("CHECK POINT REACHED" + str(position))
	PlayerStart.global_position = position

func _on_pickedup_goldcoin():
	print("COLLECTED")
	points+=10
	print("POINTS: "+str(points))
