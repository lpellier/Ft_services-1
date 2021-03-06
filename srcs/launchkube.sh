#! /bin/bash

eval $(minikube docker-env)

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

kubectl create secret generic minikube-ip --from-literal=ip="$(minikube ip)"

WORKDIR='./'
IMAGES=(
    metallb
    phpmyadmin
    mysql
    nginx
    wordpress
    ftps
    influxdb
    grafana
)

for image in ${IMAGES[*]}
do 
	kubectl apply -k ./${image}; 
	if [[ $? != 0 ]]
	then
		echo "Error"
		exit 1
	fi
done