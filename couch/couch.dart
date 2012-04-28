#import('dart:html');
#import('dart:json');

class couch {

  couch() {
  }

  void run() {
 
    
    getLanguageData(String languageName, onSuccess(XMLHttpRequest req)) {
      var url = "http://localhost:5555/"; 
      
      // call the web server asynchronously 
      var request = new XMLHttpRequest.getTEMPNAME(url, onSuccess);
    }

    // print the raw json response text from the server
    onSuccess(XMLHttpRequest req) {
       write(req.responseText); // print the received raw JSON text
       
       
       
      Map json = JSON.parse(req.responseText);
      
     // json["rows"];
      
      /*
      
      json["rows"].forEach(
      
        (k,v) {
          print('$k : $v');
          
          
        }
      );*/
      
      json["rows"].forEach((element) => print(element));
      
    }

    getLanguageData("dart", onSuccess);
    
    
    
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
}

void main() {
  new couch().run();
}
