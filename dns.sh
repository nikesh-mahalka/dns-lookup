resolvers() {
    awk '$1 == "nameserver" { print $2 }' /etc/resolv.conf
}

# given a nameserver IP address, exit successfully if it's responding, false otherwise
is_resolver_responding() {
    dig +short google.com in ns @$1 >/dev/null
}

for resolver in $(resolvers); do
    printf '%s is %s\n' "$resolver" $(is_resolver_responding $resolver && echo OK || echo BAD)
done
