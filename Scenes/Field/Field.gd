extends Node2D

@onready var gg_Left = $Left
@onready var gg_Right = $Right
@onready var gg_Sprite = $Sprite

var garr_Sprites = [
	preload("res://Assets/Art/Field/Field.png"),
	preload("res://Assets/Art/Field/Field2.png"),
	preload("res://Assets/Art/Field/Field3.png")
]

enum enum_Ball_Sides {LEFT, RIGHT, LINE, OUT}
var gg_Ball_Side = enum_Ball_Sides.LINE

# Called when the node enters the scene tree for the first time.
func _ready():
	gg_Sprite.texture = garr_Sprites.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ( gg_Left.Ball_Count() == gg_Right.Ball_Count() and gg_Right.Ball_Count() == 0):
		gg_Ball_Side = enum_Ball_Sides.OUT
	elif gg_Left.Ball_Count() > gg_Right.Ball_Count():
		gg_Ball_Side = enum_Ball_Sides.LEFT
	elif gg_Left.Ball_Count() < gg_Right.Ball_Count():
		gg_Ball_Side = enum_Ball_Sides.RIGHT
	else:
		gg_Ball_Side = enum_Ball_Sides.LINE
