#!/bin/bash
set -e

echo "\U0001F4E5 Downloading and applying ARC CRDs from GitHub..."
curl -L https://raw.githubusercontent.com/actions/actions-runner-controller/v0.27.1/config/crd/bases/actions.summerwind.dev_runnersets.yaml | kubectl apply -f -

echo "\u23F3 Waiting for RunnerSet CRD to become available..."
until kubectl get crd runnersets.actions.summerwind.dev &>/dev/null; do
  echo "\u231B Still waiting for CRD..."
  sleep 2
done

echo "\u2705 CRD is ready. Deploying runner manifest..."
kubectl apply -f ~/runner-deployment.yaml

echo "\u2705 RunnerSet successfully deployed!"
