subarch: bonnell
target: stage1
version_stamp: openrc-@Timestamp@
rel_type: 23.0-openrc
profile: default/linux/x86/23.0/i686
snapshot_treeish: @TREEISH@
source_subpath: default/stage3-i686-openrc
update_seed: yes
update_seed_command: --update --deep --newuse @world
portage_confdir: /var/tmp/catalyst/config/stages
portage_prefix: releng
compression_mode: pixz