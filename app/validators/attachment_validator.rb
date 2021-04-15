class AttachmentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? || !value.attached?

    has_error = false

    if options[:maximum]
      has_error = true if value.size > options[:maximum]
    end

    record.errors.add(attribute, '画像は3枚以下にしてください') if has_error
  end
end
