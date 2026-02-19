class ApplicationMailer < ActionMailer::Base
  default from: "arpitadmn@gmail.com"
  layout "mailer"
  def delivery_method
    super.tap do |method|
      puts "=== DELIVERY METHOD: #{method.inspect} ==="
    end
  end
end
