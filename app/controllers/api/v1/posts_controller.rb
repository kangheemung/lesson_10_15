class Api::V1::PostsController < ApplicationController
    def index
    #posts =Post.limit(100)#≤ =データ多い時
        #if posts.count > 0
        #render json: {status: 201, data: posts }
        #else
        #render json:{status:400, error: "posts can't found"}
        #end
    puts "user parameter check"
    puts params
    page = params[:page].to_i || 1
    per_page = 100

    offset = (page - 1) * per_page
    posts = Post.order(created_at: :desc).offset(offset).limit(per_page)

    @post_data = []
    posts.each do |post|
      @post_data << { title: post.title, body: post.body }
    end

    render json: @post_data
  
    end
    # def show 
    #     p"===================="
    #     p params 
    #     p"================="
    #     post=Post.find(params[:id])
    #   　p"===================="#インテンド揃うこと注意しましょう。
    #     p params
    #     p"================="
    #     render json: post
    #   　p"===================="
    #     p params
    #     p"================="
    # end
    
    #問題の要件をしっかり理解して取り組みましょう。
    
    def update
      posts = Post.find(params[:id])
      posts.update(post_params)
      render json: {status: 201, data: posts }
    end

    private
    def post_params
        params.permit(:title, :body)
    end
    
end
