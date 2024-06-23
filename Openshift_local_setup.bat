rem Install tekton
oc apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

rem Install triggers
oc apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
oc apply -f https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml

rem install dashboard
oc apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml
rem oc --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097 --address 0.0.0.0 &

rem Install tkn CLI
rem curl -LO https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.deb
rem dpkg -i tektoncd-cli-0.36.0_Linux-64bit.deb

rem Or

rem rpm -i  https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.rpm

rem Install git clone from hub
oc apply -f  Tasks/git-clone.yml

rem Install kaniko from hub
oc apply -f  Tasks/kaniko.yml


rem create docker credentials
oc apply -f auth/docker-credentials.yml

rem create pipeline
oc apply -f Pipeline/pipeline_clone-build-push.yml

rem create pipelinerun
rem oc create -f Pipelinerun/pipelinerun-clone-build-push.yml

rem Create tekton webhook token
oc apply -f auth/webhook_secret.yml

rem Create trigger template
oc apply -f Triggers/trigger_template.yml

rem Create trigger binding
oc apply -f Triggers/trigger_binding.yml

rem Create trigger
rem oc apply -f trigger.yml

rem Create service account with required trigger roles
oc apply -f auth/rbac.yml

rem Create event listner
oc apply -f Triggers/event_listner.yml

rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem 
rem rem  Create deployment and service
rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem rem 


rem create deployment of webapp
oc apply -f webapp/deployment_webapp.yml

rem rollout new image
oc rollout  restart deployment webapp-deployment

rem k8s webapp service
oc expose deployment/webapp-deployment --type="NodePort" --port 80

