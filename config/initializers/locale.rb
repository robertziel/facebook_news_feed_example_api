I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.yml')]

I18n.available_locales = %i[en pl ja]

I18n.default_locale = :en
