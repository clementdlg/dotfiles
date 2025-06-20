## LaboInfra Bastion
export BASTION_USER="clem"
export BASTION_HOST="ovh-bastion.core.laboinfra.net"
export BASTION_PORT=22
alias laboinfra-bastion='ssh clem@ovh-bastion.core.laboinfra.net -i ~/.ssh/labo-infra-bastion -t -- '
alias laboinfra-bastionm='mosh --ssh="ssh -t" clem@ovh-bastion.core.laboinfra.net -- '
