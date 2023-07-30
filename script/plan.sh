export KUBE_CONFIG_PATH=~/.kube/config
terraform plan -var-file var/dev/config.tfvars -out tf.plan