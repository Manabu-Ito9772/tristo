class AttachmentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? || !value.attached?

    if options[:maximum]
      if value.byte_size > options[:maximum]
        record.errors[attribute] << '5MB以下にしてください'
      end
    end

    return unless options[:content_type]

    return if value.content_type.match?(options[:content_type])

    record.errors[attribute] << '画像ファイル形式にしてください'
  end
end
