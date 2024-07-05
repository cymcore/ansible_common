docker run -d  \
--name {{ dockerContainerName }} \
--hostname {{ dockerContainerName }} \
--domainname {{ hostDomain }} \
--restart unless-stopped \
-v /volumes/docker/run/{{ dockerContainerName }}/exp/out/:/out/ \
-v /volumes/docker/run/{{ dockerContainerName }}/exp/initfiles/:/initfiles/ \
-v {{ dockerContainerName }}-private:/private/ \
--network {{ containerNetwork }} \
{% if ipAddr is defined and ipAddr is not none %}
--ip {{ ipAddr }} \
{% endif %}
{% if isS6Container == 'y' %}
-v /volumes/docker/run/{{ dockerContainerName }}/exp/etc/fix-attrs.d/:/etc/fix-attrs.d/ \
-v /volumes/docker/run/{{ dockerContainerName }}/exp/etc/cont-init.d/:/etc/cont-init.d/ \
-v /volumes/docker/run/{{ dockerContainerName }}/exp/etc/cont-finish.d/:/etc/cont-finish.d/ \
-v /volumes/docker/run/{{ dockerContainerName }}/exp/etc/services.d/:/etc/services.d/ \
{% endif %}