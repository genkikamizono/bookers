class BooksController < ApplicationController
  
   def index
      @books = Book.all
      @book = Book.new
   end

    # 記事の表示
    def show
      @book = Book.find(params[:id])
    end

    # 記事の登録
    def create
      
      @book = Book.new(book_params)
      
      if @book.save
        
        flash[:success] = "Book was successfully created."
       
        redirect_to book_path(@book.id)
       
      else
        @books = Book.all
        render 'index'
        
      end
        
    end  
    

    # 記事の編集
    def edit
      @book = Book.find(params[:id])
    end

    # 記事の更新
    def update
      @book = Book.find(params[:id])
      
      # DBに登録できた場合
        if @book.update(book_params)
          
          flash[:success] = "Book was successfully updated."
            # 記事ページに遷移する
          redirect_to book_path(@book.id)
        # DBに登録できなかった場合
        else
            # 編集ページに遷移する
          render 'edit'
        end
        
    end

    # 記事の削除
    def destroy
      
      @book = Book.find(params[:id])

        # 記事の削除
        @book.destroy 
        
        flash[:success] = "Book was successfully destroyed."
       
        # TOPページに遷移する
        redirect_to books_path
    end
    
    # コントローラパラメータの定義
    private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
