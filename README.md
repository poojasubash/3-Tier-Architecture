Overview

This project demonstrates a highly available 3-tier AWS architecture using:
         -Web Tier
         -Application Tier
         -Database Tier
with Load Balancers, Auto Scaling, Route 53, ACM, and RDS.
1. Create a VPC

2. Create 6 Subnets
   - 2 Public Subnets -> Web Server
   - 2 Private Subnets -> App Server
   - 2 Private Subnets -> Database

3. Create Route Tables
   - Public Route Table -> Internet Gateway -> Web Subnets
   - Private Route Tables (HA) -> NAT Gateway (per AZ) -> App Subnets
   - Database Route Table -> No Internet (Optional NAT for patching)

4. Create 5 Security Groups
   - Frontend-ALB-SG -> HTTP/HTTPS from Internet
   - WebServer-SG -> HTTP from Frontend-ALB-SG, SSH from Admin IP
   - Backend-ALB-SG (Internal) -> Port 5000 from WebServer-SG
   - AppServer-SG -> Port 5000 from Backend-ALB-SG, SSH from WebServer-SG
   - DB-SG -> MySQL 3306 from AppServer-SG

5. Create Route 53 Hosted Zone
   - Create Hosted Zone
   - Update Name Servers in Domain Provider

6. Validate ACM using Route 53
   - Request SSL Certificate
   - Validate using DNS (CNAME record)

7. Create RDS
   - Create DB Subnet Group (2 DB Subnets)
   - Launch MySQL RDS in Private Subnet

8. Launch EC2 Instances
   - Web Server -> Public Subnet -> WebServer-SG
   - App Server -> Private Subnet -> AppServer-SG

9. Login to App Server
   chmod 400 pooja.pem
   ssh -i pooja.pem ec2-user@<private-ip>

10. Setup Database
   sudo yum install mysql -y
   mysql -h <rds-endpoint> -P 3306 -u admin -p
   Run commands.sql to create DB, tables, and insert data

11. Setup App Server
   sudo yum install python3 python3-pip -y
   pip3 install flask flask-mysql-connector flask-cors
   vi app.py
   nohup python3 app.py > output.log 2>&1 &
   ps -ef | grep app.py
   curl http://<backend-alb-dns>:5000/login

12. Setup Web Server
   sudo yum install httpd -y
   sudo service httpd start
   cd /var/www/html/
   touch index.html script.js 

13. Create Load Balancers
   - Backend ALB (Internal) -> App Server -> Port 5000 -> /login
   - Frontend ALB (Public) -> Web Server -> Port 80 -> /

14. Configure Route 53
   - Create A-Record
   - Alias to Frontend ALB

15. Attach ACM Certificate
   - Enable HTTPS on Frontend ALB

16. Enable Auto Scaling
   - Auto Scaling Group for Web Server
   - Auto Scaling Group for App Server
