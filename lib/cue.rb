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
    def initialize(length, value, comment)
        @length = length
        @value = value
        @comment = comment
    end

    # Execute the cue.
    def exec()
        yield @value, @comment
        sleep((length / 1000).to_f)
        yield nil, nil
    end
end
