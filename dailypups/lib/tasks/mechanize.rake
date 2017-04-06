namespace :mechanize do
  desc "Sign in with Mechanize"
  task fetch_pups: :environment do
    agent = Mechanize.new
    page = agent.get("https://raleigh.craigslist.org/search/pet")
    
    binding.pry
    
    page = agent.get("https://www.petfinder.com")
    
    binding.pry
    
    page = agent.page.link_with(:href => '/user/login/').click
    signin_form = page.form(:method => 'POST')
    signin_form.username = "acuriousloop@gmail.com"
    page.form(:method => 'POST').password = "Webscraping2017"
    page = agent.submit(signin_form, signin_form.buttons.first)
  end
end
