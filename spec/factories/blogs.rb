# spec/factories/blogs.rb
FactoryBot.define do
  factory :blog do
    title { 'Sample Blog Title' }
    introduction { 'Sample introduction text.' }
    conclusion { 'Sample conclusion text.' }
    meta_title { 'Sample Meta Title' }
    meta_description { 'Sample meta description.' }
    featured { false }
    status { :draft }

    after(:build) do |blog|
      blog.image.attach(io: File.open(Rails.root.join('images', 'image_1.jpg')),
                        filename: 'image_1.jpg',
                        content_type: 'image/jpeg')
    end
  end
end
