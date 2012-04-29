#import('dart:html');
#import('dart:json');






class couch {

  var settings;
  
  getSettings()
  {
    
    var v = {
             "chart": {
               "renderTo": "container",
               "type": "area"
           },
           "xAxis": {
               "labels": {}
           },
           "yAxis": {
               "title": {
                   "text": "Nuclear weapon states"
               },
               "labels": {}
           },
           "tooltip": {},
           "plotOptions": {
               "area": {
                   "pointStart": 1940,
                   "marker": {
                       "enabled": false,
                       "symbol": "circle",
                       "radius": 2,
                       "states": {
                           "hover": {
                               "enabled": true
                           }
                       }
                   }
               }
           },
           "series": [
               {
                   "name": "USA",
                   "data": [0
                   
                   ]
               },
               {
                   "name": "USSR/Russia",
                   "data": [
                       null,
                       null,
                       null,
                       null,
                       null,
                       null,
                       null,
                       null,
                       null,
                       null,
                       5,
                     
                   ]
               }
           ]
       };
    
    settings = v;
    return v;
   
  }
  
  couch() {
    print ("hello");
    this.getSettings();
  }

  void run() {
 
    
    getLanguageData(String languageName, onSuccess(XMLHttpRequest req)) {
      var url = "http://localhost:5555/"; 
      
      // call the web server asynchronously 
      var request = new XMLHttpRequest.getTEMPNAME(url, onSuccess);
    }

    // print the raw json response text from the server
    onSuccess(XMLHttpRequest req) {
     // append(req.responseText); // print the received raw JSON text
       
       
      Map json = JSON.parse(req.responseText);
      
      
      json["rows"].forEach((element) { 
  
      bool isList = element["value"]["response"]["object"] is List;
      if( isList )
      {
       // print(element["value"]["response"]["object"].length);
        addSeries(0, element["value"]["response"]["object"].length);
      }
//        print(element["value"]["response"]["object"].length);
      
      });
      
     // var eventList = json["rows"][10]["response"]["object"];
      launchChart("");
      
    }

    getLanguageData("dart", onSuccess);
    
    
    
  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
  
  void append(String m) {
    document.query('#status').innerHTML = "${document.query('#status').innerHTML} <br/> $m";
  }
  
  void addSeries(int i, int point )
  {
    this.settings["series"][i]["data"].add(point);
  }
  
  void modify()
  {
   // this.settings["series"][0]["data"] = [30000,30,30000,30,30000,30,30000,30,30000,30,30000,30,30000,30,30000,30,30000,30];
  }
  
  void launchChart(String data)
  {
    modify();
    String s = JSON.stringify(settings);
    //window.postMessage(data, "*");
    window.postMessage(s, "*");
    //append(data);
  }
}


//String jsondata = '{"chart":{"renderTo":"container","type":"area"},"xAxis":{"labels":{}},"yAxis":{"title":{"text":"Nuclear weapon states"},"labels":{}},"tooltip":{},"plotOptions":{"area":{"pointStart":1940,"marker":{"enabled":false,"symbol":"circle","radius":2,"states":{"hover":{"enabled":true}}}}},"series":[{"name":"USA","data":[null,null,null,null,null,6,11,32,110,235,369,640,1005,1436,2063,3057,4618,6444,9822,15468,20434,24126,27387,29459,31056,31982,32040,31233,29224,27342,26662,26956,27912,28999,28965,27826,25579,25722,24826,24605,24304,23464,23708,24099,24357,24237,24401,24344,23586,22380,21004,17287,14747,13076,12555,12144,11009,10950,10871,10824,10577,10527,10475,10421,10358,10295,10104]},{"name":"USSR/Russia","data":[null,null,null,null,null,null,null,null,null,null,5,25,50,120,150,200,426,660,869,1060,1605,2471,3322,4238,5221,6129,7089,8339,9399,10538,11643,13092,14478,15915,17385,19055,21205,23044,25393,27935,30062,32049,33952,35804,37431,39197,45000,43000,41000,39000,37000,35000,33000,31000,29000,27000,25000,24000,23000,22000,21000,20000,19000,18000,18000,17000,16000]}]}';


void main() {
  couch c = new couch();
  c.run();
 // c.launchChart(jsondata);
 //  new couch().run();
  
}
