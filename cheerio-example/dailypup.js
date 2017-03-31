var request = require('request');
var cheerio = require('cheerio');
var pups = [];
var results = [];

function getPups(idx) {
  if (idx < results.length){
    var link = results[idx].url;
    request(link, function (error, response, html) {
      if (!error && response.statusCode == 200) {
        var $ = cheerio.load(html);
        pup = {}
        pup.title = $('#titletextonly').text().trim();
        pup.description = $('#postingbody').text().trim(); 
        pup.url = link;
        pup.images = [];
        $('.slide.first.visible img').each(function(){
          pup.images.push( $( this ).attr( 'src' ));
        })
        pups.push(pup);
        getPups(++idx)
      }
    });
  } else {
    console.log("PUPS", pups);
  }
}

request('https://raleigh.craigslist.org/search/pet', function (error, response, html) {
  if (!error && response.statusCode == 200) {
    var $ = cheerio.load(html);
    var titles = $('.result-title').text();
    $('.result-info:contains(Puppies), .result-info:contains(puppies), .result-info:contains(Puppy), .result-info:contains(puppy)').each( function(){
      pet = {}
      pet.url = "https://raleigh.craigslist.org" + $( this ).find('.result-title').attr('href');
      results.push(pet);
    });
    getPups(0);
  }
});
