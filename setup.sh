#Install tekton
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

#Install tkn CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.deb
dpkg -i tektoncd-cli-0.36.0_Linux-64bit.deb

#Or

#rpm -i  https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.rpm

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

#install pipeline
kubectl apply -f pipeline_clone-build-push.yml

#install pipelinerun
kubectl create -f pipelinerun-clone-build-push.yml

################################
## Create deployment and service
################################


#create deployment of webapp
kubectl apply -f deployment_webapp.yml

#k8s webapp service
kubectl expose deployment/webapp-deployment --type="NodePort" --port 8080

