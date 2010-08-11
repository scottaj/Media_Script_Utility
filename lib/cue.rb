# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'rubygems'

# = Cue
#
# Class descriping an audio cue.
class Cue

    # Creates a new audio cue.
    #
    # <i>length</i>: The length in milliseconds of the cue.
    # <i>value</i>: The value of the cue, an integer from 0-255.
    # <i>comment</i>: A comment for the cue.
    def initialize(length, value, comment, num)
        @length = length
        @value = value
        @comment = comment
        @num = num
    end

    attr_accessor :num

    # Execute the cue.
    def exec()
        yield @value, @comment, @num
        sleep((length / 1000).to_f)
        yield nil, nil, @num
    end
end
