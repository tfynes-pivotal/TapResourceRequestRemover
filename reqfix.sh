kubectl -n tap-install delete secret reqfix-overlay-secret reqfix-secret
kubectl create secret generic -n tap-install reqfix-secret --from-file=./reqfix.yaml
kubectl patch -n tap-install --type merge pkgi tap --patch '{"metadata":{"annotations":{"ext.packaging.carvel.dev/ytt-paths-from-secret-name.1": "reqfix-secret"}}}'
