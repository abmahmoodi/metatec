class InboundByRemark
  include Interactor

  def call
    cookie = XuiLogin.call.result
    inbounds = XuiInboundList.call(cookie: cookie).result
    inbound = inbounds.find {|i| i['remark'] == context.remark}
    context.result = inbound
  end
end