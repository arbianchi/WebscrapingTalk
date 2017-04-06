namespace :mechanize do
  desc "Sign in with Mechanize"
  task fetch_pups: :environment do
    
    agent = Mechanize.new
    
    # Mechanize setup to rate limit your scraping 
    # to once every half-second.  
    agent.history_added = Proc.new { sleep 0.5 }
    
    page = agent.get("https://www.petfinder.com")
    binding.pry
    
    page = page.link_with(:href => '/user/login/').click
    
    signin_form = page.form_with(:action => '/user/login_check')
    
    signin_form.username = "acuriousloop@gmail.com"
    signin_form.password = "Webscraping2017"
    page = signin_form.submit
    
    search_form = page.form_with(:method => 'GET')
    search_form.location = '27705'
    search_form.animal = 'dog'
    search_form.checkbox_with(:value => 'baby').check
    
    page.search('.adoptablePets-item')
    
  end
end
