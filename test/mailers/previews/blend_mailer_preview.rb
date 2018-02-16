class BlendMailerPreview < ActionMailer::Preview

  def blend_request_email
    BlendMailer.blend_request_email(10)
  end

end
