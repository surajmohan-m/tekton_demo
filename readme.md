# Overview of Tekton Usecase

![Test Image 3](tekton_demo_overview.png)

### Webapp Git Repo

The Webapp git repo contains a simple html file and a Dockerfile to copy the html file to the nginx image. It is available [here](https://github.com/surajmohan-m/webapp.git)

### Tekton - Build and push Pipeline

![Test Image 4](tekton_demo_pipeline_structure.png)

* **Pipeline ** - clone_build_push
* * **tasks**
    * fetch-source

      * reference task - [git-clone](https://hub.tekton.dev/tekton/task/git-clone)

        asdfasdf
    * build-push

      * reference task - [kaniko](https://hub.tekton.dev/tekton/task/kaniko)
