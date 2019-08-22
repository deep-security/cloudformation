#!/bin/bash
set +o history
yum clean all
rm /root/.ssh/authorized_keys
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
passwd -d root
passwd -d admin
rm -f /etc/udev/rules.d/70-persistent-net.rules
history -c && history -w
find /var/log -type f -regex '^.*-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$' -print0 | xargs rm -f
find /var/log -type f -| while read -r f; do echo -ne '' > "$f"; done
sync
sync
poweroff
