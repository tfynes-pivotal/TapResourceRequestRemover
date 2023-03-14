# TAP Resource Request Remover

TAP Overlay set to remove all TAP constituent package K8s deployment resource requests.

TAP comes with predefined CPU and Memory resource requests/reservations, set for production workload QoS. This can be overkill for functional demo environments.

Removing all TAP component k8s deployment cpu/memory requests reduces demands on cluster by as much as 50% in preliminary testing.


### How it works

reqfix.sh creates a k8s secret (reqfix-secret) that will be made availble to the tap package as an overlay definition via addition of an annotation to its packageInstall.

Given how tap is a 'meta' package, this secret embeds another secret (reqfix-overlay-secret) that will be made available to all other tap PackageInstalls

The reqfix-secret also includes an overlay to update all other tap PackageInstalls to load the reqfix-overlay-secret and use that to remove all "resources" sections of container specs in their constituent k8s deployments

There's a caveat in that TAP15 includes an overlay that adds versioning to secrets - so there is also an overlay defined to remove this overlay annotation key from our tap-overlay-secret 

yaml file containing the reqfix-overlay-secret, the overlay to update tap constuent packageInstalls and the fix for secrets versioning all in reqfix.yaml
