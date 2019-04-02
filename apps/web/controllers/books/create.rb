module Web
  module Controllers
    module Books
      class Create
        include Web::Action

        params do
          required(:book).schema do
            required(:title).filled(:str?, max_size?: 200)
            required(:author).filled(:str?, max_size?: 100)
          end
        end

        def call(params)
          if params.valid?
            AddBook.new.call(params[:book])
            redirect_to routes.books_path
          else
            self.status = 422
          end
        end
      end
    end
  end
end
