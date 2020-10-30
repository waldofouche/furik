# frozen_string_literal: true

module Furik
  module Event
    class IssueCommentEvent < GithubEvent
      def payload_type
        :comment
      end

      def owner
        event.payload.issue
      end

      def title
        payload.body.plain.cut
      end
    end
  end
end
