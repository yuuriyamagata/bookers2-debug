class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @book=Book.new
    @user=User.find(params[:id])
    @books=@user.books
  end

  def index
    @users=User.all  
    @user=current_user
    @books=Book.all
    @book=Book.new
  end
  
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @user=User.new(user_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @user.save
      
    flash[:notice] ="You have created user successfully."
    # 4. トップ画面へリダイレクト
    redirect_to user_path(@user.id)
    else
    @users=User.all  
    render :index
    end
 end
 
  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="You have updated user successfully."
      redirect_to user_path(current_user)
    else
      @users=User.all
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
   
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
