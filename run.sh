#!/bin/bash
# RESET=1 - reset output file
# VERBOSE=1 - pass verbose mode to count_kw.sh script
# SRC_BASE=/path/to/sources/folder (defaults to ~/devstats_repos)
# ONLY='Kubernetes,Prometheus' - specify subset of projects to run
# ONLY='Kubernetes,Linux kernel,Node.js,Helm,gRPC,Prometheus,Jenkins,Zephyr,Envoy,Fluentd,GraphQL,OpenTelemetry,Jenkins X,KubeVirt,Jaeger,Tekton,Spinnaker,TiKV,NATS,Flux,Rook,Thanos,etcd,OpenEBS,containerd,Linkerd,Vitess,CoreDNS,OPA,Harbor,KubeEdge,Falco,CRI-O,CloudEvents,Strimzi,Cortex,OCI,Network Service Mesh,CNI,Dragonfly,Buildpacks,CDF,OpenTracing,Virtual Kubelet,Spiffe,Spire,ChubaoFS,TUF,Telepresence,in-toto,Notary,rkt,OpenMetrics,CNCF,Knative,Istio,CloudFoundry'
# FN=resultfile.csv (default: result.csv"
wd=`pwd`
if [ -z "${FN}" ]
then
  fn="${wd}/result.csv"
else
  fn="${wd}/${FN}"
fi
if [ ! -z "${RESET}" ]
then
  echo 'master,slave,whitelist,blacklist' > "${fn}"
fi
if [ -z "${SRC_BASE}" ]
then
  cd ~/devstats_repos/
else
  cd "${SRC_BASE}" || exit 1
fi
declare -A kws
kws[${#kws[@]}]='master'
kws[${#kws[@]}]='slave'
kws[${#kws[@]}]='white-?list'
kws[${#kws[@]}]='black-?list'
declare -A projs
projs[${#projs[@]}]='Kubernetes'
projs[${#projs[@]}]='Linux kernel'
projs[${#projs[@]}]='Node.js'
projs[${#projs[@]}]='Helm'
projs[${#projs[@]}]='gRPC'
projs[${#projs[@]}]='Prometheus'
projs[${#projs[@]}]='Jenkins'
projs[${#projs[@]}]='Zephyr'
projs[${#projs[@]}]='Envoy'
projs[${#projs[@]}]='Fluentd'
projs[${#projs[@]}]='GraphQL'
projs[${#projs[@]}]='OpenTelemetry'
projs[${#projs[@]}]='Jenkins X'
projs[${#projs[@]}]='KubeVirt'
projs[${#projs[@]}]='Jaeger'
projs[${#projs[@]}]='Tekton'
projs[${#projs[@]}]='Spinnaker'
projs[${#projs[@]}]='TiKV'
projs[${#projs[@]}]='NATS'
projs[${#projs[@]}]='Flux'
projs[${#projs[@]}]='Rook'
projs[${#projs[@]}]='Thanos'
projs[${#projs[@]}]='etcd'
projs[${#projs[@]}]='OpenEBS'
projs[${#projs[@]}]='containerd'
projs[${#projs[@]}]='Linkerd'
projs[${#projs[@]}]='Vitess'
projs[${#projs[@]}]='CoreDNS'
projs[${#projs[@]}]='OPA'
projs[${#projs[@]}]='Harbor'
projs[${#projs[@]}]='KubeEdge'
projs[${#projs[@]}]='Falco'
projs[${#projs[@]}]='CRI-O'
projs[${#projs[@]}]='CloudEvents'
projs[${#projs[@]}]='Strimzi'
projs[${#projs[@]}]='Cortex'
projs[${#projs[@]}]='OCI'
projs[${#projs[@]}]='Network Service Mesh'
projs[${#projs[@]}]='CNI'
projs[${#projs[@]}]='Dragonfly'
projs[${#projs[@]}]='Buildpacks'
projs[${#projs[@]}]='CDF'
projs[${#projs[@]}]='OpenTracing'
projs[${#projs[@]}]='Virtual Kubelet'
projs[${#projs[@]}]='Spiffe'
projs[${#projs[@]}]='Spire'
projs[${#projs[@]}]='ChubaoFS'
projs[${#projs[@]}]='TUF'
projs[${#projs[@]}]='Telepresence'
projs[${#projs[@]}]='in-toto'
projs[${#projs[@]}]='Notary'
projs[${#projs[@]}]='rkt'
projs[${#projs[@]}]='OpenMetrics'
projs[${#projs[@]}]='CNCF'
projs[${#projs[@]}]='Knative'
projs[${#projs[@]}]='Istio'
projs[${#projs[@]}]='CloudFoundry'
declare -A sources
sources[${#sources[@]}]='kubernetes kubernetes-client kubernetes-csi kubernetes-incubator kubernetes-security kubernetes-sigs kubernetes-sig-testing'
sources[${#sources[@]}]='torvalds/linux'
sources[${#sources[@]}]='nodejs/node'
sources[${#sources[@]}]='helm'
sources[${#sources[@]}]='grpc'
sources[${#sources[@]}]='prometheus'
sources[${#sources[@]}]='jenkinsci jenkins-infra'
sources[${#sources[@]}]='zephyrproject-rtos'
sources[${#sources[@]}]='envoyproxy'
sources[${#sources[@]}]='fluent'
sources[${#sources[@]}]='graphql'
sources[${#sources[@]}]='open-telemetry'
sources[${#sources[@]}]='jenkins-x jenkins-x-apps jenkins-x-buildpacks jenkins-x-charts jenkins-x-quickstarts'
sources[${#sources[@]}]='kubevirt'
sources[${#sources[@]}]='jaegertracing'
sources[${#sources[@]}]='tektoncd'
sources[${#sources[@]}]='spinnaker'
sources[${#sources[@]}]='tikv'
sources[${#sources[@]}]='nats-io'
sources[${#sources[@]}]='fluxcd'
sources[${#sources[@]}]='rook'
sources[${#sources[@]}]='thanos-io'
sources[${#sources[@]}]='etcd-io'
sources[${#sources[@]}]='openebs'
sources[${#sources[@]}]='containerd'
sources[${#sources[@]}]='linkerd'
sources[${#sources[@]}]='vitessio'
sources[${#sources[@]}]='coredns'
sources[${#sources[@]}]='open-policy-agent'
sources[${#sources[@]}]='goharbor'
sources[${#sources[@]}]='kubeedge'
sources[${#sources[@]}]='falcosecurity'
sources[${#sources[@]}]='cri-o'
sources[${#sources[@]}]='cloudevents'
sources[${#sources[@]}]='strimzi'
sources[${#sources[@]}]='cortexproject'
sources[${#sources[@]}]='opencontainers'
sources[${#sources[@]}]='networkservicemesh'
sources[${#sources[@]}]='containernetworking'
sources[${#sources[@]}]='dragonflyoss'
sources[${#sources[@]}]='buildpacks'
sources[${#sources[@]}]='cdfoundation'
sources[${#sources[@]}]='opentracing'
sources[${#sources[@]}]='virtualkubelet'
sources[${#sources[@]}]='spiffe'
sources[${#sources[@]}]='spiffe/spire'
sources[${#sources[@]}]='chubaofs'
sources[${#sources[@]}]='theupdateframework'
sources[${#sources[@]}]='telepresenceio'
sources[${#sources[@]}]='in-toto'
sources[${#sources[@]}]='theupdateframework/notary'
sources[${#sources[@]}]='rkt'
sources[${#sources[@]}]='OpenObservability'
sources[${#sources[@]}]='cncf crosscloudci cdfoundation'
sources[${#sources[@]}]='knative'
sources[${#sources[@]}]='istio'
sources[${#sources[@]}]='cloudfoundry'
skip_project() {
  if [ -z "${ONLY}" ]
  then
    return 1
  fi
  OIFS=$IFS
  IFS=','
  for only in $ONLY
  do
    if [ "${1}" = "${only}" ]
    then
      IFS=$OIFS
      return 1
    fi
  done
  IFS=$OIFS
  return 0
}
# echo "Projects: ${projs[@]}"
# echo "Sources: ${sources[@]}"
# echo "Keywords: ${kws[@]}"
for i in "${!projs[@]}"
do
  proj="${projs[$i]}"
  if skip_project "${proj}"
  then
    # echo "Skipped ${proj}"
    continue
  fi
  src="${sources[$i]}"
  echo -n "${proj}," >> "${fn}"
  for j in "${!kws[@]}"
  do
    kw="${kws[$j]}"
    echo -n "${proj}(${src}) ${kw}: "
    res=`"${wd}/count_kw.sh" "${src}" '*' "${kw}"`
    echo "${res}"
    echo -n "${res}" >> "${fn}"
    if [ ! "${j}" = "3" ]
    then
      echo -n ',' >> "${fn}"
    fi
  done
  echo '' >> "${fn}"
done
