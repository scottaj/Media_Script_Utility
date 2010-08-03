# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'cue'

class CueScript
  
    def initialize
        @script = {}
    end

    def add_cue(time, length = 100, value = 0, comment = "")
        key = "#{time[0]}:#{time[1]}:#{time[2]}:#{time[3]}"

        @script[key] = Cue.new(length, value, comment)
    end

    def remove_cue(time)
        key = "#{time[0]}:#{time[1]}:#{time[2]}:#{time[3]}"

        @script.delete(key)
    end

    def cue_finder(time)
        key = "#{time[0]}:#{time[1]}:#{time[2]}:#{time[3]}"

        return @script[key]
    end
end
