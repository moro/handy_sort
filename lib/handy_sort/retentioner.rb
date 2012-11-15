module HandySort
  class Retentioner
    def initialize(klass, sort_key, fk)
      @klass, @sort_key, @fk = klass, sort_key, fk
    end

    def retention
      parent = @klass.quoted_table_name
      @klass.update_all <<-SQL.strip_heredoc
        #{@sort_key} = (
          SELECT COUNT(*) + 1
          FROM   #{parent} sub
          WHERE  sub.#{@fk}  = #{parent}.#{@fk}
          AND    sub.#{@sort_key} < #{parent}.#{@sort_key}
        )
      SQL
    end
  end
end
