resource null_resource delete-cos-contents {

provisioner "local-exec" {
    
    command = "./deleteCOS.sh ${var.bucket-name} ${var.COS-S3-ENDPOINT} ${var.ACCESS-KEY} ${var.SECRET-KEY}" 
     interpreter = ["/bin/sh", "-c"]
  }
}

