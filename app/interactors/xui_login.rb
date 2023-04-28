class XuiLogin
  include Interactor

  USERNAME = ENV['USERNAME']
  PASSWORD = ENV['PASSWORD']
  BASE_URI = "http://iran.metatec.fun:53968/login?username=#{USERNAME}&password=#{PASSWORD}"
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
