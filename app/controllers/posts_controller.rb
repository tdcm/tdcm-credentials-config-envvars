class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  # before_action :authorize_admin, only: %i[ index ]

  def index
    @posts = policy_scope(Post).order(created_at: :desc)
    authorize @posts
  end

  def show
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      current_user.add_role :creator, @post
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @post
    if @post.update(post_params)
      current_user.add_role :editor, @post
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private
    def authorize_admin
      unless current_user.has_role?(:admin2) || current_user.has_role?(:admin)
      redirect_to root_path, alert: "You are not authorized"
      end
    end
  
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
