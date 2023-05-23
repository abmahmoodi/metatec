class XuiInboundList
  include Interactor

  USERNAME = ENV['USERNAME']
  PASSWORD = ENV['PASSWORD']
  XUI_URL = ENV['XUI_URL']
  BASE_URI = "#{XUI_URL}/xui/inbound/list"
  def call
    result = HTTParty.post("#{BASE_URI}",
                           :headers => {
                             'Cookie' => context.cookie,
                             'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
                             'Connection' => 'keep-alive',
                             'Accept' => "application/json, text/plain, */*",
                             'Accept-Encoding' => 'gzip, deflate',
                             'Content-Length' => '0',
                             'X-Requested-With' => 'XMLHttpRequest' })
    # Rails.logger.info "Response Result: #{result}"
    if result['success']
      context.result = result['obj']
    end
  end
end
