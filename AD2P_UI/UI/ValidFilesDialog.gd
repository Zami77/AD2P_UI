extends AcceptDialog

func _on_GetValidFiles_got_valid_files(valid_files):
	self.dialog_text = valid_files
	self.popup()
