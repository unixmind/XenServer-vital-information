# XenServer-vital-information
Retrieve XenServer vital information such as network and storage configuration using "xe" commands
## This script can help you to retrieve XenServer hosts configuration
### for example, just launch :
* xenserver_vital_information.sh 2>&1 | tee /tmp/$(hostname).configuration
