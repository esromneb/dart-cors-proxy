#import("dart:io");
#import("dart:uri");
#import("dart:utf");
#source("auth.dart");



final HOST = "127.0.0.1";
final PORT = 5555;
final LOG_REQUESTS = true;


/*

    response.addHeader("Access-Control-Allow-Origin", "*");
    response.addHeader("Access-Control-Allow-Methods", "OPTIONS, " + allowedMethods );
    response.addHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Request-With");
    response.addHeader("Access-Control-Max-Age", "86400");

*/

void httpGet(HttpResponse inputResponse)
{

  HttpClient h = new HttpClient();  
  
  HttpClientConnection conn = h.getUrl(new Uri.fromString(GETURL));
  
  // Add Headers once conneciton is opened 
  conn.onRequest = (HttpClientRequest request) {

    // Set auth header using base64 encoded password
    request.headers.add("Authorization", AUTH);
  
    // When all request data has been written close the stream to indicate the end of the request.
    request.outputStream.close();
    
  };
  
  conn.onResponse = (HttpClientResponse response) {
      
    //print(response.contentLength);
    //print(response.statusCode);
      
      
    InputStream i = response.inputStream;
    i.onData = () {
      print(codepointsToString(i.read()));
    };
    
    i.onClosed = () { 
      print("Closed");
    };
  };
  
  
  
}


void requestReceivedHandler(HttpRequest inputRequest, HttpResponse inputResponse) {
  
  //inputResponse.headers.set(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8");
  
  HttpClient h = new HttpClient();  
  
  HttpClientConnection conn = h.getUrl(new Uri.fromString(GETURL));
  
  // Add Headers once conneciton is opened 
  conn.onRequest = (HttpClientRequest request) {

    // Set auth header using base64 encoded password
    request.headers.add("Authorization", AUTH);
  
    // When all request data has been written close the stream to indicate the end of the request.
    request.outputStream.close();
    
  };
  
  conn.onResponse = (HttpClientResponse remoteResponse) {
      
    //print(response.contentLength);
    //print(response.statusCode);
      
      
    InputStream i = remoteResponse.inputStream;
    
    i.pipe(inputResponse.outputStream);
    
   /* i.onData = () {
      print(codepointsToString(i.read()));
    };
    
    i.onClosed = () { 
      print("Closed");
    };*/
  };
  
  
  
  
  
  
  
  
  
  
  if (LOG_REQUESTS) {
    print("Request: ${inputRequest.method} ${inputRequest.uri}");
  }

  String htmlResponse = createHtmlResponse();
  
  

  
  
  //response.outputStream.writeString(htmlResponse);
  //response.outputStream.close();
}

String createHtmlResponse() {
  return 
'''
<html>
  <style>
    body { background-color: teal; }
    p { background-color: white; border-radius: 8px; border:solid 1px #555; text-align: center; padding: 0.5em; 
        font-family: "Lucida Grande", Tahoma; font-size: 18px; color: #555; }
  </style>
  <body>
    <br/><br/>
    <p>Current time: ${new Date.now()}</p>
  </body>
</html>
''';
}


void main() {
  
//  httpGet();

HttpServer server = new HttpServer();
  
  server.addRequestHandler((HttpRequest request) => true, requestReceivedHandler);
  
  server.listen(HOST, PORT);
  
  print("Serving the current time on http://${HOST}:${PORT}."); 
  
  
  print("Hello World");
}

