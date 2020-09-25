# frozen_string_literal: true

module Furik
  module Event
    class Issue < GithubEvent
      PAYLOAD_TYPE = :issue

      def type
        "#{event.payload.action}_#{PAYLOAD_TYPE}"
      end
    end
  end
end
