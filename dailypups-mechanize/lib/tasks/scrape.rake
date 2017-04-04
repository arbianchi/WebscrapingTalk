namespace :scraper do
    desc "Fetch pups"
    task fetch_pups: :environment do
        # require 'open-uri'
        # require 'nokogiri'

        # https://www.petfinder.com/pet-search?location=durham%2C+nc&animal=dog&breed=&age=baby&filtersUpdated=false&distance=300&name=&page_size=1146
        agent = Mechanize.new
        page = agent.get("https://www.petfinder.com")
        page = agent.page.link_with(:href => '/user/login/').click
        signin_form = page.form(:method => 'POST')
        signin_form.username = "acuriousloop@gmail.com"
        page.form(:method => 'POST').password = "Webscraping2017"
        page = agent.submit(signin_form, signin_form.buttons.first)
        binding.pry
        page.parser.css('a:contains(...)') # Same as Nokogiri::HTML(page.body)
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
