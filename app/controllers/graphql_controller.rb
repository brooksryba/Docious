# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  protect_from_forgery with: :null_session

  def execute # rubocop:disable Metrics/MethodLength
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user:
    }
    result = DociousSchema.execute(query, variables:, context:, operation_name:)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  # gets current user from token stored in the session
  def current_user # rubocop:disable Metrics/AbcSize
    # if we want to change the sign-in strategy, this is the place to do it
    return unless request.headers['Authorization'] && request.headers['Authorization'] != ''

    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
    token = crypt.decrypt_and_verify request.headers['Authorization']
    user_id = token.gsub('user-id:', '').to_i
    user = User.find_by(id: user_id)
    user.update!(pinged_at: DateTime.current)
    user
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param) # rubocop:disable Metrics/MethodLength
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e) # rubocop:disable Naming/MethodParameterName
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
