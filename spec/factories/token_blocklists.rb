# spec/factories/token_blocklists.rb
FactoryBot.define do
  factory :token_blocklist do
    token { SecureRandom.hex(10) }
    exp { 1.day.from_now }
  end
end
