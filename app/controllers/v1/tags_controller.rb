module V1
  class TagsController < ::V1::ApplicationController
    def index
      tags = ::Tag.where(user_id: current_user.id)
      tags = tags
        .joins(:bookmarks)
        .where(bookmarks: {id: params[:bookmark_id]}) if params[:bookmark_id]

      json_response(tags.limit(limit).offset(offset))
    end

    def create
      if params[:bookmark_id].present?
        owned_by_current_user?(::Bookmark, params[:bookmark_id])
        owned_by_current_user?(::Tag, params[:tag_ids])
        params[:tag_ids].map do |tag_id|
          ::TagJoin.create!(tag_id: tag_id,
                            taggable_id: params[:bookmark_id],
                            taggable_type: 'Bookmark')
        end
        location = v1_bookmark_path(params[:bookmark_id])
      else
        ::Tag.create!(create_tag_params)
        location = v1_tags_path
      end

      json_response(status: :created,
                    headers: {location: location})
    end

    def destroy
      if params[:bookmark_id].present?
        owned_by_current_user?(::Bookmark, params[:bookmark_id])
        owned_by_current_user?(::Tag, params[:id])
        ::TagJoin.find_by!(taggable_id: params[:bookmark_id],
                           taggable_type: 'Bookmark',
                           tag_id: params[:id]).destroy
      else
        ::Tag.find_by!(id: params[:id], user_id: current_user.id).destroy
      end

      json_response(status: :no_content)
    end

    private

    def owned_by_current_user?(relation, id)
      unless relation.where(id: id).all? { |resource| resource.user_id == current_user.id }
        raise ::ExceptionHandler::ResourceForbidden
      end
    end

    def create_tag_params
      params.permit(:name).merge(user_id: current_user.id)
    end
  end
end
