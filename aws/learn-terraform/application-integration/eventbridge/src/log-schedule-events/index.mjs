// Node 20.x code
export const handler = async (event) => {
  
    console.log('LogScheduledEvent');
    console.log('Received event:', JSON.stringify(event, null, 2));
    
    const response = {
      statusCode: 200,
      
    };
    return response;
  };
  