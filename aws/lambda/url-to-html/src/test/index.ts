import { APIGatewayProxyEventV2 } from "aws-lambda";
import {describe, it, afterEach} from "mocha";
import {handler, Input, Output, storage } from "../index";
import {stub, restore} from "sinon";
import axios from "axios";
import { strictEqual } from "assert";



const executeLambda = async (url: string, name: string): Promise<Output | null> => {
    const output = await handler({queryStringParameters: {url, name }});
    let outputBody: Output | null = null;
    if (output) {
        outputBody = JSON.parse(output.body);
    }
    return outputBody;
}

describe('handler', () => {

it('should extract and return the page title of a url', async () => {
    const s3UrlFile = 'https://s3fileurl.com'
    const title = "This is the title of example.com";
    
    stub(axios,"get").resolves({ data: `<html><head><title>${title}</title></head></html>` }); // hijack the call to axios
    stub(storage, 'storeHtmlFile').resolves(s3UrlFile);
    
    const output = await executeLambda("http://example.com",'');
    strictEqual(output.title, title); // verify the results
    strictEqual(output.s3_url, s3UrlFile); // verify the results
    //console.log({output});
})



})