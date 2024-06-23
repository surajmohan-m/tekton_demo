# Tekton Installation and Configuration

Welcome to the Tekton Installation and Configuration guide! This document provides step-by-step instructions for installing and configuring Tekton on your Kubernetes cluster.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- Access to a Kubernetes cluster.
- `kubectl` command-line tool configured to communicate with your cluster.

## Installation

To install Tekton on your Kubernetes cluster, follow these steps:

1. **Install Tekton Pipelines**:
   
   Apply the Tekton Pipelines YAML manifests to your cluster:

   ```bash
   kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
## Overview of Tekton Usecase

![Test Image 3](tekton_demo_overview.png)

## Tekton Pipeline Architecture

![Test Image 4](tekton_demo_pipeline_structure.png)

