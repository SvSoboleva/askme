class UsersController < ApplicationController
  # Это действие отзывается, когда пользователь заходит по адресу /users
  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Пользователь #{@user.name} успешно зарегистрирован и залогинен! Привет!"
    else
      render 'new'
    end
  end

  def edit
    @default_color = default_background
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
    @user_background = (@user.background_color || default_background)
  end

  private
  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def default_background
    '#005a55'
  end

  def user_params
    params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :username, :avatar_url, :background_color)
  end
end
