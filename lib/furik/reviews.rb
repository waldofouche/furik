# frozen_string_literal: true

require 'octokit'

module Furik
  class Reviews
    def initialize(client)
      @client = client
      @login = client.login
    end

    def request_manager
      limit = @client.rate_limit
      return unless limit.limit.positive? && limit.remaining.zero?

      puts "Oops! #{limit}"
      sleep limit.resets_in
    end

    def reviews_by_repo(repo_name, from, to, &block)
      pulls_with_reviews = pull_requests(repo_name, from).each.with_object({}) do |pr, reviews|
        gh_reviews = @client.pull_request_reviews(repo_name, pr.number)
        reviews[pr.title] = filtered_reviews(gh_reviews, from, to)
        request_manager
      end

      block&.call(pulls_with_reviews)

      pulls_with_reviews
    end

    private

    def pull_requests(repo_name, from)
      opts = { filter: 'all', state: 'all', sort: 'updated', since: from }
      @client.issues(repo_name, **opts).select(&:pull_request)
    end

    def filtered_reviews(reviews, from, to)
      return unless reviews.is_a? Array

      reviews.select do |review|
        submitted_at = review.submitted_at.localtime.to_date
        review.user.login == @login && from <= submitted_at && submitted_at <= to
      end
    end
  end
end
