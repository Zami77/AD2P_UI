extends HTTPRequest

signal ad2p_scan_results(scan_output)

onready var PostAd2pScan: HTTPRequest = get_node("../PostAd2pScan")

func _ready():
	return PostAd2pScan.connect("request_completed", self, "_on_request_completed")

func post_ad2p_scan(filepath: String):
	var file = File.new()
	file.open(filepath, File.READ)
	var file_content = file.get_buffer(file.get_len())
	
	var req_body = PoolByteArray()
	req_body.append_array("\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\n".to_utf8())
	var content_disposition = "Content-Disposition: form-data; name=\"file\"; filename=\"" + filepath + "\"\r\n"
	req_body.append_array(content_disposition.to_utf8())
	req_body.append_array("Content-Type: text/x-c\r\n\r\n".to_utf8())
	req_body.append_array(file_content)
	req_body.append_array("\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\n".to_utf8())
	
	var headers = [
		"Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
		"Content-Length: " + String(req_body.size())
	]
	
	var endpoint = AD2PConstants.AD2P_BASE_URI + AD2PConstants.AD2P_POST_AD2P_SCAN
	var resp_code = PostAd2pScan.request_raw(endpoint, headers, true, HTTPClient.METHOD_POST, req_body)
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
