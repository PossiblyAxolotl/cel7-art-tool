extends Node2D

func _ready():
	for b in $VBoxContainer/HBoxContainer.get_children():
		b.connect("pressed", self, "setColor", [b])
	for b in $VBoxContainer/HBoxContainer2.get_children():
		b.connect("pressed", self, "setColor", [b])

func setColor(b):
	var newColour = b.get_stylebox("normal").bg_color
	$preview.modulate = newColour
	print(b.get_stylebox("normal").bg_color)

func _process(delta):
	# get mouse pos in edit field
	var mousePos = Vector2(round(($editField.get_local_mouse_position().x / 64)+.5)-1,round(($editField.get_local_mouse_position().y / 64)+.5)-1)
	
	# place and delete tiles
	if mousePos.x >= 0 and mousePos.x < 7 and mousePos.y >= 0 and mousePos.y < 7:
		if Input.is_action_pressed("click"):
			$editField.set_cell(mousePos.x,mousePos.y,0)
			$preview.set_cell(mousePos.x,mousePos.y,0)
		elif Input.is_action_pressed("rClick"):
			$editField.set_cell(mousePos.x,mousePos.y,-1)
			$preview.set_cell(mousePos.x,mousePos.y,-1)

func _on_save_pressed():
	var dat = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	for t in $editField.get_used_cells():
		dat[t.x + ((t.y)*7)] = 1
	$AcceptDialog/RichTextLabel.text = str(dat).replace(","," ").replace("[","").replace("]","") +"\n\nCOPIED TO CLIPBOARD"
	OS.set_clipboard(str(dat).replace(","," ").replace("[","").replace("]",""))
	$AcceptDialog.popup_centered()


func _on_new_pressed():
	for i in range(0,7):
		for x in range(0,7):
			$editField.set_cell(i,x,0)
			$preview.set_cell(i,x,0)
