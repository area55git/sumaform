{% for keypath in grains.get('gpg_keys') | default([], true) %}
{% set keyname =  salt['file.basename'](keypath)  %}
gpg_key_copy_{{ keypath }}:
  file.managed:
    - name: /tmp/{{ keyname }}
    - source: salt://{{ keypath }}
install_{{ keypath }}:
  cmd.wait:
    - name: rpm --import /tmp/{{ salt['file.basename'](keypath) }}
    - watch:
      - file: /tmp/{{ keyname }}
{% endfor %}

{% if grains['os'] == 'SUSE' %}

{% if grains['osrelease'] == '42.3' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.3-Pool.repo
    - source: salt://default/repos.d/openSUSE-Leap-42.3-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.3-Update.repo
    - source: salt://default/repos.d/openSUSE-Leap-42.3-Update.repo
    - template: jinja

tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/systemsmanagement-saltstack_products-next.repo
    - source: salt://default/repos.d/systemsmanagement-saltstack_products-next.repo
    - template: jinja

tools_update_repo:
  file.touch:
    - name: /tmp/no_tools_update_repo_needed

tools_additional_repo:
  file.touch:
    - name: /tmp/no_tools_additional_repo_needed
{% endif %} {# grains['osrelease'] == '42.3' #}


{% if grains['osrelease'] == '11.4' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP4-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-11-SP4-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP4-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-11-SP4-x86_64-Update.repo
    - template: jinja

{% if grains.get('use_unreleased_updates') | default(False, true) %}
test_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP4-x86_64-Test-Update.repo
    - source: salt://default/repos.d/SLE-11-SP4-x86_64-Test-Update.repo
    - template: jinja
{% endif %}

tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-11-x86_64.repo
    - template: jinja

tools_update_repo:
  file.touch:
    - name: /tmp/no_tools_update_repo_needed

{% if '3.2-released' in grains.get('version') | default('', true) %}

tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-11-Beta-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-11-Beta-x86_64.repo
    - template: jinja

{% elif 'released' in grains.get('version') | default('released', true) %}

tools_additional_repo:
  file.touch:
    - name: /tmp/no_tools_additional_repo_needed

{% elif 'nightly' in grains.get('version') | default('', true) %}

tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_3.2_SLE-Manager-Tools-11-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_3.2_SLE-Manager-Tools-11-x86_64.repo
    - template: jinja

{% elif 'head' in grains.get('version') | default('', true) %}

tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-11-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-11-x86_64.repo
    - template: jinja

{% endif %}

{% endif %} {# grains['osrelease'] == '11.4' #}


{% if '12' in grains['osrelease'] %}
{% if grains['osrelease'] == '12' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-12-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-12-x86_64-Update.repo
    - template: jinja

{% if grains.get('use_unreleased_updates') | default(False, true) %}
test_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-x86_64-Test-Update.repo
    - source: salt://default/repos.d/SLE-12-x86_64-Test-Update.repo
    - template: jinja
{% endif %}

{% elif grains['osrelease'] == '12.1' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP1-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-12-SP1-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP1-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-12-SP1-x86_64-Update.repo
    - template: jinja

{% if grains.get('use_unreleased_updates') | default(False, true) %}
test_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP1-x86_64-Test-Update.repo
    - source: salt://default/repos.d/SLE-12-SP1-x86_64-Test-Update.repo
    - template: jinja
{% endif %}

{% elif grains['osrelease'] == '12.2' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP2-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-12-SP2-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP2-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-12-SP2-x86_64-Update.repo
    - template: jinja

{% if grains.get('use_unreleased_updates') | default(False, true) %}
test_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP2-x86_64-Test-Update.repo
    - source: salt://default/repos.d/SLE-12-SP2-x86_64-Test-Update.repo
    - template: jinja
{% endif %}

{% elif grains['osrelease'] == '12.3' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP3-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-12-SP3-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP3-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-12-SP3-x86_64-Update.repo
    - template: jinja

{% if grains.get('use_unreleased_updates') | default(False, true) %}
test_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP3-x86_64-Test-Update.repo
    - source: salt://default/repos.d/SLE-12-SP3-x86_64-Test-Update.repo
    - template: jinja
{% endif %}

{% endif %}

tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Pool.repo
    - template: jinja

tools_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-12-x86_64-Update.repo
    - template: jinja

{% if '3.2-released' in grains.get('version') | default('', true) %}

tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-12-Beta-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-12-Beta-x86_64.repo
    - template: jinja

{% elif 'released' in grains.get('version') | default('released', true) %}

tools_additional_repo:
  file.touch:
    - name: /tmp/no_tools_additional_repo_needed

{% elif 'nightly' in grains.get('version') | default('', true) %}

tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_3.2_SLE-Manager-Tools-12-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_3.2_SLE-Manager-Tools-12-x86_64.repo
    - template: jinja

{% elif ('head' in grains.get('version') | default('', true)) or ('test' in grains.get('version') | default('', true)) %}
tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-12-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-12-x86_64.repo
    - template: jinja

{% endif %}
{% endif %} {# '12' in grains['osrelease'] #}


{% if '15' in grains['osrelease'] %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-15-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-15-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-15-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-15-x86_64-Update.repo
    - template: jinja

{% if grains.get('use_unreleased_updates') | default(False, true) %}
test_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-15-x86_64-Test-Update.repo
    - source: salt://default/repos.d/SLE-15-x86_64-Test-Update.repo
    - template: jinja
{% endif %}

tools_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-15-x86_64-Pool.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-15-x86_64-Pool.repo
    - template: jinja

tools_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-Manager-Tools-SLE-15-x86_64-Update.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-SLE-15-x86_64-Update.repo
    - template: jinja

{% if 'released' in grains.get('version') | default('released', true) %}

tools_additional_repo:
  file.touch:
    - name: /tmp/no_tools_additional_repo_needed

{% elif 'nightly' in grains.get('version') | default('', true) %}

tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_3.2_SLE-Manager-Tools-15-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_3.2_SLE-Manager-Tools-15-x86_64.repo
    - template: jinja

{% elif ('head' in grains.get('version') | default('', true)) or ('test' in grains.get('version') | default('', true)) %}
tools_additional_repo:
  file.managed:
    - name: /etc/zypp/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-15-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_Head_SLE-Manager-Tools-15-x86_64.repo
    - template: jinja

{% endif %}
{% endif %} {# '15' in grains['osrelease'] #}


allow_vendor_changes:
  {% if grains['osfullname'] == 'Leap' %}
  file.managed:
    - name: /etc/zypp/vendors.d/opensuse
    - makedirs: True
    - contents: |
        [main]
        vendors = openSUSE,openSUSE Build Service,obs://build.suse.de/Devel:Galaxy,obs://build.opensuse.org
  {% else %}
  file.managed:
    - name: /etc/zypp/vendors.d/suse
    - makedirs: True
    - contents: |
        [main]
        vendors = SUSE,openSUSE Build Service,obs://build.suse.de/Devel:Galaxy,obs://build.opensuse.org
  {% endif %}

refresh_default_repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    - require:
      - file: os_pool_repo
      - file: os_update_repo
      - file: tools_pool_repo
      - file: tools_update_repo
      - file: tools_additional_repo
{% endif %}

{% if grains['os_family'] == 'RedHat' %}

galaxy_key:
  file.managed:
    - name: /tmp/galaxy.key
    - source: salt://default/gpg_keys/galaxy.key
  cmd.wait:
    - name: rpm --import /tmp/galaxy.key
    - watch:
      - file: galaxy_key

{% if grains['osmajorrelease'] == '7' %}
tools_pool_repo:
  file.managed:
    - name: /etc/yum.repos.d/SLE-Manager-Tools-RES-7-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-RES-7-x86_64.repo
    - template: jinja
    - require:
      - cmd: galaxy_key

suse_res7_key:
  file.managed:
    - name: /tmp/suse_res7.key
    - source: salt://default/gpg_keys/suse_res7.key
  cmd.wait:
    - name: rpm --import /tmp/suse_res7.key
    - watch:
      - file: suse_res7_key

{% if '3.2-released' in grains.get('version') | default('', true) %}
tools_update_repo:
  file.managed:
    - name: /etc/yum.repos.d/SLE-Manager-Tools-RES-7-Beta-x86_64.repo
    - source: salt://default/repos.d/SLE-Manager-Tools-RES-7-Beta-x86_64.repo
    - template: jinja
    - require:
      - cmd: galaxy_key

{% elif 'head' in grains.get('version') | default('', true) %}
tools_update_repo:
  file.managed:
    - name: /etc/yum.repos.d/Devel_Galaxy_Manager_Head_RES-Manager-Tools-7-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_Head_RES-Manager-Tools-7-x86_64.repo
    - template: jinja
    - require:
      - cmd: galaxy_key

{% elif 'nightly' in grains.get('version') | default('', true) %}
tools_update_repo:
  file.managed:
    - name: /etc/yum.repos.d/Devel_Galaxy_Manager_3.2_RES-Manager-Tools-7-x86_64.repo
    - source: salt://default/repos.d/Devel_Galaxy_Manager_3.2_RES-Manager-Tools-7-x86_64.repo
    - template: jinja
    - require:
      - cmd: galaxy_key
{% endif %}
{% endif %} {# grains['osmajorrelease'] == '7' #}

{% endif %} {# grains['os_family'] == 'RedHat' #}

{% if grains['additional_repos'] %}
{% for label, url in grains['additional_repos'].items() %}
{{ label }}_repo:
  pkgrepo.managed:
    - humanname: {{ label }}
    - baseurl: {{ url }}
    - priority: 94
    - gpgcheck: 0
{% endfor %}

refresh_additional_repos:
  cmd.run:
{% if grains['os_family'] == 'RedHat' %}
    - name: echo "(repository refresh not needed with yum)"
{% else %}
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
{% endif %}
    - require:
      {% for label, url in grains['additional_repos'].items() %}
      - pkgrepo: {{ label }}_repo
      {% endfor %}
{% endif %}

default_repos:
  test.nop: []
