const { PutEventInTable } = require("./my-module")

exports.lambdaHandler = async (event, context) => {
  return await PutEventInTable(event, "ApprovedTransactions")  
}

