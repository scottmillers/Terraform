// The consuming service (target) Lambda functions
exports.case1Handler = async (event) => {
  console.log('--- Approved transactions ---')
  console.log(JSON.stringify(event, null, 2))

  // Send success response
  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Success' })
  };
}

exports.case2Handler = async (event) => {
  console.log('--- NY location transactions ---')
  console.log(JSON.stringify(event, null, 2))
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
