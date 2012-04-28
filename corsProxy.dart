#import("dart:io");
#import("dart:uri");
#import("dart:utf");

void main() {
  
  HttpClient h = new HttpClient();  
  
  HttpClientConnection conn = h.getUrl(new Uri.fromString("http://user:pw@localhost:5984/"));
  conn.onResponse = (HttpClientResponse response) {
    
  print(response.contentLength);
  print(response.statusCode);
    
    
  InputStream i = response.inputStream;
  i.onData = () {
    print(codepointsToString(i.read()));
  };
  
  i.onClosed = () { 
    print("Closed");
  };

  
};

  
  print("Hello World");
}
