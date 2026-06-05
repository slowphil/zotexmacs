PLUGIN_ID = zotexmacs@texmacs.org
VERSION = 0.6

.PHONY: xpi
xpi:
	zip -r ../$(PLUGIN_ID)-$(VERSION).xpi \
		manifest.json bootstrap.js \
		content/ locale/ skin/ \
		--exclude "*.DS_Store" "*.pyc"
