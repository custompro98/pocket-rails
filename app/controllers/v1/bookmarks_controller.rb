module V1
  class BookmarksController < ::V1::ApplicationController
    def index
      json_response(::Bookmark.where(user_id: current_user.id).limit(limit).offset(offset))
    end

    def show
      json_response(::Bookmark.find_by!(id: params[:id], user_id: current_user.id))
    end

    def create
      bookmark = ::Bookmark.create!(create_bookmark_params)
      json_response(status: :created,
                    headers: {location: v1_bookmark_path(bookmark)})
    end

    def update
      bookmark = ::Bookmark.find_by(id: params[:id])

      raise ::ExceptionHandler::ResourceForbidden unless bookmark.nil? || bookmark.user_id == current_user.id

      if bookmark.present?
        bookmark.update!(update_bookmark_params)
        status = :no_content
      else
        bookmark = ::Bookmark.create!(update_bookmark_params)
        status = :created
      end

      json_response(status: status,
                    headers: {location: v1_bookmark_path(bookmark)})
    end

    def destroy
      ::Bookmark.find_by!(id: params[:id], user_id: current_user.id).destroy
      json_response(status: :no_content)
    end

    private

    def create_bookmark_params
      params.permit(:title, :url).merge(user_id: current_user.id)
    end

    def update_bookmark_params
      {'title' => nil, 'url' => nil, 'favorite' => nil, 'archived' => nil}
        .merge(params.permit(:title, :url, :favorite, :archived))
        .merge(user_id: current_user.id)
    end
  end
end
