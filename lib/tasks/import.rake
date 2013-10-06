require 'csv'
desc "Import countries from csv file"
task :import => [:environment] do
  # countries migration: 20131005212849
  # rake db:migrate:down VERSION=20131005212849 
  # rake db:migrate:up VERSION=20131005212849 

  # states migration: 20131005212751
  # rake db:migrate:down VERSION=20131005212751 
  # rake db:migrate:up VERSION=20131005212751 

  # cities migration: 20131005212624
  # rake db:migrate:down VERSION=20131005212624 
  # rake db:migrate:up VERSION=20131005212624 
  
    
  file_countries = "db/countries.csv"
  ActiveRecord::Base.connection.execute("DELETE from countries")
  CSV.foreach(file_countries, encoding:'iso-8859-1:utf-8', headers: true) do |row|
    c = Country.new(:id => row[0],
    :name => row[1],
    :iso2 => row[2],
    :iso3 => row[3],
    :phone_code => row[4],
    :locale => row[5]
    ) 
    c.save! 
  end

  file_states = "db/states.csv"
  ActiveRecord::Base.connection.execute("DELETE from states")
  CSV.foreach(file_states, encoding:'iso-8859-1:utf-8', headers: true) do |row|
    c = State.new(:id => row[0],
    :name => row[1],
    :name_code => row[2],
    :country_id => row[3],
    ) 
    c.save! 
  end
  
  file_cities = "db/cities.csv"
  ActiveRecord::Base.connection.execute("DELETE from cities")
  CSV.foreach(file_cities, encoding:'iso-8859-1:utf-8', headers: true) do |row|
    c = City.new(:name => row[0],
    :phone_code => row[1],
    :state_id => row[2],
    ) 
    c.save! 
  end
  
end
