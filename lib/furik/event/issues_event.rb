# frozen_string_literal: true

module Furik
  module Event
    class IssuesEvent < GithubEvent
      def payload_type
        :issue
      end

      def type
        event.payload.action.capitalize
      end
    end
  end
end
