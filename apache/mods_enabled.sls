# vim: sts=2 ts=2 sw=2 et ai
{% from "apache/map.jinja" import apache with context %}
include:
  - apache

{% for mod in apache.get("mods_enabled",[]) %}
a2enmod {{mod}}:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/{{mod}}.load
    - order: 225
    - require:
      - pkg: apache
    - watch_in:
      - module: apache-restart  
{% endfor %}

