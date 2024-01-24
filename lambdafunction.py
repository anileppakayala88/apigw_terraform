import boto3
import json

def lambda_handler(event, context):
    
    # Initialize DynamoDB client
    dynamodb = boto3.resource('dynamodb')
    
    # Specify the DynamoDB table name
    #table_name = 'my_terrafrom_table'
    table = dynamodb.Table('my_terrafrom_table')
    
    resp = table.get_item(
       Key={
           'ID': '1'
       }
    )
    print(resp['Item'])
    return {
        'body': json.dumps(resp['Item'])
    }