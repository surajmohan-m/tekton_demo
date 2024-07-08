# Overview of Tekton Usecase

![Test Image 3](tekton_demo_overview.png)

## Webapp Application

### Webapp Git Repo

The Webapp git repo contains a simple ***html file*** and a ***Dockerfile*** to copy the html file to the nginx image. It is available [here](https://github.com/surajmohan-m/webapp.git)

### Webapp Deployment and Service

* **Deployment**

  * Name : webapp-deployment
  * image : [webapp-tekton](https://hub.docker.com/repository/docker/surajmohanm/webapp-tekton/generalhttps:/)
  * Port : 80
* Service

  * kubectl expose deployment/webapp-deployment --type="NodePort" --port 80

## Tekton - Build and push Pipeline

![](assets/20240627_002021_tekton_demo_pipeline_structure_4.png)


* **Pipelinerun** - clone_build_push-*

  * **Pipeline** - clone_build_push
    * **Taskrun** - fetch-source
      * **Task** - [git-clone](https://hub.tekton.dev/tekton/task/git-clone)
    * **Taskrun** - build-push
      * **Task** - [kaniko](https://hub.tekton.dev/tekton/task/kaniko)
