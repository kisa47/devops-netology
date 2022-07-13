locals {
  platform_id_map = {
    stage = "standard-v1"
    prod  = "standard-v2"
  }

  web_count_map = {
    stage = 1
    prod  = 2
  }

  web_vm_map = {
    stage = {
      node_1 = {
        name                    = "node_1"
      }
    }
    prod  = {
      node_1 = {
        name                    = "node_1"
      },
      node_2 = {
        name                    = "node_2"
      }
    }
  }

  memory_map = {
    stage = 1
    prod  = 4
  }
  
  cores_map = {
    stage = 2
    prod  = 4
  }
}