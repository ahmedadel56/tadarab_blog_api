class Ability
  include CanCan::Ability

  def initialize(user)
    # Ensure that a user object is provided
    return unless user

    case user.role
    when 'admin'
      can :manage, :all # Admin users can perform any action on all resources
    when 'user'
      # Define abilities for regular users
      can :read, Blog # Regular users can view blogs
      can :read, Tag # Regular users can view tags
      can :read, Section # Regular users can view sections
      can :read, Category # Regular users can view categories
      # Add more abilities for the user role as needed
    end
    # Define abilities for other roles if necessary
  end
end
