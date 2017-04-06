namespace :nokogiri do
    desc "Fetch pups with Nokogiri"
    task fetch_pups: :environment do
        # require 'open-uri'
        # require 'nokogiri'

        cities = [ 'raleigh', 'asheville', 'boone' ]
        
        cities.each do |city|
          base_url = "https://#{city}.craigslist.org" 
          search_terms = [ 'pup', 'dog' ]
          
          url = base_url + "/search/pet"
          
          page = Nokogiri::HTML(open(url))  
          binding.pry
          
          links = page.css(".result-title").map{ |result| result.attr('href') }
          
          links.each do |link|
            result_url = base_url + link
            page = Nokogiri::HTML(open(result_url))  
            
            description = page.css("#postingbody").text
            if search_terms.any? { |term| description.downcase.include? term }
              
              title = page.css("#titletextonly").text
              img = page.css(".slide img").present? ? page.css(".slide img").first.attr('src') : ''
              
              Pup.create!( 
                          title: title,
                          description: description,
                          img: img,
                          url: result_url
                        )
              puts 'Found a pup!'
            else
              puts 'No pup found.'
            end
          end
        end
    end
end
