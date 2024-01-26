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
            resp = table.scan()

            print(resp['Items'])
            return {
                'body': json.dumps(resp['Items'])
                # 'body': json.dumps(value)
            }
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': json.dumps('Error')
        }