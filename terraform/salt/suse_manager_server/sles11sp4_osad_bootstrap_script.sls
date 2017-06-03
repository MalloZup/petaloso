# Run with:
# sudo salt-call --local state.sls suse_manager_server.sles11sp4_osad_bootstrap_script

mgr_sync_auth:
  file.append:
    - name: /root/.mgr-sync
    - text: |
        mgrsync.user = admin
        mgrsync.password = admin

scc_data_refresh:
{% if '2.1' in grains['version'] %}
  cmd.run:
    - name: mgr-sync enable-scc
    - creates: /var/lib/spacewalk/scc/migrated
    - require:
      - file: mgr_sync_auth
{% else %}
  cmd.run:
    - name: mgr-sync refresh
    - require:
      - file: mgr_sync_auth
{% endif %}

sync_sles11sp4_channels:
  cmd.run:
    - name: mgr-sync add channel sles11-sp4-pool-x86_64 sles11-sp4-updates-x86_64 sles11-sp4-suse-manager-tools-x86_64
    - unless: mgr-sync list channel -c -f sles11-sp4-suse-manager-tools-x86_64 | grep "\[I\] sles11-sp4-suse-manager-tools-x86_64"
    - require:
      - cmd: scc_data_refresh

create_sles11sp4_activation_key:
  cmd.run:
    - name: |
{% if '2.1' in grains['version'] %}
        spacecmd -u admin -p admin -- activationkey_create -n sles11sp4-osad -d sles11sp4-osad -b sles11-sp4-pool-x86_64 -e provisioning_entitled &&
{% else %}
        spacecmd -u admin -p admin -- activationkey_create -n sles11sp4-osad -d sles11sp4-osad -b sles11-sp4-pool-x86_64 &&
{% endif %}
        spacecmd -u admin -p admin -- activationkey_addchildchannels 1-sles11sp4-osad sles11-sp4-updates-x86_64 sles11-sp4-suse-manager-tools-x86_64 &&
        spacecmd -u admin -p admin -- activationkey_addpackages 1-sles11sp4-osad osad rhncfg-actions
    - unless: spacecmd -u admin -p admin activationkey_list | grep -x 1-sles11sp4-osad
    - require:
      - cmd: sync_sles11sp4_channels

create_sles11sp4_bootstrap_script:
  cmd.run:
    - name: rhn-bootstrap --activation-keys=1-sles11sp4-osad --script=bootstrap-sles11sp4-osad.sh --allow-config-actions --no-up2date
    - creates: /srv/www/htdocs/pub/bootstrap/bootstrap-sles11sp4-osad.sh
    - require:
      - cmd: create_sles11sp4_activation_key

create_sles11sp4_bootstrap_script_md5:
  cmd.run:
    - name: sha512sum /srv/www/htdocs/pub/bootstrap/bootstrap-sles11sp4-osad.sh > /srv/www/htdocs/pub/bootstrap/bootstrap-sles11sp4-osad.sh.sha512
    - creates: /srv/www/htdocs/pub/bootstrap/bootstrap-sles11sp4-osad.sh.sha512
    - require:
      - cmd: create_sles11sp4_bootstrap_script
