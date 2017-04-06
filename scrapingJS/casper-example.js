var casper = require('casper').create({
  // Inject jQuery into every page
  clientScripts:  [
    "node_modules/jquery/dist/jquery.min.js"
  ]
});

casper.options.waitTimeout = 3000;

var pups;
var body;

function getPups() {
  var pups = [];
  $('.adoptablePets-item').each(function(){
    var pup = {};
    pup.name = $( this ).find('.pet-name-container h2 a').text().trim();
    pup.breed = $( this ).find('.breed').text().trim();
    pup.specs = $( this ).find('.specs').text().trim();
    pup.url = location.host + $( this ).find('.pet-name-container h2 a').attr('href');
    pups.push(pup);
    
  })
  return pups;
}

// Opens casperjs homepage
casper.start('https://www.petfinder.com/pet-search?location=durham%2C+nc&animal=dog&breed=&age=baby');

// Wait for results to load onto page
casper.waitFor(function check() {
  return this.evaluate(function() {
    return document.querySelectorAll('.adoptablePets-item').length > 0;
  });
  
}, function then() {    // Step to execute if check is ok
  pups = this.evaluate(getPups);
}, function timeout() { // Step to execute if check has failed
  this.echo("No pups found").exit();
});

casper.run(function () {
  for(var i = 0; i < pups.length; i++){
    for(var property in pups[i]){
      var pupDetails = property + ': ' + pups[i][property];
      console.log(pupDetails);
    }
    console.log('\n');
  }
});
