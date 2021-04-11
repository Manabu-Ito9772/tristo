module Pagination
  class Api::ArticlesController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagenation: {
          current: resources.current_page,
          previous: resources.prev_page,
          next: resources.next_page,
          limit_value: resources.limit_value,
          pages: resources.total_pages,
          count: resources.total_count
        }
      }
    end
  end

  class Api::CommentsController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagenation: {
          current: resources.current_page,
          previous: resources.prev_page,
          next: resources.next_page,
          limit_value: resources.limit_value,
          pages: resources.total_pages,
          count: resources.total_count
        }
      }
    end
  end

  class Api::RelationshipsController < ApplicationController
    def resources_with_pagination(resources)
      {
        pagenation: {
          current: resources.current_page,
          previous: resources.prev_page,
          next: resources.next_page,
          limit_value: resources.limit_value,
          pages: resources.total_pages,
          count: resources.total_count
        }
      }
    end
  end
end
