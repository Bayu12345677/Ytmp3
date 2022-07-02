#!/data/data/com.termux/files/usr/bin/bash

# plugins bash moderen
. lib/moduler.sh
# include bash.mod
@require bash.mod

const: __req__ = curlopt

curlopt.headers ["user-agent: Google Bot V3","accept: */*"]
var ch : $(opt.options opsi="-sL --insecure --compressed \$__HEADER__ -o /dev/null -v")
var req : $(curlopt.Curlexec uri="https://google.com" CH="$ch")

@return: req
