sudo yum update -y
cd ~
echo "========= Update Completed ========="
sudo yum install wget firewalld -y
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo systemctl status firewalld
wget -q --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.rpm"
sudo yum localinstall jdk-8u202-linux-x64.rpm -y
java -version
echo "========= Oracle Java installed successfully ========="
sleep 10
wget -q --no-cookies -S "http://archive.apache.org/dist/tomcat/tomcat-9/v9.0.16/bin/apache-tomcat-9.0.16.tar.gz"
tar -xf apache-tomcat-9.0.16.tar.gz
mv apache-tomcat-9.0.16/ /opt/tomcat/
echo "export CATALINA_HOME='/opt/tomcat/'" >> ~/.bashrc
source ~/.bashrc
useradd -r tomcat --shell /bin/false
chown -R tomcat:tomcat /opt/tomcat/
cat > /etc/systemd/system/tomcat.service << EOF
[Unit]
Description=Apache Tomcat 9
After=syslog.target network.target

[Service]
User=tomcat
Group=tomcat
Type=forking
Environment=JAVA_HOME=/usr/java/jdk1.8.0_202-amd64/jre
Environment=CATALINA_PID=/opt/tomcat/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install] 
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat
systemctl status tomcat
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

echo "Creating Code Deploy Agent from us-east-1 region in the AMI"
sudo yum install ruby -y
cd /home/centos/
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status

echo "Installing CloudWatch Agent"
wget https://s3.amazonaws.com/amazoncloudwatch-agent/centos/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
systemctl status amazon-cloudwatch-agent
systemctl start amazon-cloudwatch-agent
systemctl status amazon-cloudwatch-agent
