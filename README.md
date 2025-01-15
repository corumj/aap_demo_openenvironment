# RHDP Simple Ansible on AWX Blank OpenEnvironment


## Required
- ansible-core 

## 
- Make sure ~/.aws/credentials has a default credential setup for the Blank OpenEnvironment
- Copy extra_vars.yml.template to extra_vars.yml and populate with your information.  
- Build and install the two collections, infra and demo.  In each folder -
    - `ansible-galaxy collection build .`
    - `ansible-galaxy collection install <whatever the name of the tar.gz build creates>`