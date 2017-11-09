extends Node
var nopl
var winning_the_game = false
var columns =[]
var col_width = 0
var default_col
var target_col
var _move_time = 0
var AI = preload("res://ai.gd")
var resolver
func _ready():
	pass

func translate_disk_name_to_number(disk_name):
	if disk_name == 'A':
		return 1
	elif disk_name == 'B':
		return 2
	elif disk_name == 'C':
		return 3

func translate_number_to_disk_name(number):
	if number == 1:
		return 'A'
	elif number == 2:
		return 'B'
	elif number == 3:
		return 'C'

func _add_columns(col):	
	self.columns.append(col)
	
func _is_in_column(x_coord):
	return floor(x_coord / self.col_width)
	