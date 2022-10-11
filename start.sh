
set -e


minikube delete
minikube start

echo "################### Installing Istio #########################"

istioctl install --set profile=demo -y
ISTIO_RELEASE_URL=https://raw.githubusercontent.com/istio/istio/master

echo "################## Install monitoring tools ###################"
kubectl apply -f $ISTIO_RELEASE_URL/samples/addons/jaeger.yaml
kubectl apply -f $ISTIO_RELEASE_URL/samples/addons/prometheus.yaml
kubectl apply -f $ISTIO_RELEASE_URL/samples/addons/grafana.yaml
kubectl apply -f $ISTIO_RELEASE_URL/samples/addons/kiali.yaml


curl $ISTIO_RELEASE_URL/samples/bookinfo/platform/kube/bookinfo.yaml > book-info.yaml

istioctl kube-inject -f book-info.yaml | kubectl apply -f -


