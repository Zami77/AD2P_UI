extends HTTPRequest

signal got_valid_files(valid_files)

onready var GetValidFiles: HTTPRequest = get_node("../GetValidFiles")

func _ready():
	return GetValidFiles.connect("request_completed", self, "_on_request_completed")

func get_valid_files():
	return GetValidFiles.request(AD2PConstants.AD2P_BASE_URI + AD2PConstants.AD2P_GET_VALID_FILES)

func _on_request_completed(_result, response_code, _headers, body):
	if response_code != HTTPClient.RESPONSE_OK:
		return
	
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result.valid_files)
	emit_signal("got_valid_files", String(json.result.valid_files))

func _on_ValidFileButton_pressed():
	get_valid_files()
