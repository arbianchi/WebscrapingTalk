var request = require('request');
var cheerio = require('cheerio');

var pups = [];
var searchResults = [];

function getPups(idx) {
  if (idx < searchResults.length){
    var link = searchResults[idx];
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
    console.log(pups);
  }
}

request('https://raleigh.craigslist.org/search/pet', function (error, response, html) {
  if (!error && response.statusCode == 200) {
    var $ = cheerio.load(html);
    $('.result-info:contains(Puppies), .result-info:contains(puppies), .result-info:contains(Puppy), .result-info:contains(puppy)').each( function(){
      var link = "https://raleigh.craigslist.org" + $( this ).find('.result-title').attr('href');
      searchResults.push(link);
    });
    console.log('SEARCH RESULTS:\n', searchResults);
    getPups(0);
  }
});
