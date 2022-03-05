extends Button

onready var file_dialog: FileDialog = get_node("../FileDialog")

func _ready():
	pass


func _process(delta):
	pass


func _on_ScanButton_pressed():
	file_dialog.popup()
