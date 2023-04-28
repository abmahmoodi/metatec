class InboundInfo
  include Interactor

  def call
    inbound = InboundByRemark.call(remark: context.remark).result
    if inbound.nil?
      context.error = 'Not Found.'
      return
    end

    context.remark = inbound['remark']
    context.upload = (inbound['up'] / 1024) / 1024
    context.download = (inbound['down'] / 1024) / 1024
    context.total = (inbound['total'] / 1024) / 1024
    context.expiryTime = Time.at(inbound['expiryTime'] / 1000).to_datetime
  end
end
