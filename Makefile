README.md: hostname.mdoc
	mandoc $< -T markdown > $@
