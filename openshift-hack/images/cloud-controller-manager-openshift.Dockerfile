FROM registry.ci.openshift.org/ocp/builder:rhel-8-golang-1.19-openshift-4.14 AS builder
WORKDIR /go/src/github.com/openshift/cloud-provider-vsphere
COPY . .

RUN make binaries

FROM registry.ci.openshift.org/ocp/4.14:base
COPY --from=builder /go/src/github.com/openshift/cloud-provider-vsphere/.build/vsphere-cloud-controller-manager /bin/vsphere-cloud-controller-manager

LABEL description="vSphere Cloud Controller Manager"

ENTRYPOINT ["/bin/vsphere-cloud-controller-manager"]
