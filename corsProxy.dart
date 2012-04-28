#import("dart:io");
#import("dart:uri");
#import("dart:utf");

final String GETURL = "";
final String AUTH = "";


final HOST = "127.0.0.1";
final PORT = 8080;
final LOG_REQUESTS = true;

void httpGet()
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

void main() {
  
 httpGet();

  
  print("Hello World");
}
