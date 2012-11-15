module HandySort
  extend ActiveSupport::Concern

  class CallbackManager
    delegate :key, to: :@ranker

    def initialize(ranker, options = {})
      @ranker  = ranker
      @options = options
    end

    def install(klass)
      [:before_create, :before_update, :before_destroy].each do |hook|
        klass.send hook, self
      end
    end

    def before_create(record)
      max = relation(record).count.succ

      if new_val = record[key]
        @ranker.move_affected(relation(record), max, new_val)
      else
        record[key] = max
      end
    end

    def before_update(record)
      return unless change = record.changes[key]

      @ranker.move_affected(relation(record), *change)
    end

    def before_destroy(record)
      max = relation(record).count.succ
      @ranker.move_affected(relation(record), record[key], max)
    end

    private

    def relation(record)
      case within = @options[:within]
      when Symbol  then record.class.where(within => record[within])
      end
    end
  end
end
