# frozen_string_literal: true

module Furik
  module Event
    class PullRequestEvent < GithubEvent
      def payload_type
        :pull_request
      end

      def type
        event.payload.action.capitalize
      end
    end
  end
end
