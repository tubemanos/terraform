#!/bin/bash
yum -y update
yum -y install httpd


myip= 'curl http://169.254.169.254/latest/meta-data/local-ipv4'

cat <<EOF > /var/www/html/index.html
<html>
<h2> Build by Alex St and Terraform </h2> <br>
Owner ${first_name} ${last_name} </br>

</html>
EOF

sudo service httpd start
chckconfig httpd on

templatefile("user_data.sh.tpl", {first_name="Test_Name", last_name="Jun",names=["1213","qwere"]})