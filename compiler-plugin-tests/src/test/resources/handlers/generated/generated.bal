import ballerinax/azure_functions as af;
import ballerina/http;
public listener http:Listener __testListener=af:hl ;type PersonOptionalGenerated Person? ;type PersonArrayGenerated         Person[] ;service http:Service / on __testListener {isolated resource function 'default hello (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.helloHandler(params),params);check caller->respond(response);}public isolated function helloHandler (af:HandlerParams params)returns error? {
string v1=check hello(check af:getBodyFromHTTPInputData(params,"payload"));
_=check af:setStringReturn(params,v1);
}isolated resource function 'default fromHttpToQueue (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.fromHttpToQueueHandler(params),params);check caller->respond(response);}public isolated function fromHttpToQueueHandler (af:HandlerParams params)returns error? {
af:StringOutputBinding v1={};
af:HTTPBinding  v2=fromHttpToQueue(check af:createContext(params,true),check af:getHTTPRequestFromInputData(params,"req"),v1);
_=check af:setStringOutput(params,"msg",v1);
_=check af:setHTTPReturn(params,v2);
}isolated resource function 'default fromQueueToQueue (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.fromQueueToQueueHandler(params),params);check caller->respond(response);}public isolated function fromQueueToQueueHandler (af:HandlerParams params)returns error? {
af:StringOutputBinding v1={};
_=fromQueueToQueue(check af:createContext(params,true),check af:getJsonStringFromInputData(params,"inMsg"),v1);
_=check af:setStringOutput(params,"outMsg",v1);
}isolated resource function 'default fromBlobToQueue (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.fromBlobToQueueHandler(params),params);check caller->respond(response);}public isolated function fromBlobToQueueHandler (af:HandlerParams params)returns error? {
af:StringOutputBinding v1={};
_=check fromBlobToQueue(check af:createContext(params,true),check af:getBytesFromInputData(params,"blobIn"),check af:getStringFromMetadata(params,"name"),v1);
_=check af:setStringOutput(params,"outMsg",v1);
}isolated resource function 'default httpTriggerBlobInput (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerBlobInputHandler(params),params);check caller->respond(response);}public isolated function httpTriggerBlobInputHandler (af:HandlerParams params)returns error? {
string  v1=httpTriggerBlobInput(check af:getHTTPRequestFromInputData(params,"req"),check af:getOptionalBytesFromInputData(params,"blobIn"));
_=check af:setStringReturn(params,v1);
}isolated resource function 'default httpTriggerBlobOutput (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerBlobOutputHandler(params),params);check caller->respond(response);}public isolated function httpTriggerBlobOutputHandler (af:HandlerParams params)returns error? {
af:StringOutputBinding v1={};
string v2=check httpTriggerBlobOutput(check af:getHTTPRequestFromInputData(params,"req"),v1);
_=check af:setBlobOutput(params,"bb",v1);
_=check af:setStringReturn(params,v2);
}isolated resource function 'default sendSMS (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.sendSMSHandler(params),params);check caller->respond(response);}public isolated function sendSMSHandler (af:HandlerParams params)returns error? {
af:TwilioSmsOutputBinding v1={};
string  v2=sendSMS(check af:getHTTPRequestFromInputData(params,"req"),v1);
_=check af:setTwilioSmsOutput(params,"tb",v1);
_=check af:setStringReturn(params,v2);
}isolated resource function 'default cosmosDBToQueue1 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.cosmosDBToQueue1Handler(params),params);check caller->respond(response);}public isolated function cosmosDBToQueue1Handler (af:HandlerParams params)returns error? {
af:StringOutputBinding v1={};
_=cosmosDBToQueue1(<Person[] >check af:getBallerinaValueFromInputData(params,"req",PersonArrayGenerated),v1);
_=check af:setStringOutput(params,"outMsg",v1);
}isolated resource function 'default cosmosDBToQueue2 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.cosmosDBToQueue2Handler(params),params);check caller->respond(response);}public isolated function cosmosDBToQueue2Handler (af:HandlerParams params)returns error? {
af:StringOutputBinding v1={};
_=cosmosDBToQueue2(check af:getJsonFromInputData(params,"req"),v1);
_=check af:setStringOutput(params,"outMsg",v1);
}isolated resource function 'default httpTriggerCosmosDBInput1 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerCosmosDBInput1Handler(params),params);check caller->respond(response);}public isolated function httpTriggerCosmosDBInput1Handler (af:HandlerParams params)returns error? {
string v1=check httpTriggerCosmosDBInput1(check af:getHTTPRequestFromInputData(params,"httpReq"),check af:getParsedJsonFromJsonStringFromInputData(params,"dbReq"));
_=check af:setStringReturn(params,v1);
}isolated resource function 'default httpTriggerCosmosDBInput2 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerCosmosDBInput2Handler(params),params);check caller->respond(response);}public isolated function httpTriggerCosmosDBInput2Handler (af:HandlerParams params)returns error? {
string v1=check httpTriggerCosmosDBInput2(check af:getHTTPRequestFromInputData(params,"httpReq"),<Person? >check af:getOptionalBallerinaValueFromInputData(params,"dbReq",PersonOptionalGenerated));
_=check af:setStringReturn(params,v1);
}isolated resource function 'default httpTriggerCosmosDBInput3 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerCosmosDBInput3Handler(params),params);check caller->respond(response);}public isolated function httpTriggerCosmosDBInput3Handler (af:HandlerParams params)returns error? {
string v1=check httpTriggerCosmosDBInput3(check af:getHTTPRequestFromInputData(params,"httpReq"),<        Person[] >check af:getBallerinaValueFromInputData(params,"dbReq",PersonArrayGenerated));
_=check af:setStringReturn(params,v1);
}isolated resource function 'default httpTriggerCosmosDBOutput1 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerCosmosDBOutput1Handler(params),params);check caller->respond(response);}public isolated function httpTriggerCosmosDBOutput1Handler (af:HandlerParams params)returns error? {
af:HTTPBinding v1={};
json  v2=httpTriggerCosmosDBOutput1(check af:getHTTPRequestFromInputData(params,"httpReq"),v1);
_=check af:setHTTPOutput(params,"hb",v1);
_=check af:setJsonReturn(params,v2);
}isolated resource function 'default httpTriggerCosmosDBOutput2 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerCosmosDBOutput2Handler(params),params);check caller->respond(response);}public isolated function httpTriggerCosmosDBOutput2Handler (af:HandlerParams params)returns error? {
af:HTTPBinding v1={};
json  v2=httpTriggerCosmosDBOutput2(check af:getHTTPRequestFromInputData(params,"httpReq"),v1);
_=check af:setHTTPOutput(params,"hb",v1);
_=check af:setJsonReturn(params,v2);
}isolated resource function 'default httpTriggerCosmosDBOutput3 (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.httpTriggerCosmosDBOutput3Handler(params),params);check caller->respond(response);}public isolated function httpTriggerCosmosDBOutput3Handler (af:HandlerParams params)returns error? {
Person[]  v1=httpTriggerCosmosDBOutput3(check af:getHTTPRequestFromInputData(params,"httpReq"));
_=check af:setBallerinaValueAsJsonReturn(params,v1);
}isolated resource function 'default queuePopulationTimer (http:Caller caller,http:Request request)returns error? {
http:Response response =new;af:HandlerParams params ={request,response};af:handleFunctionResposne(trap self.queuePopulationTimerHandler(params),params);check caller->respond(response);}public isolated function queuePopulationTimerHandler (af:HandlerParams params)returns error? {
af:StringOutputBinding v1={};
_=queuePopulationTimer(check af:getJsonFromInputData(params,"triggerInfo"),v1);
_=check af:setStringOutput(params,"msg",v1);
}}
