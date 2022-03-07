extends HTTPRequest

signal ad2p_scan_results(scan_output)

onready var PostAd2pScan: HTTPRequest = get_node("../PostAd2pScan")

func _ready():
	return PostAd2pScan.connect("request_completed", self, "_on_request_completed")

func post_ad2p_scan(filepath: String):
	var file = File.new()
	file.open(filepath, File.READ_WRITE)
	var file_text = file.get_as_text()
	var resp_code = PostAd2pScan.request(AD2PConstants.AD2P_BASE_URI + AD2PConstants.AD2P_POST_AD2P_SCAN, [], true, HTTPClient.METHOD_POST, file_text)
	return resp_code

func _on_request_completed(_result, response_code, _headers, body):
	if response_code != HTTPClient.RESPONSE_OK:
		print("Post AD2P Scan:" + String(response_code))
		return
	
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	emit_signal("ad2p_scan_results", String(json.result))

func _on_FileDialog_file_selected(filepath: String):
	post_ad2p_scan(filepath)
