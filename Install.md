### Installation steps
Now we will analyze intallation steps and the custom resources (CRD) involved in Tekton pipeline
#### Install deployment and service for the Webapp

```
#create deployment of webapp
kubectl apply -f webapp/deployment_webapp.yml

#k8s webapp service
kubectl expose deployment/webapp-deployment --type="NodePort" --port 80
```

#### Install Tekton and its addons
```
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

#Install triggers
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

#install dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

#Install tkn CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.deb
dpkg -i tektoncd-cli-0.36.0_Linux-64bit.deb
```
#### Install Tasks, Pipeline and docker credentials 

```
#Install git clone from hub
kubectl apply -f  Tasks/git-clone.yml

#Install kaniko from hub
kubectl apply -f  Tasks/kaniko.yml


#create docker credentials required for pushing the images to registry
kubectl apply -f auth/docker-credentials.yml

#create pipeline
kubectl apply -f Pipeline/pipeline_clone-build-push.yml
```

#### Install Tekton Triggers
```
#Create trigger template
kubectl apply -f Triggers/trigger_template.yml

#Create trigger binding
kubectl apply -f Triggers/trigger_binding.yml

#Create trigger
#kubectl apply -f trigger.yml

#Create service account with required trigger roles
kubectl apply -f auth/rbac.yml

#Create event listner
kubectl apply -f Triggers/event_listner.yml
```
