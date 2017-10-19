require "administrate/base_dashboard"

class BlendDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    sender: Field::BelongsTo.with_options(class_name: "User"),
    recipient: Field::BelongsTo.with_options(class_name: "User"),
    id: Field::Number,
    sender_id: Field::Number,
    recipient_id: Field::Number,
    message: Field::Text,
    status: Field::Select.with_options(collection: Blend::STATES),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :sender,
    :recipient,
    :status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :sender,
    :recipient,
    :message,
    :status,
    :created_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :sender,
    :recipient,
    :message,
    :status,
  ].freeze

  # Overwrite this method to customize how blends are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(blend)
  #   "Blend ##{blend.id}"
  # end
end
