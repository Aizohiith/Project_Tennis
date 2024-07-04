@tool
extends Control

@export var gs_Text : String = "Demo"

signal gg_Pressed
@onready var gg_Texture_Button = $Texture_Button
@onready var gg_Text = $Texture_Button/Text

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gg_Text.text != gs_Text:
		gg_Text.text = gs_Text


func _on_texture_button_pressed():
	gg_Pressed.emit()
