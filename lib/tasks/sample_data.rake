namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(first_name: "Joao",
                 last_name: "Teste",
                 email: "joao@teste.com.br",
                 valid_email: true,
                 admin_flag: true,
                 active: true,
                 mobile_phone_number: "1234567890",
                 valid_mobile_phone: true,
                 city_id: 5276,
                 state_id: 25,
                 country_id: 1,
                 gender: "Male",
                 birthday: "10/02/1900",                
                 password: "teste")
  end
end  
