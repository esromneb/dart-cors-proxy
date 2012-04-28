#import('dart:html');

class couch {

  couch() {
  }

  void run() {
 
    
    //http://dl.dropbox.com/u/825637/dart-hackathon/json1.txt
    
    
    
    getLanguageData(String languageName, onSuccess(XMLHttpRequest req)) {
      var url = "http://localhost:5555/"; 
      
      // call the web server asynchronously 
      var request = new XMLHttpRequest.getTEMPNAME(url, onSuccess);
    }

    // print the raw json response text from the server
    onSuccess(XMLHttpRequest req) {
       write(req.responseText); // print the received raw JSON text
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
