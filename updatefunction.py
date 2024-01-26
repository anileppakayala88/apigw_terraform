import boto3
import json

def lambda_handler(event, context):
    
    # Initialize DynamoDB client
    dynamodb = boto3.resource('dynamodb')
    try:          
        # Specify the DynamoDB table name
        #table_name = 'my_terrafrom_table'
        table = dynamodb.Table('my_terrafrom_table')
        # value = event['body']
        table.put_item(Item={
            'ID': '3',
            'Name': 'Anil',
            'Age': '22'
        })
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': json.dumps('Error')
        }