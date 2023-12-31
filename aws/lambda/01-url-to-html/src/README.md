# How to test and develop AWS lambda functions locally

https://www.youtube.com/watch?v=51EAwBDdgio&t=460s

Steps:

1. mkdir lambda-url-to-html
2. Start a new Node project 
```npm init -y```
3. Download the types for Lambda, Node and esbuild-register which allows you to run typescript code from Node.js
```npm install --save-dev  @types/node @types/aws-lambda esbuild-register```
4. Create a index.ts file and add the following code:
    ```typescript
    import { APIGatewayProxyEventV2, APIGatewayProxyStructuredResultV2 } from 'aws-lambda';

    interface Input {
        url: string;
        name: string;
    }

    interface Output {
        title: string;
        s3_url: string;
    }

    export const handler = async(event: APIGatewayProxyEventV2): Promise<APIGatewayProxyStructuredResultV2> =>
    {
        const body: Output = {
            title: "hello world",
            s3_url: "url goes here",
    };

    return {
        statusCode: 200,
        body: JSON.stringify(body),
    }
    };
    ```

5. Create a file called run.ts to run the Lambda function locally
    ```typescript
    import {handler} from './index';

    const main = async () => {
        const res = await handler({} as any);
        console.log(res);
    };

    main();
    ```
6. Run the code with the esbuild-register to convert the typescript code to javascript
```node -r esbuild-register run.ts```
6. Create a lambda function called lambda-url-to-html
7. Add permission to allow the lambda function to write to S3 (AmazonS3FullAccess)
8. Create an alias called live and point it to $LATEST version
9. Install [lambda-build](https://github.com/alexkrkn/lambda-build) to push your code to the lambda function
```npm install -g lambda-build```
10. Get help for lambda-build
```lambda-build --help```
Lambda build will take any typescript file, bundle it to include any npm dependencies and push it to the lambda function
10.  Run lambda-build
```lambda-build upload -r us-east-1 lambda-url-to-html``` 
11. Make it easier to deploy by adding a script to package.json
 ```json
"scripts": {
    "deploy" : "lambda-build upload -r us-east-1 lambda-url-to-html"
  },
  ```
12. Deploy again with `npm run deploy`
13. Publish a new version of the lambda function in the console and give it version 1
14. Go back to the alias we created and point it to version 1
15. Create a new lambda function URL
    - Under the live alias create a new URL
    - Choose the Permissions tab and and create a resource-based policy that grants lambda:invokeFunctionUrl permissions to all principals (*). 

**Problem**
When I create a URL on the alias I get a ```{
    "Message": "Forbidden"
}```
Error message. The Alias has no resource-based policy that grants lambda:invokeFunctionUrl permissions to all principals (*). Why?





