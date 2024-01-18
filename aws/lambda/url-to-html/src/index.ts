import { APIGatewayProxyEventV2, APIGatewayProxyStructuredResultV2 } from 'aws-lambda';
import * as cheerio from 'cheerio';
import axios from 'axios';
import { OutputLocationFilterSensitiveLog, PutObjectCommand, S3Client } from '@aws-sdk/client-s3';

const BUCKET = 'storage-for-lambda-url-to-html';
const s3Client = new S3Client({region: 'us-east-1'});


export const storage = {

    storeHtmlFile: async (content: string, name: string): Promise<string> => {
        const key = `${name}.html`;
        const command = new PutObjectCommand({
            Bucket: BUCKET,
            Key: key,
            Body: Buffer.from(content),
            ContentType: 'text/html',
        });

        await s3Client.send(command);
        return `https://${BUCKET}.s3.amazonaws.com/${key}`;
    }
}




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
    const output: Output = {
        title: '',
        s3_url: '',
    };

    try {

        const body = event.queryStringParameters as unknown as Input;
        const res = await axios.get(body.url);
        output.title = cheerio.load(res.data)(`head > title`).text();
        output.s3_url = await storage.storeHtmlFile(res.data, body.name);

    } catch (err) {
        console.error(err);
    }


    return {
        statusCode: 200,
        body: JSON.stringify(output),
    }
};