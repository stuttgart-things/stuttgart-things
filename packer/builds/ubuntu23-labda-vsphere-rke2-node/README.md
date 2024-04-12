# stuttgart-things/packer

this file was created at: 2024-04-12 08:59

## INSTALL OS-REQUIREMENTS

```bash
# INSTALL OS REQUIREMENTS
sudo apt install -y sshpass unzip
pip install ansible --upgrade
```

## INSTALL PACKER

```bash
wget https://releases.hashicorp.com/packer/1.10.2/packer_1.10.2_linux_amd64.zip
unzip packer_1.10.2_linux_amd64.zip
sudo mv packer /usr/bin/packer
sudo chmod +x /usr/bin/packer
rm -rf packer_1.10.2_linux_amd64.zip
```

## CLONE/CHANGE TO CONFIG DIR

```bash
# CLONE FROM BRANCH
git clone --branch ubuntu23-labda-vsphere https://github.com/stuttgart-things/stuttgart-things

# OR CLONE FROM MAIN AFTER A PREVIOUS PR-MERGE
git clone https://github.com/stuttgart-things/stuttgart-things

# CHANGE TO DIR
cd stuttgart-things/packer/builds/ubuntu23-labda-vsphere/
```

## START PACKER BUILD

```bash
# ADD LOGGING
export PACKER_LOG_PATH="packerlog.txt"
export PACKER_LOG=1

# IF BUILD WITH FIXED IP IN CONFIG MAYBE NEEDED OR EDIT KNOWN HOSTS FILE
rm -rf ~/.ssh/known_hosts

packer init ubuntu23.pkr.hcl

DATE=$(echo $(date +'%Y-%m-%d'))

packer build -force \
-var "name=${DATE}-ubuntu23-labda-vsphere" \
-var "password=<PASSWORD>" \
-var "password=<PASSWORD>" \
ubuntu23.pkr.hcl
```
