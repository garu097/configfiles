#!/bin/bash

POD=$(kubectl get pods | grep "$1" | awk '{print $1}')
kubectl exec -it "$POD" -- $2