# Overview of Tekton Usecase

![Test Image 3](tekton_demo_overview.png)

## Webapp Application

### Webapp Git Repo

The Webapp git repo contains a simple ***html file*** and a ***Dockerfile*** to copy the html file to the nginx image. It is available [here](https://github.com/surajmohan-m/webapp.git)

### Webapp Deployment and Service

* **Deployment**

  * Name : webapp-deployment
  * image : [webapp-tekton](https://hub.docker.com/r/surajmohanm/webapp-tekton/tags)
  * Port : 80
* Service

  * kubectl expose deployment/webapp-deployment --type="NodePort" --port 80

## CI/CD for the Webapp using Tekton
### Pipeline Architecture

![](assets/tekton_demo_pipeline_structure_4.png)


* **Pipelinerun** - clone_build_push-*

  * **Pipeline** - clone_build_push
    * **Taskrun** - fetch-source
      * **Task** - [git-clone](https://hub.tekton.dev/tekton/task/git-clone)
    * **Taskrun** - build-push
      * **Task** - [kaniko](https://hub.tekton.dev/tekton/task/kaniko)

### Setup
A simple installation script is available in this repo which installs all the required resources required for Tekton pipelines in the K8S Cluster.
```
git clone https://github.com/surajmohan-m/tekton_demo.git
cd tekton_demo
chmod 755 setup.sh
./setup.sh
```

we will analyze the important points of each installation step in detail.

#### Install deployment and service for the Webapp

```
#create deployment of webapp
kubectl apply -f webapp/deployment_webapp.yml

#k8s webapp service
kubectl expose deployment/webapp-deployment --type="NodePort" --port 80
```
