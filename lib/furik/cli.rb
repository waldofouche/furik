# frozen_string_literal: true

require_relative '../furik.rb'
require 'thor'

module Furik
  class Cli < Thor
    desc 'activity', 'show activity'
    method_option :since, type: :numeric, aliases: '-d', default: 0
    method_option :from, type: :string, aliases: '-f', default: Date.today.to_s
    method_option :to, type: :string, aliases: '-t', default: Date.today.to_s
    def activity
      from = Date.parse(options[:from])
      to   = Date.parse(options[:to])
      since = options[:since]

      diff = (to - from).to_i
      from -= since if diff.zero?
      puts '## GitHub Activities'
      puts ''

      Furik.events_with_grouping(from: from, to: to) do |repo, events|
        puts "### #{repo}"
        puts ''

        events.sort_by(&:type).reverse.each_with_object({ keys: [] }) do |event, memo|
          next if memo[:keys].include?(event.key)

          memo[:keys] << event.key
          puts event.summarize
        end
        puts ''
      end
    end
  end
end
