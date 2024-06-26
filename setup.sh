########################################################################################################################
#####
#####  Installion of Webapp
#####
########################################################################################################################

#create deployment of webapp
kubectl apply -f webapp/deployment_webapp.yml

#rollout new image
#kubectl rollout  restart deployment webapp-deployment

#k8s webapp service
kubectl expose deployment/webapp-deployment --type="NodePort" --port 80

########################################################################################################################
#####
#####  Installion of tekton and other components 
#####
########################################################################################################################
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

#Install triggers
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

#install dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097 --address 0.0.0.0 &

#Install tkn CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.deb
dpkg -i tektoncd-cli-0.36.0_Linux-64bit.deb

#Or

#rpm -i  https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.rpm

########################################################################################################################
#####
#####  Tekton tasks, pipeline and pipelinerun
#####
########################################################################################################################
#Install git clone from hub
kubectl apply -f  Tasks/git-clone.yml

#Install kaniko from hub
kubectl apply -f  Tasks/kaniko.yml


#create docker credentials
kubectl apply -f auth/docker-credentials.yml

#create pipeline
kubectl apply -f Pipeline/pipeline_clone-build-push.yml

#create pipelinerun
#kubectl create -f Pipelinerun/pipelinerun-clone-build-push.yml


########################################################################################################################
#####
##### Tekton triggers
#####
########################################################################################################################
#Create tekton webhook token
kubectl apply -f auth/webhook_secret.yml

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




