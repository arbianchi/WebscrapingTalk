
// var casper = require('casper').create();
var casper = require('casper').create({
    clientScripts:  [
                'includes/jquery.js',      // These two scripts will be injected in remote
                'includes/underscore.js'   // DOM on every request
            
    ],
    pageSettings: {
                loadImages:  false,        // The WebPage instance used by Casper will
                loadPlugins: false         // use these settings
            
    },
        logLevel: "info",              // Only "info" level messages will be logged
        verbose: true                  // log messages will be printed out to the console

});
casper.options.waitTimeout = 3000;
var links;

// function getLinks() {
//     // Scrape the links from top-right nav of the website
//     var links = document.querySelectorAll('ul.navigation li a');
//     return Array.prototype.map.call(links, function (e) {
//         return e.getAttribute('href')
//     });
// }

// Opens casperjs homepage
casper.start('http://casperjs.org/');
casper.waitFor(function check() {
    return this.evaluate(function() {
                return document.querySelectorAll('ul.your-list li').length > 2;
            
    });

}, function then() {    // step to execute when check() is ok
    this.captureSelector('yoursitelist.png', 'ul.your-list');
}, function timeout() { // step to execute if check has failed
    this.echo("I can't haz my screenshot.").exit();
});


// casper.then(function () {
//     links = this.evaluate(getLinks);
// });

casper.run(function () {
    for(var i in links) {
        console.log(links[i]);
    }
    casper.done();
});
