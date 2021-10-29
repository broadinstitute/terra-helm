##!/usr/bin/env bash

#Creating crd's prometheus-operator has known issues creating automatically
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.37/example/prometheus-operator-crd/monitoring.coreos.com_alertmanagers.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.37/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.37/example/prometheus-operator-crd/monitoring.coreos.com_prometheuses.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.37/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.37/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/release-0.37/example/prometheus-operator-crd/monitoring.coreos.com_thanosrulers.yaml

# Ensures user has chart added to local helm repos 
helm repo add https://broadinstitute.github.io/terra-helm
helm repo update

helm install prometheus-stackdriver terra-helm/terra-ap-prometheus-operator -n monitoring --version=0.0.1 -f monitoring-configs.yaml --debug