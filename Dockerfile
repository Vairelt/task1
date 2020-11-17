FROM docker.pkg.github.com/google/nsjail/nsjail:latest

RUN mkdir -p /var/task/
ADD task1 /var/task/
ADD flag.txt /tmp/flag.txt

RUN chmod 444 /tmp/flag.txt && \
    chmod 111 /var/task/task1

EXPOSE 13337

RUN nsjail \
    -Ml \
    --port 13337 \
    --user nobody \
    --group nogroup \
    --hostname jail \
    --time_limit 30 \
    --cgroup_cpu_ms_per_sec 100 \
    --cgroup_mem_max 8388608 \
    --cgroup_pids_max 16 \
    --env PATH=/bin:/usr/bin \
    --/var/task/task1