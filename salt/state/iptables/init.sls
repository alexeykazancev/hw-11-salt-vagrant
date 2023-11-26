# STATE - IPTABLES

{% set iptables_file = '/etc/sysconfig/iptables' %}

iptables_pkg:
    pkg.installed:
        - name: iptables

{{ iptables_file }}:
    file.managed:
        - user: root
        - group: root
        - mode: 644
        - source: salt://{{ slspath }}/files/{{ grains.id }}.j2
        - template: jinja

flush_tables:
    iptables.flush:
        - table: filter
        - family: ipv4
        - onchanges:
            - file: "{{ iptables_file }}"

restore_tables: 
    cmd.run:
        - name: "/usr/sbin/iptables-restore < {{ iptables_file }}"
        - onchanges:
            - file: "{{ iptables_file }}"