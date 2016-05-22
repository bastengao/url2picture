class ScreenshotsController < ApplicationController
  def index
    url = params[:url]
    format = params[:format] || 'png'

    render text: 'url param is missing' and return if url.blank?


    session = Capybara::Session.new(:poltergeist)
    session.visit url

    file_name = "tmp/screenshots/#{Time.now.to_i}.#{format}"
    session.save_screenshot(file_name, :full => true, format: format)

    send_file file_name, disposition: 'inline'
  end
end
