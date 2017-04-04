namespace :scraper do
    desc "Fetch pups"
    task fetch_pups: :environment do
        # require 'open-uri'
        # require 'nokogiri'

        # https://www.petfinder.com/pet-search?location=durham%2C+nc&animal=dog&breed=&age=baby&filtersUpdated=false&distance=300&name=&page_size=1146
        url = "https://www.petfinder.com/pet-search?location=durham%2C+nc&animal=dog&breed=&age=baby&filtersUpdated=false"
        page = Nokogiri::HTML(open(url))  
        binding.pry
        page.css('td b a').each do |line|
            puts line.text  # "Spanish" 
            Pup.create(
                description: line.text,
                img: line.text,
                url: line.text
            )
        end
    end
end
