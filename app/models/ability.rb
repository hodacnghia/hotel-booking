class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new
    def initialize(user)
      if user.try(:admin?)
        can :dashboard
        can :access, :rails_admin
        can :manage, :all
      elsif user.try(:regular?)
        can :read, :all
        can :create, Hotel
        can :read, City

        can :update, Hotel do |hotel|
          hotel.try(:user) == user
        end
        can :destroy, Hotel do |hotel|
          hotel.try(:user) == user
        end
        can :create, Order
        can :update, Order do |order|
          order.try(:user) == user
        end
      else
        can :read, Hotel
        can :read, City
     

      end
    end
  end
end
