#!/bin/bash
####################################################
#              confg section                       #
####################################################
#            set the parapeterns                   #
####################################################
whoami=`whoami`    # Dont change this parametr
key_data_start="$(cat ~/.ssh/id_rsa.pub)" # Dont change this parametr
#############config#################################
ResourceGroup=myResourceGroup
myVnet=myVnet
mySubnet=mySubnet
myPublicIP=myPublicIP
myNetworkSecurityGroup=myNetworkSecurityGroup
MyNIC=MyNIC
myVM=myVM
MyLb=MyLb
PublicIPMyLb=PublicIPMyLb
port_for_ssh=8888
#####################################################


### set admin_username
if [ -n "$1" ];
then
  ver="$1"
  admin_username="$(echo -e "${ver}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
  echo "the admin_username : $admin_username"
else
  echo "Enter the VM admin user name:"
  read admin_username
  echo "The VM now is $admin_username"
fi

### set admin_password
if [ -n "$2" ];
then
  ver="$2"
  admin_password="$(echo -e "${ver}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
else
  echo "Enter the VM user pawword:"
  read admin_password
fi




###########################################################################################################
#                           stage 1 - create network,vm,subnet                                           #
###########################################################################################################

#create temp file for pub key
touch ../tmp/tempdata.txt
echo "key_data : $key_data_start" > ../tmp/tempdata.txt

#start playbook to crete vm, network, subnet
ansible-playbook ../create_vm_azure.yml -i ../host --extra-vars "ResourceGroup=myResourceGroup \
                                                           myVnet=$myVnet mySubnet=$mySubnet \
                                                           myPublicIP=$myPublicIP \
                                                                                       myNetworkSecurityGroup=$myNetworkSecurityGroup \
                                                                                       MyNIC=$MyNIC \
                                                                                       myVM=$myVM \
                                                           admin_username=$admin_username \
                                                                                   admin_password=$admin_password \
                                                           whoami=$whoami"
#clear temp data
rm -Rf ../tmp/tempdata.txt

###########################################################################################################
#                           stage 2 - create nat rules,  create lb                                       #
###########################################################################################################

az network lb create -g $ResourceGroup -n $MyLb --sku Basic --public-ip-address-allocation static
az network lb address-pool create -g $ResourceGroup --lb-name $MyLb -n MyAddressPool
az network lb frontend-ip create -g $ResourceGroup -n LoadBalancerFrontEnd --lb-name $MyLb --public-ip-address $PublicIPMyLb
az network lb inbound-nat-rule create -g $ResourceGroup --lb-name $MyLb -n MyNatRule-80  --protocol Tcp --frontend-port 80 --backend-port 80 --frontend-ip-name LoadBalancerFrontEnd
az network lb inbound-nat-rule create -g $ResourceGroup --lb-name $MyLb -n MyNatRule-443  --protocol Tcp --frontend-port 443 --backend-port 443 --frontend-ip-name LoadBalancerFrontEnd
az network lb inbound-nat-rule create -g $ResourceGroup --lb-name $MyLb -n MyNatRule-22  --protocol Tcp --frontend-port $port_for_ssh --backend-port 22 --frontend-ip-name LoadBalancerFrontEnd
az network nic ip-config inbound-nat-rule add -g $ResourceGroup --lb-name $MyLb --nic-name $MyNIC -n default --inbound-nat-rule MyNatRule-80
az network nic ip-config inbound-nat-rule add -g $ResourceGroup --lb-name $MyLb --nic-name $MyNIC -n default --inbound-nat-rule MyNatRule-443
az network nic ip-config inbound-nat-rule add -g $ResourceGroup --lb-name $MyLb --nic-name $MyNIC -n default --inbound-nat-rule MyNatRule-22





###########################################################################################################
#                                          stage3 - isntall nginx,certs,deps                             #
###########################################################################################################
echo > ../host
echo "[new]" > ../host
az network public-ip show -g MyResourceGroup -n PublicIPMyLb | grep ipAddress | cut -d : -f 2 |  tr -d \" | tr -d \, >> ../host

ansible-playbook ../firstconnect.yml  -i ../host --extra-vars "ansible_sudo_pass=$admin_password" -e "ansible_port=$port_for_ssh"

ansible-playbook ../create_ss_cert.yml  -i ../host --extra-vars "ansible_sudo_pass=$admin_password" -e "ansible_port=$port_for_ssh"
ansible-playbook ../nginx/install_set_nginx.yaml  -i ../host --extra-vars "ansible_sudo_pass=$admin_password" -e "ansible_port=$port_for_ssh"


ip_adress_vm=`cat ../host | awk '(NR == 2)' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`

echo "###################################################################"
echo "##               The process is finished now                      #"
echo "###################################################################"
echo " To access the Vm via ssh use:"
echo " Ip address: $ip_adress_vm"
echo " port_for_ssh: $port_for_ssh"
echo " admin_username: $admin_username"
echo " admin_password: $admin_password"
echo " To open https use address: https://$ip_adress_vm"
echo "###################################################################"