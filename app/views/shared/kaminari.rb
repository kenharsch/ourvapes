module Kaminari
  module Helpers
    class Paginator
      #show pagination controls regardless of number of pages
      def render(&block)
        instance_eval(&block) if @options[:total_pages] >= 1
        @output_buffer
      end
    end
  end
end