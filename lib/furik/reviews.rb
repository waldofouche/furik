require 'octokit'

module Furik
  class Reviews
    def initialize(client)
      @client = client
      @login = client.login
    end

    def request_manager
      limit = @client.rate_limit
      if !limit.limit.zero? && limit.remaining.zero?
        puts "Oops! #{limit}"
        sleep limit.resets_in
      end
      # No rate limit for white listed users
    rescue Octokit::NotFound
    end

    def reviews_by_repo(repo_name, from, to, &block)
      reviews = @client.pulls(repo_name).flat_map do |pr|
        @client.pull_request_reviews(repo_name, pr.number)
        request_manager
      end

      reviews.select do |review|
        submitted_at = review.submitted_at.localtime.to_date
        review.user.login == @login && from <= submitted_at && submitted_at <= to
      end

      block.call(reviews) if block

      reviews
    end
  end
end