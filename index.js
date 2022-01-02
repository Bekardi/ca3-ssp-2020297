const { route } = require('express/lib/application');
const   http = require('http'), //This module provides the HTTP server functionalities
        path = require('path'), //The path module provides utilities for working with file and directory paths
        express = require('express'), //This module allows this app to respond to HTTP requests, defines the routing and renders back the required content
        fs = require('fs'), //This module allows to work with the file system: read and write files back
        xmlParse = require('xslt-processor').xmlParse, //This module allows to work with XML files
        xsltProcess = require('xslt-processor').xsltProcess, //The same module allows us to uitlise XSL Transformations
        xml2js = require('xml2js'); //This module does XML <-> JSON conversion

const   router = express(), 
        server = http.createServer(router);

router.use(express.static(path.resolve(__dirname,'views'))); //We serve static content from "views" folder
router.use(express.urlencoded({extended: true})); //We allow the data sent from the client to be encoded in a URL targeting our end point
router.use(express.json()); //We include support for JSON

// Function to read in XML file and convert it to JSON
function XMLtoJSON(filename, cb) {
    var filepath = path.normalize(path.join(__dirname, filename));
    fs.readFile(filepath, 'utf8', function(err, xmlStr) {
      if (err) throw (err);
      xml2js.parseString(xmlStr, {}, cb);
    });
};
  
  //Function to convert JSON to XML and save it
function JSONtoXML(filename, obj, cb) {
    var filepath = path.normalize(path.join(__dirname, filename));
    var builder = new xml2js.Builder();
    var xml = builder.buildObject(obj);
    fs.unlinkSync(filepath);
    fs.writeFile(filepath, xml, cb);
};

router.get('/get/html', (req, res) => { 

   res.writeHead(200, {'Content' : 'text/html'}); //200 means that this content/page exist 

   let xml = fs.readFileSync('MyMovies.xml', 'utf8'),  
       xsl = fs.readFileSync('MyMovies.xsl', 'utf8');

   let doc = xmlParse(xml), //turning xml and xsl strings into objects
       stylesheet = xmlParse(xsl);

   let result = xsltProcess(doc, stylesheet);  //turn these objects into html page

   res.end(result.toString()); //turning it back to string to send to end user

});

router.post('/post/json', function (req, res) {

    function appendJSON(obj) {

        console.log(obj)

        XMLtoJSON('MyMovies.xml', function (err, result) {
            if (err) throw (err);
            
            result.catalog.section[obj.sec_n].movie.push({'title': obj.title, 'director': obj.director, 'country': obj.country, 'company': obj.company, 'year': obj.year});

            console.log(JSON.stringify(result, null, "  "));

            JSONtoXML('MyMovies.xml', result, function(err){
                if (err) console.log(err);
            });
        });
    };

    appendJSON(req.body);

    res.redirect('back');

});

router.post('/post/delete', function (req, res) {

    function deleteJSON(obj) {

        console.log(obj)

        XMLtoJSON('MyMovies.xml', function (err, result) {
            if (err) throw (err);
            
            delete result.catalog.section[obj.section].movie[obj.movie];

            console.log(JSON.stringify(result, null, "  "));

            JSONtoXML('MyMovies.xml', result, function(err){
                if (err) console.log(err);
            });
        });
    };

    deleteJSON(req.body);

    res.redirect('back');

});

server.listen(process.env.PORT || 8000, process.env.IP || "0.0.0.0", function() {
    const addr = server.address();
    console.log("Server listening at", addr.address + ":" + addr.port)
});
