cat << EOF > ./send-to-homerun.yaml
---
- hosts: localhost
  tasks:
    - name: Sende
      uri:
        url: https://homerun.homerun-dev.sthings-vsphere.labul.sva.de/generic
        method: POST
        body: |
          {
            "Title": "{{ title }}",
            "Info": "{{ message }}",
            "Severity": "{{ severity }}",
            "Author": "{{ author }}",
            "Timestamp": "{{ timestamp }}",
            "System": "{{ system }}",
            "Tags": "{{ technologyTags }}",
            "AssigneeAddress": "{{ assigneeAddress }}",
            "AssigneeName": "{{ assigneeName }}",
            "Artifacts": "{{ artifacts }}",
            "Url": "{{ url }}"
          }
        body_format: json
        headers:
          Content-Type: "application/json"
          X-Auth-Token: "IhrGeheimerToken"
        status_code: 200
      register: response
EOF