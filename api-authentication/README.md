### List pods via kubernetes API using service account
- Authenticate with SA Token

```bash
# Generate service account 
k create sa robot -n default -oyaml --dry-run=client > robot-sa.yaml

# Generate Role 
k create role list-pods-role --verb=list --resource=pods --namespace=default --dry-run=client -oyaml > list-pods-role.yaml

# Generate RoleBinding 
k create rolebinding list-pods-role-binding --role=list-pods-role --serviceaccount=default:robot -n default --dry-run=client -oyaml > list-pods-role-binding.yaml 

# Generate Deployment where the container will make an api call every 10 seconds to list the pods in default namespace 
k create deployment get-pods-deployment --image=curlimages/curl --dry-run=client -ojson -- sh -c 'while true; do curl -s --header "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt https://kubernetes/api/v1/namespaces/default/pods; sleep 10; done;' | jq '.spec.template.spec +={"serviceAccountName": "robot"'} > get-pods-deployment.json

# Check whether robot sa is allowed to list pods
k auth can-i list pods --as=system:serviceaccount:default:robot -n default
```