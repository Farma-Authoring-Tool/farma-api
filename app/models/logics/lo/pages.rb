module Logics::Lo
  class Pages
    def initialize(lo)
      @lo = lo
    end

    def all
      pages = @lo.introductions + @lo.exercises
      pages.sort_by(&:position)
    end

    def sort_by!(order)
      order.each_with_index do |page, index|
        model = page[:class].constantize
        model.find(page[:id]).update(position: index)
      end
    end

    def get(index)
      all.at(index.to_i)
    end

    def page(page)
      get(page.to_i - 1)
    end

    def method_missing(method, *, &)
      if all.respond_to?(method)
        all.send(method, *, &)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      super
    end
  end
end
