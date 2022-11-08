Running the application using odo:
0. Install https://operatorhub.io/operator/service-binding-operator
1. Install https://operatorhub.io/operator/cloud-native-postgresql
2. Create Cluster service to run postgres DB.
```sh
cat << EOF | kubectl apply -f -
apiVersion: postgresql.k8s.enterprisedb.io/v1
kind: Cluster
metadata:
  name: cluster-sample
spec:
  instances: 1
  logLevel: info
  primaryUpdateStrategy: unsupervised
  storage:
    size: 1Gi
EOF
```
3. Run `odo add binding` from project directory to bind the application with `Cluster/cluster-sample` service.
```sh
$ odo add binding
? Do you want to list services from: current namespace
? Select service instance you want to bind to: cluster-sample (Cluster.postgresql.k8s.enterprisedb.io)
? Enter the Binding's name: todo-cluster-sample
? How do you want to bind the service? Bind As Environment Variables
? Select naming strategy for binding names: DEFAULT
 ✓  Successfully added the binding to the devfile.
Run `odo dev` to create it on the cluster.
You can automate this command by executing:
  odo add binding --service cluster-sample.Cluster.postgresql.k8s.enterprisedb.io --name todo-cluster-sample --bind-as-files=false
```
4. Run `odo dev`
