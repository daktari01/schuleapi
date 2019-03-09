class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    json_response(@users)
  end

  # GET /users/{id}
  def show
    json_response(@user)
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      json_response(@user, :created)
    else
      json_response({errors: @user.errors.full_messages},
                    :unprocessable_entity)
    end
  end

  # PUT /users/{id}
  def update
    unless @user.update(user_params)
      json_response({errors: @user.errors.full_messages},
                    :unprocessable_entity)
    end
  end

  # DELETE /users/{id}
  def destroy
    unless @user.destroy
      json_response({errors: @user.errors.full_messages},
                    :unprocessable_entity)
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:avatar, :username, :email, :password, :password_confirmation)
  end
end
