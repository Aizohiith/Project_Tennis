extends Node

var garr_Progress : Array = []
var gs_Next_Scene : String = ""
var gg_Loading_Scene : PackedScene = preload("res://Scenes/Main/Loading/Loading.tscn")
var gb_Prossesing : bool = false
var gg_Game_Setup

func Load_Scene(ps_Name : String, pp_Game_Setup = null):
	gs_Next_Scene = ps_Name
	get_tree().change_scene_to_packed(gg_Loading_Scene)
	ResourceLoader.load_threaded_request(gs_Next_Scene)
	gb_Prossesing = true
	gg_Game_Setup = pp_Game_Setup
	
func Load_Scene_Instant(ps_Name : String):
	gs_Next_Scene = ps_Name
	get_tree().change_scene_to_packed(load(gs_Next_Scene) as PackedScene)	

func _process(delta):
	if not (gb_Prossesing):
		return
	ResourceLoader.load_threaded_get_status(gs_Next_Scene, garr_Progress)
	print(garr_Progress[0])
	if garr_Progress[0] >= 1:
		gb_Prossesing = false
		await  get_tree().create_timer(0.5).timeout
		if (gg_Game_Setup):
			Done_Load_Game()
		else:
			Done_Load_Scene()

func Done_Load_Game():
	var ll_Scene = ResourceLoader.load_threaded_get(gs_Next_Scene)
	var T1 = ll_Scene.instantiate()
	T1.gi_Ball_Count = gg_Game_Setup["Balls"]
	if gg_Game_Setup["Mode"] == "Time Rush":
		var T2 = (load("res://Scenes/Game_Modes/Game_Mode_Resetting_Timer/Game_Mode_Restting_Timer.tscn") as PackedScene).instantiate()
		T2.gf_Max_Swap_Time = gg_Game_Setup["Time"]
		T1.add_child(T2)
	get_tree().root.add_child(T1)
	
func Done_Load_Scene():
	var ll_Scene = ResourceLoader.load_threaded_get(gs_Next_Scene)
	get_tree().change_scene_to_packed(ll_Scene)
