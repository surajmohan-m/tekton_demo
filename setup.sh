#Install tekton
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

#Install tkn CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.deb
dpkg -i tektoncd-cli-0.36.0_Linux-64bit.deb

#Or

#rpm -i  https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.rpm

#setup local reg
docker run -d -p 5000:5000 --name registry registry:2.7

#Install git clone from hub
kubectl apply -f  git-clone.yml

#Install kaniko from hub
kubectl apply -f  kaniko.yml

#install task source list
#kubectl apply -f task_source_list.yml

#install pipeline
#kubectl apply -f pipeline.yml

#create pipeline run
#kubectl create -f pipeline_Run.yml

#create docker credentials
kubectl apply -f docker-credentials.yml

#create pipeline
kubectl apply -f pipeline_clone-build-push.yml

#create pipelinerun
#kubectl create -f pipelinerun-clone-build-push.yml

#Create tekton webhook token
kubectl apply -f webhook_secret.yml

#Create trigger template
kubectl apply -f trigger_template.yml

#Create trigger binding
kubectl apply -f trigger_binding.yml

#Create trigger
kubectl apply -f trigger.yml

#Create service account with required trigger roles
kubectl apply -f rbac.yml

#Create event listner
kubectl apply -f event_listner.yml

#Create event listner ingress
kubectl apply -f trigger_ingress.yml
################################
## Create deployment and service
################################


#create deployment of webapp
kubectl apply -f deployment_webapp.yml

#rollout new image
kubectl rollout  restart deployment webapp-deployment

#k8s webapp service
kubectl expose deployment/webapp-deployment --type="NodePort" --port 80

