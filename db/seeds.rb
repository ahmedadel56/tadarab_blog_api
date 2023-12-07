# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Categories
category_names = ['Technology', 'Lifestyle', 'Health', 'Education', 'Travel', 'Food', 'Sports', 'Entertainment']
categories = Category.create!(category_names.map { |name| { name: name } })

# Tags
tag_names = ['Ruby', 'Rails', 'JavaScript', 'React', 'NodeJS', 'CSS', 'HTML', 'Python', 'Django', 'VueJS']
tags = Tag.create!(tag_names.map { |name| { name: name } })

# Users (Authors)
10.times do |i|
  role = i < 5 ? 'admin' : 'user'  # First 5 users are admins, others are normal users

  User.create!(
    email: "trainer#{i+1}@example.com", 
    password: 'password', 
    password_confirmation: 'password', 
    name: "Trainer #{i + 1}",
    role: role
  )
end

# Fetch all created users
users = User.all

# Images path
images_path = Rails.root.join('images')

# File extension mapping to content types
file_extensions = {
  'jpg' => 'image/jpeg',
  'jpeg' => 'image/jpeg',
  'png' => 'image/png'
}

# Blogs
5.times do |i|
  blog = Blog.new(
    title: "Blog Post #{i+1}",
    introduction: "Introduction of blog post #{i+1}",
    conclusion: "Conclusion of blog post #{i+1}",
    meta_title: "Meta Title #{i+1}",
    meta_description: "Meta Description for blog post #{i+1}",
    featured: i.zero?,  # Only the first blog will be featured Because of the single_featured_article validation
    length: rand(5..15),
    status: [:draft, :published, :pending].sample
  )

  if blog.save
    # Attach an image to the blog if it has been saved successfully
    image_filename = "image_#{i+1}" # Base filename without extension
    image_files = Dir.glob(images_path.join("#{image_filename}.*")) # Match all files starting with the image base filename

    unless image_files.empty?
      image_path = image_files.first
      file_extension = File.extname(image_path).delete('.').downcase
      content_type = file_extensions[file_extension]

      if content_type
        file = File.open(image_path, 'rb')
        blog.image.attach(io: file, filename: File.basename(image_path), content_type: content_type)
        file.close
      end
    end

    # Assign random authors, categories, and tags to the blog
    blog.authors << users.sample(rand(1..3))
    blog.categories << categories.sample(rand(1..3))
    blog.tags << tags.sample(rand(1..3))

    # Create sections for the blog only after it has been persisted
    3.times do |j|
      blog.sections.create!(
        title: "Section #{j+1} of Blog Post #{i+1}",
        body: "Content for section #{j+1} of Blog Post #{i+1}"
      )
    end
  else
    puts "Failed to create blog: #{blog.errors.full_messages.to_sentence}"
  end
end