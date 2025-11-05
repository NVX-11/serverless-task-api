# Serverless Task Manager API

Serverless REST API with AWS Lambda, DynamoDB, and API Gateway deployed using Terraform.

## Tech Stack

- AWS Lambda (Python 3.11)
- DynamoDB
- API Gateway
- Terraform
- CloudWatch

## Deployment

```bash
terraform init
terraform apply
terraform output api_gateway_url
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/tasks` | Create task |
| GET | `/tasks` | List tasks |
| GET | `/tasks/{id}` | Get task |
| PUT | `/tasks/{id}` | Update task |
| DELETE | `/tasks/{id}` | Delete task |

## Cleanup

```bash
terraform destroy
```

## Author

[NVX-11](https://github.com/NVX-11)
