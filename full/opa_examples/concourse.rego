package concourse

default decision = {"allowed": true}

decision = {"allowed": false, "reasons": reasons} {
  count(deny) > 0
  reasons := deny
}

# do not allow docker-image
# deny["cannot use docker-image types"] {
#   input.action == "UseImage"
#   input.data.image_type == "docker-image"
# }

# do not allow privileged tasks
deny["cannot run privileged tasks"] {
  input.action == "SaveConfig"
  input.data.jobs[_].plan[_].privileged
}

# do not allow priviledge resource types
deny["cannot use privileged resource types"] {
  input.action == "SaveConfig"
  input.data.resource_types[_].privileged
}
