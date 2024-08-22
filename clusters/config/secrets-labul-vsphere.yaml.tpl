---
secrets:
  cert-manager:
    - vault:secretName=cert-manager-secret, secretNamespace=flux-system

template:
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