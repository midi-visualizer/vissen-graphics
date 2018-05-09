# frozen_string_literal: true

module Vissen
  module Graphics
    # Engine
    #
    #
    class Engine
      MATCHER = ->(mod) { ->(e) { e.value == mod } }
      private_constant :MATCHER
      
      def initialize(mixers)
        # Create a mixer for each vixel layer
        @mixers = mixers
        @mutex  = Mutex.new
        @modulators = modulators mixers
        
        freeze
      end

      def render(t)
        @mutex.synchronize do
          @modulators.each { |modulator| modulator.update! t }
          @mixers.each(&:render!)
        end
      end
      
      private
      
      def expand_params(before_item)
        before_item.value.params.each do |_, param|
          next if param.constant?
          
          mod = param.modulator
          mod_matcher = MATCHER.call mod
          
          if before_item.after.find(&mod_matcher)
            raise RuntimeError, 'Cyclic parameter dependency'
          elsif before_item.before.find(&mod_matcher)
            next
          end
          
          item = Linked::Item.new mod
          before_item.prepend item
          
          expand_params item
        end
      end
      
      def modulators(mixers)
        tail = Linked::Item.new
        mixers.each do |mixer|
          mixer_item = Linked::Item.new mixer
          effect_item = Linked::Item.new mixer.effect
          
          tail.prepend effect_item
          expand_params effect_item
          
          tail.prepend mixer_item
          expand_params mixer_item
          
          effect_item.delete
          mixer_item.delete
        end
        
        head = tail.first_in_chain
        
        return [] if head == tail
        
        tail.delete
        list = Linked::List.new.push(head)
                
        list.map(&:value)
      end
    end
  end
end
