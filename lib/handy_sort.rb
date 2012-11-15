require 'handy_sort/version'

require 'active_support/concern'
require 'handy_sort/callback_manager'
require 'handy_sort/ranker'

module HandySort
  extend ActiveSupport::Concern

  module ClassMethods
    def handy_sort(key, options = {})
      ranker = Ranker.new(key)

      CallbackManager.new(ranker, options).install(self)

      scope :handy_sorted, -> { order("#{key} ASC") }
    end
  end
end
