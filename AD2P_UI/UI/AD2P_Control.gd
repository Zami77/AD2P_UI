extends Control



func _ready():
	pass # Replace with function body.

func ad2p_scan_file(path: String):
	# TODO: send http request to backend with file.
	pass

func _on_FileDialog_file_selected(path: String):
	ad2p_scan_file(path)
