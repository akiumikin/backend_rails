class SystemController < ApplicationController
  def info
    res = {
      framework: 'Ruby on Rails',
      frameworkVersion: Rails.version,
      language: 'Ruby',
      languageVersion: RUBY_VERSION,
    }

    render json: res, status: 200
  end
end
