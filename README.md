# TAP Resource Request Remover

![image](https://user-images.githubusercontent.com/6810491/225349273-2b7edb69-87bf-4d26-949b-44529d003996.png)


TAP Overlay set to remove all TAP constituent package K8s deployment resource requests.

TAP comes with predefined CPU and Memory resource requests/reservations, set for production workload QoS. This can be overkill for functional demo environments.

Removing all TAP component k8s deployment cpu/memory requests reduces demands on cluster by as much as 50% in preliminary testing.


### How it works

reqfix.sh creates a k8s secret (reqfix-secret) that will be made availble to the tap package as an overlay definition via addition of an annotation to its packageInstall.

Given how tap is a 'meta' package, this secret embeds another secret (reqfix-overlay-secret) that will be made available to all other tap PackageInstalls

The reqfix-secret also includes an overlay to update all other tap PackageInstalls to load the reqfix-overlay-secret and use that to remove all "resources" sections of container specs in their constituent k8s deployments

There's a caveat in that TAP15 includes an overlay that adds versioning to secrets - so there is also an overlay defined to remove this overlay annotation key from our tap-overlay-secret 

yaml file containing the reqfix-overlay-secret, the overlay to update tap constuent packageInstalls and the fix for secrets versioning all in reqfix.yaml



TAP Update - tap values yaml now support specification of the
overlay yaml at a per-package level. Example below directly applies the overlay to the constituent packages in a full-profile TAP deployment

`package_overlays:
- name: api-portal
secrets:
- name: api-portal-cm-tls-overlay-secret
- name: accelerator
secrets:
- name: reqfix-overlay-secret
- name: api-auto-registration
secrets:
- name: reqfix-overlay-secret
- name: appliveview
secrets:
- name: reqfix-overlay-secret
- name: appliveview-apiserver
secrets:
- name: reqfix-overlay-secret
- name: appliveview-connector
secrets:
- name: reqfix-overlay-secret
- name: appliveview-conventions
secrets:
- name: reqfix-overlay-secret
- name: appsso
secrets:
- name: reqfix-overlay-secret
- name: bitnami-services
secrets:
- name: reqfix-overlay-secret
- name: buildservice
secrets:
- name: reqfix-overlay-secret
- name: cartographer
secrets:
- name: reqfix-overlay-secret
- name: cert-manager
secrets:
- name: reqfix-overlay-secret
- name: cnrs
secrets:
- name: reqfix-overlay-secret
- name: contour
secrets:
- name: reqfix-overlay-secret
- name: crossplane
secrets:
- name: reqfix-overlay-secret
- name: developer-conventions
secrets:
- name: reqfix-overlay-secret
- name: fluxcd-source-controller
secrets:
- name: reqfix-overlay-secret
- name: grype
secrets:
- name: reqfix-overlay-secret
- name: metadata-store
secrets:
- name: reqfix-overlay-secret
- name: namespace-provisioner
secrets:
- name: reqfix-overlay-secret
- name: ootb-templates
secrets:
- name: reqfix-overlay-secret
- name: policy-controller
secrets:
- name: reqfix-overlay-secret
- name: scanning
secrets:
- name: reqfix-overlay-secret
- name: service-bindings
secrets:
- name: reqfix-overlay-secret
- name: services-toolkit
secrets:
- name: reqfix-overlay-secret
- name: source-controller
secrets:
- name: reqfix-overlay-secret
- name: spring-boot-conventions
secrets:
- name: reqfix-overlay-secret
- name: tap-auth
secrets:
- name: reqfix-overlay-secret
- name: tap-gui
secrets:
- name: reqfix-overlay-secret
- name: tap-telemetry
secrets:
- name: reqfix-overlay-secret
- name: tekton-pipelines
secrets:
- name: reqfix-overlay-secret`
