class UsersController < ApplicationController
  # Это действие отзывается, когда пользователь заходит по адресу /users
  before_action :load_user, except: [:index, :new, :create]
  before_action :load_questions, only: [:destroy, :show]
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
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def show
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Аккаунт  #{@user.name} успешно удален"
  end

  private
  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def load_questions
    @questions = @user.questions.order(created_at: :desc)
  end

  def user_params
    params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :username, :avatar_url, :background_color)
  end
end
