# Application Deployment

## Prerequisites

1. Bootstrap infrastructure has been deployed;
1. Bootstrap infrastructure has been configured;
1. Deployer has been configured with working Ansible;
1. SAP Library contains all media for the relevant BoM;
1. SAP infrastructure has been deployed;
1. SAP Library contains all Terraform state files for the environment;
1. Deployer has Ansible connectivity to SAP Infrastructure (e.g. SSH keys in place/available via key vault);
1. Ansible inventory has been created.

## Inputs

1. BoM file;
1. Ansible inventory that details deployed SAP Infrastructure. **Note:** Inventory contents and format TBD, but may contain reference to the SAP Library;
1. SID (likely to exist in Ansible inventory in some form);
1. Unattended install template.

## Process

1. Log on to the Deployer VM, and navigate to the `ansible_config_files` directory in your SAP System directory, e.g.

   ```shell
   cd ~/Azure_SAP_Automated_Deployment/WORKSPACES/SAP_SYSTEM/NP-CEUS-SAP0-X00/ansible_config_files
   ```

1. Run Ansible playbooks which deploy SAP product components (using SWPM, or for SAP HANA hdblcm):

   __Note *:__ Commands marked below do not yet have automated playbooks covering their installation. For manual installation instructions see the Prepare INI file documentation

   1. Install the SCS:

      ```shell
      ansible-playbook -i hosts ~/Azure_SAP_Automated_Deployment/sap-hana/deploy/ansible/playbook_install_scs.yml
      ```

   1. Install the HANA Database *:

      ```shell
      ansible-playbook -i hosts ~/Azure_SAP_Automated_Deployment/sap-hana/deploy/ansible/playbook_install_hana.yml
      ```

   1. Install the Database Content *:

      ```shell
      ansible-playbook -i hosts ~/Azure_SAP_Automated_Deployment/sap-hana/deploy/ansible/playbook_install_db.yml
      ```

   1. Install the Primary Application Server *:

      ```shell
      ansible-playbook -i hosts ~/Azure_SAP_Automated_Deployment/sap-hana/deploy/ansible/playbook_install_pas.yml
      ```

   1. Install the Additional Application Server(s) *:

      ```shell
      ansible-playbook -i hosts ~/Azure_SAP_Automated_Deployment/sap-hana/deploy/ansible/playbook_install_aas.yml
      ```

   1. Install the Web Dispatcher Server(s) *:

      ```shell
      ansible-playbook -i hosts ~/Azure_SAP_Automated_Deployment/sap-hana/deploy/ansible/playbook_install_web.yml
      ```

   Each of the above playbooks:

      1. Mounts the appropriate file shares from the SCS VM
      1. Configures OS groups and users using configurable gids/uids with viable defaults for greenfield systems
         1. `<SID>adm` user has the same UID across all systems using that SID
         1. `sapsys` group has same GID across all systems
         1. `sapadm` user has same UID across all systems
      1. Configures SAP OS prerequisites
         1. O/S dependencies (e.g. those found in SAP notes such as [2369910](https://launchpad.support.sap.com/#/notes/2369910))
         1. Software dependencies (e.g. those found in SAP notes such as [2365849](https://launchpad.support.sap.com/#/notes/2365849))
      1. Installs the SAP product via SWPM or hdblcm where appropriate

## Results and Outputs

1. SAP product has been deployed and running - ready to handle SAP client requests
1. Connection details/credentials so the Basis Administrator can configure any SAP clients