# frozen_string_literal: true

module Furik
  module Event
    class GithubEvent
      attr_accessor :event, :payload

      def initialize(event)
        @event = event
        @payload = event.payload.send(payload_type)
      end

      def type
        payload_type.to_s.capitalize
      end

      def owner
        payload
      end

      def owner_as_string
        "**[##{owner.number}](#{owner.html_url}): #{owner.title.strip}**"
      end
    end
  end
end
