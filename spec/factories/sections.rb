# spec/factories/sections.rb
FactoryBot.define do
  factory :section do
    title { 'Example Section Title' }
    body { 'Example section body content.' }
    blog
  end
end
