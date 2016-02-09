
CFG_DIR=/etc/opscenter
CFG_FILE=$CFG_DIR/opscenterd.conf

sed -i.bak \
-e '/^port\s*=\s*/s/^/#/' \
-e '/^#ssl_[a-z]*\s*=\s*/s/#//g' \
-e '/^enabled\s*=\s*[Ff]alse/s//enabled = True/' $CFG_FILE
