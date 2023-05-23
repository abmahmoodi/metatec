class XuiLogin
  include Interactor

  USERNAME = ENV['USERNAME']
  PASSWORD = ENV['PASSWORD']
  XUI_URL = ENV['XUI_URL']
  BASE_URI = "#{XUI_URL}/login?username=#{USERNAME}&password=#{PASSWORD}"
  def call
    result = HTTParty.post("#{BASE_URI}",
                           :headers => { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                                         'Accept' => "application/json, text/plain, */*",
                                         'Accept-Encoding' => 'gzip, deflate' })
    Rails.logger.info "Response Result: #{result}"
    if result['success']
      context.result = result.headers['set-cookie']
    else
      fail!
    end
  end
end
