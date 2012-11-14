module HandySort
  class Ranker
    attr_reader :key

    def initialize(key)
      @key = key.to_sym
    end

    def move_affected(relation, old_val, new_val)
      affected = relation.where(key => Range.new(*[old_val, new_val].sort))
      offset = old_val > new_val ? 1 : -1

      affected.update_all "%s = %s + (%d)" % [key.to_s, key.to_s, offset]
    end
  end
end
