module Api
  module V1
    class BookmarksController < ApplicationController
      def index
        json_response(::Bookmark.limit(limit).offset(offset))
      end

      def show
        json_response(::Bookmark.find(params[:id]))
      end

      def create
        bookmark = ::Bookmark.create!(create_bookmark_params)
        json_response(status: :created,
                      headers: {location: api_v1_bookmark_path(bookmark)})
      end

      def update
        bookmark = ::Bookmark.find_by(id: params[:id])

        if bookmark.present?
          bookmark.update!(update_bookmark_params)
          status = :no_content
        else
          bookmark = ::Bookmark.create!(update_bookmark_params)
          status = :created
        end

        json_response(status: status,
                      headers: {location: api_v1_bookmark_path(bookmark)})
      end

      def destroy
        ::Bookmark.find(params[:id]).destroy
        json_response(status: :no_content)
      end

      private

      def limit
        10
      end

      def offset
        params[:page].present? ? ((params[:page].to_i - 1) * limit) : 0
      end

      def create_bookmark_params
        params.permit(:title, :url).merge(user_id: current_user.id)
      end

      def update_bookmark_params
        {'title' => nil, 'url' => nil, 'favorite' => nil, 'archived' => nil}
          .merge(params.permit(:title, :url, :favorite, :archived))
          .merge(user_id: current_user.id)
      end

      def current_user
        # TODO: once auth is implemented, make this actual current user
        ::User.first_or_create(first_name: 'Default', last_name: 'User', email: 'test@example.com', password: 'password')
      end
    end
  end
end
