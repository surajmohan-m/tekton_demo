## Overview of Tekton Usecase

![Test Image 3](tekton_demo_overview.png)

## Webapp Application

### Webapp Git Repo

The Webapp git repo contains a simple ***html file*** and a ***Dockerfile*** to copy the html file to the nginx image.

### Webapp Deployment and Service
* Git Repo : [webapp.git](https://github.com/surajmohan-m/webapp.git)
* **Deployment**
  * Name : webapp-deployment
  * image : [webapp-tekton](https://hub.docker.com/r/surajmohanm/webapp-tekton/tags)
  * Port : 80
* **Service**
  * kubectl expose deployment/webapp-deployment --type="NodePort" --port 80

## CI/CD for the Webapp using Tekton

### Setup using Install script
A simple installation script is available in this repo which installs all the required resources required for Tekton pipelines in the K8S Cluster.
```
git clone https://github.com/surajmohan-m/tekton_demo.git
cd tekton_demo
chmod 755 setup.sh
./setup.sh
```
### Details of the installation
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

#### Update the webhook in Git repo


##### Webapp CI/CD Pipeline Architecture

![](assets/tekton_demo_pipeline_structure_4.png)


* **Pipelinerun** - clone_build_push-*

  * **Pipeline** - clone_build_push
    * **Taskrun** - fetch-source
      * **Task** - [git-clone](https://hub.tekton.dev/tekton/task/git-clone)
    * **Taskrun** - build-push
      * **Task** - [kaniko](https://hub.tekton.dev/tekton/task/kaniko)


## Reusing the pipeline

### Update the Yaml files
* Modify  **image** in **webapp/deployment_webapp.yml**
  ```
   containers:
      - name: nginx
        image: docker.io/surajmohanm/webapp-tekton:latest
  ```
* Modify **image-reference** in **Triggers/trigger_template.yml**
   ```
   name: image-reference
          value: surajmohanm/webapp-tekton
   ```
  
