# AWS

1. Deploy a Kubernets cluster via rancher\aws
2. Install Concourse into the above cluster via Helm

```
helm install -f values.yaml concourse/concourse
```