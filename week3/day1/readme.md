Week 3 – Flask App Deployment with ALB + ASG
What I Built

In this project, I deployed a Flask application in a production-style setup using:

Application Load Balancer

Auto Scaling Group

Target Group

Route 53 (custom domain)

ACM SSL certificate

Multi-AZ architecture

The goal was to understand how real-world applications are deployed in AWS instead of just running EC2 manually.

Architecture Overview

User → Domain (komal.world) → Route 53 → ALB → Target Group → Auto Scaling Group → EC2 → Flask App

Infrastructure Details

Region: us-east-1
Instance Type: t2.micro
OS: Amazon Linux 2023
App Port: 8000

Load Balancer

Internet-facing ALB

Listener 80 (HTTP)

Listener 443 (HTTPS with ACM certificate)

Forwarding to Target Group on port 8000

Target Group

Protocol: HTTP

Port: 8000

Health check path: /

Auto Scaling Group

Min: 2

Desired: 2

Max: 3

Multi-AZ enabled

ELB health checks enabled

SSL Setup

Requested certificate using AWS ACM

Used DNS validation

Added CNAME records automatically in Route 53

Attached certificate to ALB HTTPS listener

What I Learned

Why ALB should listen on 80/443 instead of 8000

How health checks work

How ASG replaces unhealthy instances

How DNS propagation works

Difference between public and private subnets

How to reduce cost by setting ASG desired to 0

Cost Optimization

When not testing:

Set ASG desired capacity to 0

Delete ALB if not needed

ACM certificate is free

Route 53 hosted zone has small monthly cost