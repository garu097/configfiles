#!/bin/bash

POD=$(kubectl get pods | grep "$1" | awk '{print $1}')
kubectl logs -f "$POD" | grep "$2"