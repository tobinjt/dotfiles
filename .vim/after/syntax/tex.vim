" I have extra URL formatting commands
syn region texURLZone           matchgroup=texURLZone start="\\\(urlLastChecked\|daemonDocURL\|urlLastCheckedNoParens\)\(\[.\{-}\]\)\?{" end="}\|%stopzone\>"    contains=@texURLGroup
