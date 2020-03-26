# terraform-templates-aws-ec2

**To log into your ec2 instance:** 
* ````$ chmod 400 *.pem````   
* ````$ ssh -i ./terraform-templates-aws-ec2.pem ec2-user@x.x.x.x````


## Pro tip

* Delete your resources at the end of your work sessions to avoid AWS costs
* ````Queueing a destroy plan will be disabled until there is an environment variable set named CONFIRM_DESTROY with a value of 1. You can use the variables page to set it.````