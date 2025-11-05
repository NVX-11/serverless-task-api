import json
import boto3
import os
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table_name = os.environ['TABLE_NAME']
table = dynamodb.Table(table_name)

def lambda_handler(event, context):
    try:
        task_id = event['pathParameters']['id']
        body = json.loads(event['body'])

        update_expression = "SET updated_at = :updated_at"
        expression_values = {':updated_at': datetime.utcnow().isoformat()}
        expression_names = {}

        if 'title' in body:
            update_expression += ", #title = :title"
            expression_values[':title'] = body['title']
            expression_names['#title'] = 'title'

        if 'description' in body:
            update_expression += ", description = :description"
            expression_values[':description'] = body['description']

        if 'completed' in body:
            update_expression += ", completed = :completed"
            expression_values[':completed'] = body['completed']

        update_params = {
            'Key': {'task_id': task_id},
            'UpdateExpression': update_expression,
            'ExpressionAttributeValues': expression_values,
            'ReturnValues': 'ALL_NEW'
        }

        if expression_names:
            update_params['ExpressionAttributeNames'] = expression_names

        response = table.update_item(**update_params)

        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps(response['Attributes'])
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({'error': str(e)})
        }
