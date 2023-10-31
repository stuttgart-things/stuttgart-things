# stuttgart-things/packer

## RENDER TEMPLATE w/ machineShop

```bash
machineshop render \
--source local \
--template packer/os/ubuntu23-pve.pkr.tpl.hcl \
--defaults /home/sthings/projects/github/stuttgart-things/packer/environments/labul-pve.yaml \
--brackets square \
--values "vmTemplateName=u23"
```

## PACKER BUILD

```bash
touch meta-data
packer build -force -var "username=<USERNAME>" -var "password=<PASSWORD>" ubuntu23.pkr.hcl
```



# ---
# configmaps:
#   ansible:
#     {{ .Values.ansibleOsProvioning }}.yaml: |
#       ---
#       - name: Provision vm template during packer build w/ ansible (base profile)
#         hosts: default
#         become: true
#         vars:
#           manage_filesystem: false
#           update_packages: true
#           install_requirements: true
#           install_motd: false
#           configure_rke_node: {{ .Values.rkeTemplateSetup }}
#           username: {{ .Values.ansibleUser }}
#           send_to_msteams: {{ .Values.sendToMSteams }}
#           cloud_init_config_dir: /etc/cloud/cloud.cfg.d
#           os_prerequisites:
#             {{- range .Values.osPrerequisites }}
#             - {{ . }}
#             {{- end }}

#           # RKE SETUP
#           cloudinit: false
#           update_os: true
#           template_creation_setup: true
#           install_docker: false
#           install_docker_compose: false

#           netconfig: |
#             # This is the network config written by 'subiquity'
#             network:
#               ethernets:
#                 ens18:
#                   dhcp4: true
#                   dhcp-identifier: mac
#               version: 2
#               renderer: NetworkManager

#           groups_to_create:
#             - name: sthings
#               gid: 3000

#           users:
#             - username: sthings
#               name: sthings user
#               uid: 1112
#               home: /home/sthings
#               enable_ssh_tcp_forwarding: false
#               groups: ["[[ .admin_group ]]", "sthings"]
#               password: "$6$rounds=656000$7ala77Ra$8/cD2EL.AIGNZhXyjB/MJS2Uru0k37I3yWZ.7jFKwQiG1VvMZtKb.B.z5nX2jb.bsLGlZejM4JwGgVrQHyONO."
#               ssh_key:
#                 - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCslDwiVO/EvWLVVY1Twpc7Lhr9laLPgu+iiOuvMEg8E4hnEDHRPZpdD6YnnJYsLnVHbi8Y3EPDQ2UDbHnfgeYPa94XHdhGSCsIX+tA5+PLFSFgoyCtA5oWc3vrm58RX6DQXf7fPytwxIESPjIgEDv2BTOEc+pk0S09e3jttmFsrKzB7tOutB3FktcLnxGD75JgBa9/i0zmfcchF2VNZcgZRXJ5JiMGKhaKB7qZ6AoMQlDmCvllLSdCxGIxu/quiBcGhaJBMmpkSTeRouU1YWg05wEjyg47DwJyyEMzvYe6LIHxN3zBXMTBzUKJC1thGNC9yaFeywrz+iaIk66RGcjL sthings"
#                 - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsHiyet7tO+qXYKEy6XBiHNICRfGsBZYIo/JBQ2i16WgkC7rq6bkGwBYtni2j0X2pp0JVtcMO+hthqj37LcGH02hKa24eAoj2UdnFU+bhYxA6Mau1B/5MCkvs8VvBjxtM3FVJE7mY5bZ19YrKJ9ZIosAQaVHiGUu1kk49rzQqMrwT/1PNbUYW19P8J2LsfnaYJIl4Ljbxr0k52MGdbKwgxdph3UKciQz2DhutrmO0gf3Ncn4zpdClldaBtDB0EMMqD3BAtEVsucttzqdeYQwixMTtyuGpAKAJNUqhpleeVhShPZLke0vXxlA6/fyfkSM78gN2FQcRGVPN6hOMkns/b patrick@TPPHERMANN"
#                 - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDvaTdixTdzySc6qQZavxvrBk1KNy4g30pIu9SbxVe6GuPyJzEWUYHvJt6d4YqdpavT21IQkmuex7n4qxg8ZgrmXUTpELLM2y2Uu7va/OUol4t2Q0O7hFr9nsE4CybXBxxutFCfekv4NedJ5WW0zUdrXdM6SWvN4f9kdn7FaECjAdWfz5I4nAz4nztwDh/obWqkNSe0ASPqnTqpxCbsIxLB6dxUnw43v8qBgWVUbIldhos/xtsVQyGRKHNOvGTg+7rCbhhgsy3vpiiCaTBdMtfBEjWrKR9SsHTlS7ftisJXCIBJMbhmc0mjnZ834m9qHXYe1+IoyL3d9dourDTerhBAe3DRLavcUynV6yrMIZor6FWgGrvxf/ZlKPYaFllL7WrAKMGiZLNhwoMvTYmdhXAfZjx2vab+pTvXzDlELKf3kxJcGuasWxV8BdN2x3uzMYvmf+Fp+nfTVk0z9ecEDTwK1wyghGudc4zAo61mHII+GdNMADDDnrg4HLB+9NHPKjNKCmETKymFdQnaoraQ7sj+sSYyWncPZVaYCCA6tMJxEOnu2AnK0G9CG4mF7xmR3LFoVPnHuF4maroPolMInSsCbSNU6IehWujHKGmyVyO09rcEbRaYo0cI9l4X8OBEXbLFeUp7PNnOocU1sjK6zAFxXR9DUOQyKi722vhdporoFQ== odittus"
#                 - "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCv17/cfbIKB8JBeDY/SoWz55tYu7e64BarYpj3UeYrbG/UjbyWh3EnsLyG9cL/Sg4C9by2rsyW2ppJSDCO7R3u+b46RufDVebznHqq1KV1vLwR+eEDANCDnkZswFNG1CZd9VU0zwLuEw8e/gy//qDO2DU4pALe/4BtnHkrNodY+Y6szMP4zkouag+myK4Hzn/vz+95sZ0w+/WUc726uiak8CI1IEBofTnFZCSSKYLRxY779D1+j+rOqE6IW4IOwojGBj0c6UDRQVAhSreLiOvVltyAASZWUGJjoa8zzeC4wH4mtOR/86mHI/zaovHuA6hzoBfP/gYWw74TO+WXQwqMBPvW1n8l3WIthvny2y53OTmdGG4GGI0UcLxehsxRp/ZiAlrwSGA9R735Qnq/IH6jt5NQ/qIxs5S+Ww5oQq90J/5MGAqSv8od1fNqTDRoNDvQRo/wSH0Dt11GNCqk4weqFBpij3h3oykhsRXniuYbsM2n/RRmJ4Q9dL2xdYKfBA0= acalva@TPACALVA-1"

#           vault_instances:
#             {{- range .Values.installCAs }}
#             - {{ . }}
#             {{- end }}

#         roles:
#           - role: manage-filesystem
#             when: manage_filesystem|bool

#           - role: install-requirements
#             when: install_requirements|bool

#           - role: configure-rke-node
#             when: configure_rke_node|bool

#         tasks:
#           - name: Install vault ca certificate to local system from multiple instances
#             ansible.builtin.include_role:
#               name: install-configure-vault
#               tasks_from: install-ca-auth
#             vars:
#               vault_url: {{`{{printf "%q" "{{ vault_instance }}" }}`}}
#             loop: {{`{{printf "%q" "{{ vault_instances }}" }}`}}
#             loop_control:
#               loop_var: vault_instance
#             when: vault_instances is defined

#           - name: Send webhook to msteams
#             ansible.builtin.include_role:
#               name: create-send-webhook
#             vars:
#               summary_text: base-os-setup was executed
#               msteams_url: "{{ .Values.msTeamsWebhookUrl }}"
#               card_title: base-os-setup was executed
#               act_image: {{`{{printf "%q" "{{ logo_pic }}" }}`}}
#               act_title: {{`{{printf "%q" "{{ quotes | random }}" }}`}}
#               act_text: {{`{{printf "%q" "{{ quotes | random }}" }}`}}
#               os_facts: |
#                 packer base-os-setup was executed on {{`{{printf "%q" "{{ ansible_fqdn }}" }}`}}
#               ms_teams_notification_type: "simple"
#             tags: notify
#             ignore_errors: true
#             when: send_to_msteams|bool

#         post_tasks:
#           - ansible.builtin.copy:
#               dest: /etc/netplan/00-installer-config.yaml
#               content: {{`{{printf "%q" "{{ netconfig }}" }}`}}
#             when: ansible_os_family == 'Debian'

#           - block:
#               - name: Install cloud-init
#                 ansible.builtin.package:
#                   name:
#                     - cloud-init
#                   state: present

#               - name: Find all cfg files in {{`{{printf "%q" "{{ cloud_init_config_dir }}" }}`}}
#                 ansible.builtin.find:
#                   paths: {{`{{printf "%q" "{{ cloud_init_config_dir }}" }}`}}
#                   patterns: "*.cfg"
#                 register: cfg_files_to_delete

#               - name: Remove all may existing cloud config
#                 ansible.builtin.file:
#                   path: {{`{{printf "%q" "{{ item.path }}" }}`}}
#                   state: absent
#                 with_items: {{`{{printf "%q" "{{ cfg_files_to_delete.files }}" }}`}}

#               - name: Reset may existing cloud config
#                 ansible.builtin.shell: |
#                   cloud-init clean -s -l
#                 ignore_errors: true

#             when: install_cloud_init is defined
