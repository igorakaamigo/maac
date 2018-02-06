# frozen_string_literal: true

require 'rubygems'

module Maac
  class Config
    OPTIONS = %i[
      strings
      template
      selector
      selector_y
      selector_n
      after_append
      before_remove
    ].freeze

    OPTIONS.each do |option|
      attr_accessor option
    end

    def initialize
      @strings = {
        title: 'Confirm',
        yes:   'Yes',
        no:    'No',
        close: 'Close'
      }

      @selector   = '.maac-popup'
      @selector_y = '#js-maac-yes'

      bsgems = Gem::Specification.reject { |s| s.name.match(/bootstrap/i).nil? }
      if bsgems.count > 0
        @template      = File.new(File.expand_path('../../../tpl/bs3.html', __FILE__)).read
        @selector_n    = '#js-maac-no,#js-maac-close'
        @after_append  = 'function () { $(".maac-popup").modal({"backdrop": "static"}); }'
        @before_remove = 'function (cb) { $(".maac-popup").modal("hide"); cb(); }'
      else
        @template      = File.new(File.expand_path('../../../tpl/vanilla.html', __FILE__)).read
        @selector_n    = '#js-maac-no,#js-maac-close'
        @after_append  = 'function () { /* After append */; }'
        @before_remove = 'function (cb) { /* Before remove */; cb(); }'
      end
    end
  end
end
