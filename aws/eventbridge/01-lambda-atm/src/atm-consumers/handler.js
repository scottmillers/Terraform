const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { PutCommand, DynamoDBDocumentClient } = require ("@aws-sdk/lib-dynamodb");

exports.case1Handler = async (event) => {

  try {
     // Get the lambda region from environment variable
    const region = process.env.AWS_REGION || 'us-east-1'; 


    // Create an DynamoDb client
    const dynamoDbClient = new DynamoDBClient({ region });
    const docClient = DynamoDBDocumentClient.from(dynamoDbClient);
 

    const account = event.account;
    const time = event.time;
    const data = JSON.stringify(event, null, 2)
    
    const command = new PutCommand({
      TableName: "Approved",
      Item: {
        Account: account,
        Time: time,
        Transaction: data
      },
    })
    
    console.log(data);

    const response = await docClient.send(command);

    console.log(response);
    return response;


  } catch (error) {
    console.error(error);
    return error;
  }
}

/*
exports.case2Handler = async (event) => {
  console.log('--- NY location transactions ---');
  console.log(JSON.stringify(event, null, 2));

  // Insert event into DynamoDB table
  const params = {
    TableName: 'your-dynamodb-table-name',
    Item: event
  };
  await dynamodb.put(params).promise();

  // Send success response
  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Success' })
  };
}

exports.case3Handler = async (event) => {
  console.log('--- Unapproved transactions ---')
  console.log(JSON.stringify(event, null, 2))

  
  // Send success response
   return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Success' })
  };
}
*/
