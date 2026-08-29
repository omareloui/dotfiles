local odysseyG8 = "desc:Samsung Electric Company Odyssey G85SD H1AK500000"

hl.monitor({
	output = odysseyG8,
	mode = "3440x1440@175",
	position = "0x0",
	scale = 1,
	vrr = 1,
})

hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = 1.5,
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.workspace_rule({
	workspace = "1",
	monitor = odysseyG8,
	default = true,
})
