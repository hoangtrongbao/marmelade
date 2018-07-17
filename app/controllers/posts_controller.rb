class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate, only: [:index, :admin, :new, :create, :edit, :update, :destroy]
	
	def index
  	if params[:category].blank?
		 	@posts = Post.all.order("created_at DESC")

		else
		 	@category_id = Category.find_by(name: params[:category]).id
		 	@posts = Post.where(category_id: @category_id).order("created_at DESC")
  	end
	end

	def show
		
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)

		if @post.save
			flash[:sucsess] = "The post was created!"
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @post.update(post_params)
			redirect_to @post, notice: "Update successful"
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path, notice: "Post destroyed"
	end

	def admin
		redirect_to root_path if authenticate
	end

	private

		def post_params
			params.require(:post).permit(:title, :content, :category_id, :image)
		end

		def find_post
			@post = Post.find(params[:id])
		end

	protected

		def authenticate
		  authenticate_or_request_with_http_basic do |username, password|
		  	admin_username = Rails.application.secrets.admin_username
		  	admin_password = Rails.application.secrets.admin_password
		  	username == admin_username && password == admin_password 
		  end
	 end
end
