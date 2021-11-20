# Note: this script generate one worker key for all workers.
# In real world scenarios, it is recommended to generate one key per worker.

DSTDIR="$(realpath "./deployment/concourse/keys")"

function concourse() {
    docker run --rm -t -v "${DSTDIR}:/mnt/host" concourse/concourse "$@"
}

mkdir -p -- "${DSTDIR}/web" "${DSTDIR}/worker"
concourse generate-key -t rsa -f "/mnt/host/web/session_signing_key"
concourse generate-key -t ssh -f "/mnt/host/web/tsa_host_key"
concourse generate-key -t ssh -f "/mnt/host/worker/worker_key"

cp -- "${DSTDIR}/web/tsa_host_key.pub" "${DSTDIR}/worker/"
cat -- "${DSTDIR}/worker/worker_key.pub" >> "${DSTDIR}/web/authorized_worker_keys"
