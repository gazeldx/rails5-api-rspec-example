class ApplicationController < ActionController::API
  before_action :check_header

  private

  def check_header
    if ['POST', 'PUT', 'PATCH'].include?(request.method)
      if request.content_type != "application/vnd.api+json"
        head 406 and return
      end
    end
  end

  def validate_type
    if params['data'] && params['data']['type']
      if params['data']['type'] == params[:controller].sub(/^*.*\//, '').singularize
        return true
      end
    end

    head 409 and return
  end

  def current_user
    @current_user
  end

  def validate_user
    head 403 and return unless (current_user.present? && [Agent, Customer, Administrator].include?(current_user.class))
  end

  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer, meta: default_meta
  end

  def default_meta
    {
      licence: 'CC-0',
      authors: ['Lane Zhang'],
      logged_in: (current_user.present? ? true : false)
    }
  end

  def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end
end
