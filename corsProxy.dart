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
    
    i.pipe(inputResponse.outputStream);
    /*
    i.onData = () {
      print(codepointsToString(i.read()));
    };
    
    i.onClosed = () { 
      print("Closed");
    };*/
  };
  
  
  
}


void requestReceivedHandler(HttpRequest inputRequest, HttpResponse inputResponse) {
  
  //inputResponse.headers.set(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8");
  
  inputResponse.headers.set("Access-Control-Allow-Origin", "*");
  inputResponse.headers.set("Access-Control-Allow-Methods", "OPTIONS, GET, PUT, POST, DELETE");
  inputResponse.headers.set("Access-Control-Allow-Headers", "Content-Type, Accept, X-Request-With");
  inputResponse.headers.set("Access-Control-Max-Age", "86400");
  
  
  if (LOG_REQUESTS) {
    print("Request: ${inputRequest.method} ${inputRequest.uri}");
  }
  
 httpGet(inputResponse);
  
  

 // String htmlResponse = createHtmlResponse();
  //response.outputStream.writeString(htmlResponse);
  //response.outputStream.close();
}



void main() {

HttpServer server = new HttpServer();
  
  server.addRequestHandler((HttpRequest request) => true, requestReceivedHandler);
  
  server.listen(HOST, PORT);
  
  print("Serving the current time on http://${HOST}:${PORT}."); 
  
  
  print("Hello World");
}

