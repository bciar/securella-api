# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_admin(email, password)
  return unless Admin.find_by(email: email).nil?
  admin = Admin.create!(email: email, password: password, password_confirmation: password)
  admin.confirm
  admin.reload
  admin.tokens = nil
  admin.save
end

def seed_guardian(email, password)
  return unless Guardian.find_by(email: email).nil?
  guardian = Guardian.create!(email: email, password: password, password_confirmation: password, company_id: 1)
  guardian.confirm
  guardian.reload
  guardian.tokens = nil
  guardian.save
end

def seed_company(email, name, password)
  return unless Company.find_by(email: email).nil?
  company = Company.create!(email: email, name: name, password: password, password_confirmation: password)
  company.confirm
  company.reload
  company.tokens = nil
  company.save
end

seed_admin('nils@lionizers.com',    '123456789')
seed_admin('rike@lionizers.com',    '123456789')
seed_admin('mohamad@lionizers.com', '123456789')

seed_company('partner1@securella.com', 'Strong Security', '123456789')
seed_company('partner2@securella.com', 'Security by Default', '123456789')
seed_company('partner3@securella.com', 'Cool new Partner', '123456789')
seed_company('partner4@securella.com', 'We make you Safe', '123456789')
seed_company('partner5@securella.com', 'Cape Town Sec!', '123456789')
seed_company('partner6@securella.com', '1A Security', '123456789')

seed_guardian('alpha@lionizers.com',  '123456789')
seed_guardian('bravo@lionizers.com',  '123456789')
seed_guardian('charly@lionizers.com', '123456789')
seed_guardian('delta@lionizers.com',  '123456789')
