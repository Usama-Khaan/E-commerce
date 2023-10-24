module PaginationConcern
  extend ActiveSupport::Concern

  included do
    paginates_per 6
  end
end
