#Install tekton
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

#Install tkn CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.deb
dpkg -i tektoncd-cli-0.36.0_Linux-64bit.deb

#Or

#rpm -i  https://github.com/tektoncd/cli/releases/download/v0.36.0/tektoncd-cli-0.36.0_Linux-64bit.rpm

#Install git clone from hub
kubectl apply -f  git-clone.yaml

#Install kaniko from hub

kubectl apply -f  kaniko.yaml
