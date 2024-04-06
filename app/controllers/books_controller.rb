class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book=Book.new
    @users=User.all  
    @user=current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      @users=User.all  
      @user=current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def show
    @book_new=Book.new
    @book = Book.find(params[:id])
    @user=@book.user
    @book_comment = BookComment.new
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      @books = Book.all
      @users=User.all  
      @user=current_user
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
end
