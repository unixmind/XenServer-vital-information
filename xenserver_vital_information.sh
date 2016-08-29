#!/bin/env bash

echo "#######################"
echo "Network configuration :"
echo "#######################"
echo "current network" :
ip a
echo

echo "\"/etc/sysconfig/network\" :"
cat /etc/sysconfig/network
echo

echo "\"/etc/resolv.conf\" :"
cat /etc/resolv.conf
echo

echo "XenServer physical interfaces :"
for PIF_UUID in $(xe pif-list params=uuid | awk '/uuid/ {print $NF}')
do
  echo "============================================================================================="
  xe pif-list uuid=$PIF_UUID params=all
  echo "---------------------------------------------------------------------------------------------"
done
echo

echo "RedHat style configuration :"
for IFCG_CONFIG_FILE in $(ls /etc/sysconfig/network-scripts/ifcfg-*)
do
  echo "============================================================================================="
  echo "file \"${IFCG_CONFIG_FILE}\" :"
  cat $IFCG_CONFIG_FILE
  echo "---------------------------------------------------------------------------------------------"
done
echo

echo "virtual network interfaces :"
for VIF_UUID in $(xe vif-list params=uuid | awk '/uuid/ {print $NF}')
do
  echo "============================================================================================="
  xe vif-list uuid=$VIF_UUID params=all
  echo "---------------------------------------------------------------------------------------------"
done
echo


echo "##################"
echo "VM configuration :"
echo "##################"
for VM_UUID in $(xe vm-list power-state=halted params=uuid | awk '/uuid/ {print $NF}')
do
  echo "============================================================================================="
  xe vm-list uuid=$VM_UUID params=all
  echo "---------------------------------------------------------------------------------------------"
done
echo


echo "#######################"
echo "Storage configuration :"
echo "#######################"
echo "LVM structure :"
pvscan
echo
vgscan
echo
lvscan
echo

echo "Storage repository :"
for SR_UUID in $(xe sr-list params=uuid | awk '/uuid/ {print $NF}')
do
  echo "============================================================================================="
  xe sr-list uuid=$SR_UUID params=all
  echo "---------------------------------------------------------------------------------------------"
done
echo

echo "Virtual disk images :"
for VDI_UUID in $(xe vdi-list params=uuid | awk '/uuid/ {print $NF}')
do
  echo "============================================================================================="
  xe vdi-list uuid=$VDI_UUID params=all
  echo "---------------------------------------------------------------------------------------------"
done
echo

echo "Virtual block devices :"
for VBD_UUID in $(xe vbd-list params=uuid | awk '/uuid/ {print $NF}')
do
  echo "============================================================================================="
  xe vbd-list uuid=$VBD_UUID params=all
  echo "---------------------------------------------------------------------------------------------"
done
echo

echo "Physical block devices :"
for PBD_UUID in $(xe pbd-list params=uuid | awk '/uuid/ {print $NF}')
do
  echo "============================================================================================="
  xe pbd-list uuid=$PBD_UUID params=all
  echo "---------------------------------------------------------------------------------------------"
done

