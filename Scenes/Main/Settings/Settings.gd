extends Control

@onready var gg_Resolution = $Panel/VBoxContainer/Resolution
@onready var gg_Screen_State = $Panel/VBoxContainer/Screen_State

const RESOLUTIONS = {
	"1920x1080": Vector2(1920, 1080),
	"1366x768": Vector2(1366, 768),
	"1440x900": Vector2(1440, 900),
	"1536x864": Vector2(1536, 864),
	"1280x720": Vector2(1280, 720),
	"1600x900": Vector2(1600, 900),
	"1280x800": Vector2(1280, 800),
	"2560x1440": Vector2(2560, 1440),
	"1680x1050": Vector2(1680, 1050),
	"1360x768": Vector2(1360, 768),
	"1920x1200": Vector2(1920, 1200)
};

const SCREEN_STATE = {
	"Fullscreen" : 0,
	"Windowed" : 1
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for E1 in RESOLUTIONS:
		gg_Resolution.add_item(E1)
		
	for E1 in SCREEN_STATE:
		gg_Screen_State.add_item(E1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	Load_Manager.Load_Scene_Instant("res://Scenes/Main/Menu/Menu.tscn")


func _on_resolution_item_selected(index):
	DisplayServer.window_set_size(RESOLUTIONS.values()[index])


func _on_screen_state_item_selected(index):
	
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	elif index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func _on_clear_achievments_pressed():
	Game_Manager.Clear_Achievement("GS")
	Game_Manager.Clear_Achievement("5/0")
