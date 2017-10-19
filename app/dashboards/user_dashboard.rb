require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard

  ATTRIBUTE_TYPES = {
    tags: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    username: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    confirmation_token: Field::String,
    confirmed_at: Field::DateTime,
    confirmation_sent_at: Field::DateTime,
    unconfirmed_email: Field::String,
    failed_attempts: Field::Number,
    unlock_token: Field::String,
    locked_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    provider: Field::String,
    uid: Field::String,
    full_street_address: Field::String,
    latitude: Field::Number.with_options(decimals: 2),
    longitude: Field::Number.with_options(decimals: 2),
    avatar: Field::Image,
    gender: Field::String,
    about: Field::String,
    job: Field::String,
    cached_tag_list: Field::String,
    local: Field::Boolean,
    languages: Field::String,
    birthday: Field::DateTime,
    country: Field::String,
    education: Field::String,
    age:Field::String,
    admin: Field::Boolean,
    phone: Field::String,
    blends: Field::Number,
    sent_blends:Field::HasMany.with_options(class_name: "Blend", foreign_key:"sender_id"),
    received_blends:Field::HasMany.with_options(class_name: "Blend", foreign_key:"sender_id")
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :username,
    :job,
    :local,
    :created_at,
    :age,
    :blends
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :email,
    :username,
    :phone,
    :sent_blends,
    :received_blends,
    :local,
    :full_street_address,
    :avatar,
    :gender,
    :about,
    :job,
    :cached_tag_list,
    :languages,
    :birthday,
    :country,
    :education,
    :sign_in_count,
    :last_sign_in_at,
    :unconfirmed_email,
    :created_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :email,
    :avatar,
    :gender,
    :about,
    :job,
    :local,
    :languages,
    :birthday,
    :country,
    :education,
    :admin,
    :phone,
    :username
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    "#{user.username}"
  end
end
