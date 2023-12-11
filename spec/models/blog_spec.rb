require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:introduction).of_type(:text) }
    it { is_expected.to have_db_column(:conclusion).of_type(:text) }
    it { is_expected.to have_db_column(:meta_title).of_type(:string) }
    it { is_expected.to have_db_column(:meta_description).of_type(:string) }
    it { is_expected.to have_db_column(:featured).of_type(:boolean) }
    it { is_expected.to have_db_column(:length).of_type(:integer) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:image).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:deleted_at).of_type(:datetime) }
  end

  describe 'Associations' do
    it { is_expected.to have_and_belong_to_many(:authors).class_name('User').join_table(:blogs_users) }
    it { is_expected.to have_and_belong_to_many(:categories).join_table(:blogs_categories) }
    it { is_expected.to have_and_belong_to_many(:tags).join_table(:blogs_tags) }
    it { is_expected.to have_many(:sections).dependent(:destroy) }
    it { is_expected.to have_one_attached(:image) }
  end

  describe 'Validations' do
    subject(:blog) { build(:blog) } # This will build a blog with an attached image from your factory
    let(:valid_image) { fixture_file_upload(Rails.root.join('images', 'image_1.jpg'), 'image/jpeg') }
    let(:invalid_format_image) { fixture_file_upload(Rails.root.join('images', 'psd.psd'), 'image/psd') }
    let(:invalid_size_image) { fixture_file_upload(Rails.root.join('images', 'invalid_size.jpg'), 'image/jpeg') }

    before do
      blog.image.attach(valid_image)
    end

    it 'is valid with valid attributes and an image' do
      expect(blog).to be_valid
    end

    it 'has an attached image' do
      expect(blog.image).to be_attached
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:introduction) }
    it { is_expected.to validate_presence_of(:conclusion) }
    it { is_expected.to validate_presence_of(:meta_title) }
    it { is_expected.to validate_presence_of(:meta_description) }
    it { is_expected.to validate_length_of(:meta_title).is_at_most(60).with_message('must be at most 60 characters') }
    it {
      is_expected.to validate_length_of(:meta_description).is_at_most(160)
        .with_message('must be at most 160 characters')
    }

    it 'is valid with a properly sized and formatted image' do
      expect(blog).to be_valid
    end

    it 'is invalid with an image of an unsupported format' do
      blog.image.attach(invalid_format_image)
      expect(blog).not_to be_valid
      expect(blog.errors[:image]).to include('has an invalid content type')
    end

    it 'is invalid with an image that is too large' do
      blog.image.attach(invalid_size_image)
      expect(blog).not_to be_valid
      expect(blog.errors[:image]).to include('file size must be less than 100 KB (current size is 19.1 MB)')
    end

    context 'sections count' do
      it 'validates the maximum number of sections' do
        blog.sections = build_list(:section, 15, blog:) # Associate sections with the blog
        blog.save
        expect(blog.sections.size).to eq(15)
      end

      it 'is not valid with more than 15 sections' do
        blog.sections = build_list(:section, 16, blog: nil) # Build sections in memory
        blog.valid? # Trigger validations manually

        expect(blog).not_to be_valid
        expect(blog.errors[:sections]).to include('exceed the maximum allowed count')
        expect(blog.sections.size).not_to eq(15) # The size should still be 15
      end
    end
    # Custom validation for a single featured article
    context 'when another featured blog exists' do
      before do
        # Clean up any existing featured blogs
        Blog.where(featured: true).destroy_all

        # Create a new featured blog
        create(:blog, featured: true)
      end

      it 'does not allow a second featured blog' do
        new_blog = build(:blog, featured: true)
        new_blog.valid? # Trigger validations
        expect(new_blog.errors[:featured]).to include('There can only be one featured article')
      end
    end
  end

  require 'rails_helper'
  require 'action_dispatch/testing/test_process'

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status).with_values(draft: 0, published: 1, pending: 2) }
  end
end
