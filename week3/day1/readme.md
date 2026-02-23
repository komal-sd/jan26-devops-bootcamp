🚀 Week 3 – Production-Style Flask Deployment on AWS
📌 Project Overview

In this project, I deployed a Flask application in a production-style AWS architecture instead of running a single EC2 instance manually.

The setup includes:

Application Load Balancer (ALB)

Auto Scaling Group (ASG)

Target Group

Route 53 custom domain

ACM SSL/TLS certificate

Multi-AZ high availability

The goal was to simulate a real-world cloud deployment with scalability, availability, and HTTPS security.

🏗 Architecture Flow
User
   ↓
komal.world (Route 53 DNS)
   ↓
Application Load Balancer (HTTP → HTTPS)
   ↓
Target Group (Port 8000)
   ↓
Auto Scaling Group (Min 2, Max 3)
   ↓
EC2 Instances (t2.micro, Multi-AZ)
   ↓
Flask Application
🌍 Infrastructure Details
Component	Configuration
Region	us-east-1
Instance Type	t2.micro
OS	Amazon Linux 2023
Application Port	8000
Availability	Multi-AZ
⚖️ Load Balancer Configuration

Internet-facing Application Load Balancer

Listener 80 (HTTP)

Listener 443 (HTTPS with ACM certificate)

HTTPS forwards traffic to Target Group on port 8000

Health checks enabled on /

🎯 Target Group

Protocol: HTTP

Port: 8000

Health Check Path: /

Integrated with Auto Scaling Group

📈 Auto Scaling Configuration

Minimum capacity: 2

Desired capacity: 2

Maximum capacity: 3

Multi-AZ distribution enabled

ELB health checks enabled

Automatic instance replacement on failure

🔐 SSL/TLS Setup

Certificate requested using AWS Certificate Manager (ACM)

DNS validation method used

CNAME validation records created in Route 53

Certificate attached to ALB HTTPS listener

Application accessible via:

https://komal.world