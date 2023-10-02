module PaginationConcern
  extend ActiveSupport::Concern

  included do
    paginates_per 2
  end
end
