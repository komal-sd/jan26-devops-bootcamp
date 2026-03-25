# DevOps Bootcamp — Komal

A hands-on DevOps learning journey covering Linux, Docker, AWS, Terraform, and CI/CD.
Each week builds on the last, moving from manual operations toward full infrastructure automation.

---

## Projects

| Week | Topic | Key Skills |
|------|-------|------------|
| [Week 01](./week-01/) | Linux & Bash Scripting | Shell scripts, log analysis, system monitoring |
| [Week 03](./week3/) | AWS Manual Deployment | EC2, ALB, ASG, Route53, ACM, HTTPS |
| [Week 05](./week5/) | Docker & Containerization | Dockerfile, docker-compose, PostgreSQL |
| [Week 06](./week-06/) | Terraform Infrastructure | ECS Fargate, RDS, VPC, IAM, Secrets Manager |
| [Week 07](./week-07/) | CI/CD with GitHub Actions | Automated build, push to ECR, deploy to ECS |

---

## Week 03 — Production Flask App on AWS (Manual)

Deployed a Flask application in a production-style AWS architecture.

**Architecture:**
```
User → Route53 (komal.world) → ALB (HTTPS) → Target Group → ASG (2-3 x EC2) → Flask App
```

**Key components:**
- Application Load Balancer with HTTP → HTTPS redirect
- Auto Scaling Group: min 2, desired 2, max 3 instances
- ACM certificate with DNS validation via Route53
- Multi-AZ deployment across us-east-1a and us-east-1b

---

## Week 05 — Dockerized Student Portal

A Flask + PostgreSQL student management app, containerized and run locally with docker-compose.

```bash
cd week5/student-app
cp .env.example .env      # fill in your values
docker-compose up --build
```

App runs at `http://localhost:5000`

---

## Week 06 — Terraform ECS Infrastructure

Full AWS infrastructure defined as code. Deploys the student portal to ECS Fargate with a managed RDS database.

**Architecture:**
```
Internet → ALB (HTTPS) → ECS Fargate (private subnets) → RDS PostgreSQL (isolated subnets)
```

**Resources provisioned:**
- VPC with public, private (ECS), and private (RDS) subnet tiers
- NAT Gateway for outbound traffic from private subnets
- ECS Cluster + Fargate Task Definition + Service (desired count: 2)
- RDS PostgreSQL in isolated subnets
- Secrets Manager for database credentials
- ACM certificate + Route53 DNS
- CloudWatch log group (7-day retention)
- Auto Scaling for ECS service

```bash
cd week-06/terraform-ecs
terraform init
terraform plan
terraform apply
```

---

## Week 07 — GitHub Actions CI/CD Pipeline

Automated pipeline that triggers on every push to `main`:
1. Build Docker image
2. Push to Amazon ECR
3. Deploy to ECS (rolling update)

See [week-07/README.md](./week-07/README.md) for setup instructions.

---

## Tech Stack

**Cloud:** AWS (EC2, ECS Fargate, RDS, ALB, ECR, ACM, Route53, Secrets Manager, IAM, CloudWatch)

**IaC:** Terraform

**Containers:** Docker, docker-compose

**CI/CD:** GitHub Actions

**App:** Python, Flask, PostgreSQL, Gunicorn

**Scripting:** Bash
