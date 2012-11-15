require 'handy_sort/version'

require 'active_support/concern'
require 'handy_sort/callback_manager'
require 'handy_sort/ranker'
require 'handy_sort/retentioner'

module HandySort
  extend ActiveSupport::Concern

  module ClassMethods
    def handy_sort(key, options = {})
      ranker = Ranker.new(key)

      CallbackManager.new(ranker, options).install(self)

      scope :handy_sorted, -> { order("#{key} ASC") }

      @retentioner = Retentioner.new(self, key, options[:within])
    end

    def retention
      @retentioner.retention
    end
  end
end
