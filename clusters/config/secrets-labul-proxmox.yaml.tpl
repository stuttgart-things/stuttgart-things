---
secrets:
  cert-manager:
    - vault:secretName=cert-manager-secret, secretNamespace=flux-system
  tekton:
    - vault:secretName=tekton-vault-secret, secretNamespace=flux-system
  gh-rss:
    - github:secretName=rss-github-secret, secretNamespace=flux-system
  flux-notifications:
    - github:secretName=flux-github-secret, secretNamespace=flux-system
  gitlab-runner:
    - gitlab:secretName=gitlab-runner-secret, secretNamespace=flux-system
  crossplane:
    - s3:secretName=s3, secretNamespace=flux-system

template:
  s3: |
    ---
    apiVersion: v1
    kind: Secret
    metadata:
        name: {{ .secretName }}
        namespace: {{ .secretNamespace }}
    data:
        AWS_ACCESS_KEY_ID: ENC[AES256_GCM,data:C2kDM7/+BCKAcsL3,iv:Uz4qomUPCGZZGEjnxddz18uExkyFxniCkv3xTpPg+a0=,tag:LBrFBjpNST9hKFCVqXRYJg==,type:str]
        AWS_SECRET_ACCESS_KEY: ENC[AES256_GCM,data:NGgvCnHENLdfxSO+,iv:6QuB0WZIjrux+JNOEv3TUl4jOOYOkANtuuJ+Ez9svVA=,tag:lyFn0N8Aej/WwN2AfuIIcg==,type:str]
    type: Opaque
    sops:
        kms: []
        gcp_kms: []
        azure_kv: []
        hc_vault: []
        age:
            - recipient: age1g438n4lx6h7x7u42q652e9ygzrkkwlul49e8zsmsrfmxm9k3tvcsykhff4
              enc: |
                -----BEGIN AGE ENCRYPTED FILE-----
                YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSAwZWJSNGJzc3hFOVYzaXEy
                bnIvTkxxakxKNEVIeHZLYUM4dFQ5Z2NHOHlJCnlkZ3ZvRUJnY3NpR3R6SDN6bFFC
                R2xLWFhLcFBoVjhlbVRRNnZwK3hYdlUKLS0tIHQ0Qmo1QWJoSmh4TVMwTjV2NlNE
                eFE5cUFLZ2k3U1V5bnBhVVZJZDNhaDgKWpQ6H0XWJGx55O4hSn+r2qV0isCIT8Ha
                vm0BaWdER9jksefcOWlVnQlHWc70w+Ah0SSrGtXeS/3VrX6S9sPHsg==
                -----END AGE ENCRYPTED FILE-----
        lastmodified: "2024-02-27T13:17:55Z"
        mac: ENC[AES256_GCM,data:8NEb1XV7a/2UwNpPfPLSPwES+i4/wuwDGfza7ssYTYvZJylQj05B8g/0JyPeFHCVUkK0fsk3kadBnhUx792V/TJ9JVXaKSYeEIiWmxZpZYN/zMp4JeFWsRR8EGLzvnYRN6+pLCKQMRIAENY8I+hue9nyvuN46mEgytLPFJvsCZI=,iv:h4tXQyiaFpubpglgH+yASNDfD9XgK/IY82Q2t1NNN5Q=,tag:t+Jw7p9QmGVTzPJkBTvWaA==,type:str]
        pgp: []
        encrypted_regex: ^(data|stringData)$
        version: 3.8.1

  github: |
    ---
    apiVersion: v1
    kind: Secret
    metadata:
        name: {{ .secretName }}
        namespace: {{ .secretNamespace }}
    type: Opaque
    stringData:
        GIT_REPO_URL: ENC[AES256_GCM,data:ecQ3dhzZSNatT7WwKB+L60I+2c0ZOVRXV2H3v/V1lxSBifx1cb4DlYWPOVp27WWgZr0OUw==,iv:wqW31LTV2g/zkyAmqVGX1f3rEHje7ZE6uMjc98IlQxo=,tag:XA3zpmnNe99wAgN6K+fJJw==,type:str]
        MS_TEAMS_URL: ENC[AES256_GCM,data:0Z0BSXQzPZlZiOJ/3Yq636H906DlVkmUAEbMKtJhmHmXaObCZt41aBzoOlSCfvzElZ+ZjBuZeO2zjiMFXCRiLUP8catJXdOTdhH3hWeZ4o225G2u0+VWzmE0ax/jD/EnNtC/MzqvCxLiA9Om0Qr6Yd0q5MalVbEj+IKeZJCST7he3/5DFB7mcpA9rabFvjAD6ziH7St1H568HO9bxAj9NSDPzbmORXHIn4hylwshguqhAcDqIaNGasqsH8AQMmBAVMUvM+hS/5B3JkA=,iv:9Wj1FolTlGa/U3s97TVKhmIRqlOlNk8EVmwLQ1MvI6Q=,tag:Dg64J6Ao1NIzV+IdcS2KlA==,type:str]
        GITHUB_TOKEN: ENC[AES256_GCM,data:j5ku0AkksiJ4YjkQYIpMqQAUX7yLU/fiN7EvEnRi+X4FDXvYEMPeyQ==,iv:ibbhDR/fhiCn58K8aX6ZttVWEFlURQ7cfcYpgT51O20=,tag:NP01HtJt0PG2ZRan1hBmyA==,type:str]
        PRIVATE_KEY: ENC[AES256_GCM,data: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,iv:OIlEGNTSVUF0ntuMMTE88nh4ZtDhxr4CB80yLm/cZ2U=,tag:w4H66uOoFzzeTv0vYqeeEw==,type:str]
        #ENC[AES256_GCM,data:dHaNHc5r0hrW2/XupZyMHY4iuQxglnHiLLZ7J2gJ16cu8o0gJT9EtEBQSyno4L4bMA==,iv:HnuwR9uDpGxmUm6fGlENWIqrIOJ98iwBI0lvV4JvgEI=,tag:ZoIdPrgUij8+NbwmBZKL3Q==,type:comment]
    sops:
        kms: []
        gcp_kms: []
        azure_kv: []
        hc_vault: []
        age:
            - recipient: age1g438n4lx6h7x7u42q652e9ygzrkkwlul49e8zsmsrfmxm9k3tvcsykhff4
              enc: |
                -----BEGIN AGE ENCRYPTED FILE-----
                YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBHdG1jWklQT2RrT0E2NWdN
                MWlpdm0xNlB5emFQbElyK2VISUZpT1ZWOGlBCnl5cnFhMnBFUk1WYnUyMVZ5RjNQ
                aU1nNjkvQ3VHL2ROM0FhaEZXYnVaMHMKLS0tIDc3U3BnWlJDN1huYmRBRkI0VEQx
                aGlQTldNN3I2T1AwRnFid2RlTWMwSE0KQ+IbYzbVBBRHAoR6LRRHTx3GoXQgjFZ2
                GYJhlWmMQgcXAptm5KKqiAgfOKLL4W+oBAM8UQ3M03SjLXl0xy1oaA==
                -----END AGE ENCRYPTED FILE-----
        lastmodified: "2024-03-01T20:28:44Z"
        mac: ENC[AES256_GCM,data:2Z+1pBfjgaZv0MIPozvktHINMaFaPI9JOQUUxPv29cdy4mmGjJQwcFgFoLZVKdngVB4ScVJJMqOjFTHhn7vxbNHGNsz1Q5lirQgfv/UYSwuoqxeIZd/X2GIvIJ+y/V5WJ3OUoMSrFWqJoJjLDRbfjv8IwiUFXGM1pGAcZIhITUs=,iv:quw4yzWpricrqTN4AcCX8knMYuXYLODamNhPh+4GXiE=,tag:MukBI2gHhzRRcPaGUlVKzw==,type:str]
        pgp: []
        encrypted_regex: ^(data|stringData)$
        version: 3.8.1

  vault: |
    ---
    apiVersion: v1
    kind: Secret
    metadata:
        name: {{ .secretName }}
        namespace: {{ .secretNamespace }}
    type: Opaque
    stringData:
        VAULT_TOKEN: ENC[AES256_GCM,data:DG5THyVHN82unrU7t0H1Q9IvL4HdNgUtyGN4Dg==,iv:1dDT+dHgCHp9QgO78cIfJgAsFxcqzTC4M7OvBsfUKrk=,tag:/AvGWly2eRZrqcB1RcisKw==,type:str]
        VAULT_CA_BUNDLE: ENC[AES256_GCM,data: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,iv:YdLpf+s6NJT9z5JR0C7sNwEDpaJZMBrupsHDZPye2xE=,tag:0ApSwoZ10Ci+5yca7WKJQg==,type:str]
        VAULT_PKI_PATH: ENC[AES256_GCM,data:Kdu1YrL5jl2MNKMX5TI25qFLGM0lnVjdkJ4nCQ==,iv:c34FLtHWi/gJYMxMdnTYxMMt3Lipp8/+hWJ+CdnwwX8=,tag:3KxV2izibpFiHliySeDM3A==,type:str]
        VAULT_ADDR: ENC[AES256_GCM,data:Jkn/dxFY4bG8URfN5BlNj1BoEs4d8qXhwN11ngXJrxtFuLFzxAfS8A==,iv:SQwcSBP6qJXvQ7hPQvgPWP9QbdLyBiKNKdQd4HsHyzM=,tag:vObeJ8JkJgZTCdRJKxihfQ==,type:str]
        VAULT_NAMESPACE: ENC[AES256_GCM,data:SxqpvA==,iv:TUTsGyDSZ8LzG1j314XSwNm1lkXSXlEtp6pm9beg8l8=,tag:0uq2yZImxcoFtwCxX86rCA==,type:str]
        VAULT_ROLE_ID: ENC[AES256_GCM,data:4sDwaV7mKzqdIdfQ1ooYUvTZVO4AKJOo5vmo54C1ZhSPwVLN,iv:BPhQZZ+i9WLGma+4p65qK/DpCEkdRPXMPLD96+cK81M=,tag:05mHt4/5qt+r2vmwM6vG8w==,type:str]
        VAULT_SECRET_ID: ENC[AES256_GCM,data:K22484plwGLpzl5Zn6iHXSdieqO6RNW0ewxFxG3KgxjQlvlO,iv:HaxQbqzGi8XpytE1WKFlnBq5Gu9uok338NxzTfCJGJc=,tag:XA0NQActghghuNrOLL/YDQ==,type:str]
    sops:
        kms: []
        gcp_kms: []
        azure_kv: []
        hc_vault: []
        age:
            - recipient: age1g438n4lx6h7x7u42q652e9ygzrkkwlul49e8zsmsrfmxm9k3tvcsykhff4
              enc: |
                -----BEGIN AGE ENCRYPTED FILE-----
                YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBVV1lFSXlCcHlna3cwODQ5
                MUxKU3ZSV0t3SEJEU1ovZGNIeG1KYzBsOEZjClNzY1RFK0MxajEyKyswQjd0K2NY
                Z0dVaTJLVTIvSndTV2IvTnRTZHhldTAKLS0tIFBKbDJ0NGs2SURVdEg2Y2dPVEJp
                S0J5akxuNTZ4SHNYMzliNUNvUXVVYm8KJCXMjjSLLmQJ8z9UdJBA4dE8BhNgeQJb
                nxoivGPfY3Muyb+fSNVm7XbxiHukTNs7glcaGqO/9m623ZY91Qy6AA==
                -----END AGE ENCRYPTED FILE-----
        lastmodified: "2024-02-27T16:07:43Z"
        mac: ENC[AES256_GCM,data:LzPz6SjdAGEkoo/I5Zm1F7NyqRUp3tQKtMnoIzKx3AL3Ym/9ejFAwLzktU8BWBmt4zSyPCpNKy7eMQSP59c2I/7k2wLUcnUMJTF9lFSkeHNBzGYH2IAFxXC7gkHp79kfDgiCxmh4oHnWitXEhJrWII6pWQ12SQE9RS6DZrx+RHg=,iv:pdC27VtFuTanMx8Cj2E0od3uIpofrOrZFBmaeLQpfhg=,tag:kkiqjlpDoRbLrDsXqYYi8g==,type:str]
        pgp: []
        encrypted_regex: ^(data|stringData)$
        version: 3.8.1
  gitlab: |
    ---
    apiVersion: v1
    kind: Secret
    metadata:
        name: {{ .secretName }}
        namespace: {{ .secretNamespace }}
    data:
        RUNNER_TOKEN: ENC[AES256_GCM,data:8Bp6ebSkeQmgh1mZTOGItIZrgmlF6C8im5V7KRjzDRT8Cpni,iv:EQ4IkBSz3Z2iIBLrfd8lW4RcTcXBpGYOyiZ3Fs/+TSg=,tag:4ur2l/Np+V9Mo5igzuUVDA==,type:str]
    type: Opaque
    sops:
        kms: []
        gcp_kms: []
        azure_kv: []
        hc_vault: []
        age:
            - recipient: age1g438n4lx6h7x7u42q652e9ygzrkkwlul49e8zsmsrfmxm9k3tvcsykhff4
              enc: |
                -----BEGIN AGE ENCRYPTED FILE-----
                YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSBvRnNrTS9WRDRPU2JaVnNW
                WXNSZGxkZis0ODNSSmdKSGFjQVY0V1ZqZ2s0CkhZbTQvaHJMRnpxNVd4RjkrcmlJ
                d1lqWEo4dEZ2cTlIR0lET25PYzQ1QWcKLS0tIHpDbk9TZ1FPeEFyUWl5RlEyVjEr
                L0xUeDN0allNSmEzaHluUWQrZXc3SlUKcMU1dgBegaminMwIm3BGLVU4RqS1iMa5
                fd7TUvxBgksZdBBOQQtMyjxv/ievJNVyrwZ7hn5jA3hKszd1FVe5pg==
                -----END AGE ENCRYPTED FILE-----
        lastmodified: "2024-06-19T17:08:47Z"
        mac: ENC[AES256_GCM,data:d2jwKI4KQAN/laTvMeUGxgJQ1WqUHnlD69CyWFEtYPrn1L922TvmFuIvYTHEDJ8KAlZ6F6s2N+qb6/LurBAux6U/kXTPAzZ/C0uNqj+8j7zeexhdSi/sAZy3aSVw4uYNIiy5oNJcaIsV71kSYflQ7Vpx/4IQUHFURO+/pKLysqE=,iv:RTtlSgV70O/oIwFz1qt4bVaWV4A+yuiw6HVJlSoaFgc=,tag:WXTdo7XFJ3E3nRsTdmHXIg==,type:str]
        pgp: []
        encrypted_regex: ^(data|stringData)$
        version: 3.8.1