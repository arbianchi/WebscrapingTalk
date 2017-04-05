namespace :mechanize do
    desc "Fetch pups with Mechanize"
    task fetch_pups: :environment do
        agent = Mechanize.new
        page = agent.get("https://raleigh.craigslist.org/search/pet")
        page = agent.page.link_with(:href => '/user/login/').click
        signin_form = page.form(:method => 'POST')
        signin_form.username = "acuriousloop@gmail.com"
        page.form(:method => 'POST').password = "Webscraping2017"
        page = agent.submit(signin_form, signin_form.buttons.first)
        binding.pry
        page.parser.css('a:contains(...)') # Same as Nokogiri::HTML(page.body)
        page.css('td b a').each do |line|
            Pup.create(
                description: line.text,
                img: line.text,
                url: line.text
            )
        end
    end
end
