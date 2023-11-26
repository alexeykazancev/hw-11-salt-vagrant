nginx_pkg:
  pkg.installed:
    - name: nginx
 
# Copy nginx conf to minion
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/nginx.conf
    - user: demouser
    - group: root
    - mode: 640

  nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - require:
      - pkg: nginx_pkg