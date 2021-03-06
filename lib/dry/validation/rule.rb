# frozen_string_literal: true

require 'dry/equalizer'
require 'dry/initializer'

module Dry
  module Validation
    # Rules are created by contracts
    #
    # @api private
    class Rule
      include Dry::Equalizer(:name, :block)

      extend Dry::Initializer

      # @!atrribute [r] keys
      #   @return [Array<Symbol, String, Hash>]
      #   @api private
      option :keys

      # @!atrribute [r] block
      #   @return [Proc]
      #   @api private
      option :block

      # Evaluate the rule within the provided context
      #
      # @param [Contract] contract
      # @param [Result] result
      # @param [Concurrent::Map] context
      #
      # @api private
      def call(contract, result, context)
        Evaluator.new(contract, values: result, keys: keys, _context: context, &block)
      end
    end
  end
end
