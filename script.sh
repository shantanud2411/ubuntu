cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

    sudo modprobe overlay
    sudo modprobe br_netfilter
    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

    sudo sysctl --system
    sudo apt install curl -y
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh 
    sudo sed -i 's/disabled/enable/' /etc/containerd/config.toml
    sudo sed -i 's/cri/containerd/' /etc/containerd/config.toml
   sudo systemctl restart docker
   sudo systemctl enable docker
   sudo systemctl restart containerd
   sudo systemctl enable containerd
   sudo apt-get update
   sudo apt-get install -y apt-transport-https ca-certificates curl
   sudo curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
   echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   sudo apt-get update
   sudo apt-get install -y kubelet kubeadm kubectl
   sudo systemctl enable kubelet
