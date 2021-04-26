#!/bin/bash
cat <<EOS | tee /etc/modules-load.d/k8s.conf
br_netfilter
EOS

cat <<EOS | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOS

sysctl --system


curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

cat <<EOS | tee /etc/apt/sources.list.d/kubernetes.list
deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main
EOS

apt update
apt install -u kubelet kubeadm kubectl
