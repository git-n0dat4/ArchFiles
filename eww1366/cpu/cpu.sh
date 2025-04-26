#!/bin/bash
get_cpu_stats() {
  read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
  idle_all=$(( idle + iowait ))
  non_idle=$(( user + nice + system + irq + softirq + steal ))
  total=$(( idle_all + non_idle ))
  echo "$idle_all $total"
}

read idle1 total1 < <(get_cpu_stats)
sleep 1
read idle2 total2 < <(get_cpu_stats)

delta_idle=$(( idle2 - idle1 ))
delta_total=$(( total2 - total1 ))
delta_usage=$(( delta_total - delta_idle ))

if [ "$delta_total" -eq 0 ]; then
  cpu_usage=0
else
  cpu_usage=$(( 100 * delta_usage / delta_total ))
fi

if [[ "$1" == --cpu ]]; then
   printf "%02d%%\n" "$cpu_usage"
fi
