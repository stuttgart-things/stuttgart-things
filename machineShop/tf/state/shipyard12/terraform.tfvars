vsphere_datastore = "/LabUL/datastore/UL-ESX-SAS-02"
vsphere_resource_pool = "/LabUL/host/Cluster01/Resources"
vsphere_network = "/LabUL/network/MGMT-10.31.101"
vsphere_vm_template = "/LabUL/vm/phermann/vm-templates/fedora38"
vsphere_datacenter = "LabUL"
vsphere_vm_folder_path = "phermann/testing"
/*
vsphere_user={{ call .VaultSecretSurvey "User|cloud/data/vsphere:username" }}
vsphere_password={{ call .VaultSecretSurvey "Password|cloud/data/vsphere:password" }}
vsphere_server={{ call .VaultSecretSurvey "Vsphere Server|cloud/data/vsphere:ip" }}
vm_ssh_user={{ call .SingleInputSurvey "VM User Password|sthings" }}
vm_ssh_password={{ call .VaultSecretSurvey "VM SSH Password|cloud/data/vsphere:vm_ssh_password" }}

*/