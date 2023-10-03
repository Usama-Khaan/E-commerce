module PaginationConcern
  extend ActiveSupport::Concern

  included do
    paginates_per 10
  end
end
