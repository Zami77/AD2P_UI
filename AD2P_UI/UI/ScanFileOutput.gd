extends TextEdit



func _on_PostAd2pScan_ad2p_scan_results(scan_output):
	self.text = scan_output
