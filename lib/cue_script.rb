# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'cue'

class CueScript
  
    def initialize
        @script = {}

        @@counter = 0
    end

    def add_cue(time, length = 100, value = 0, comment = "")
        key = "#{time[0]}:#{time[1]}:#{time[2]}:#{time[3]}"

        @script[key] = Cue.new(length, value, comment, @@counter)
        @@counter += 1
    end

    def remove_cue(time)
        key = "#{time[0]}:#{time[1]}:#{time[2]}:#{time[3]}"

        @script.each_value {|cue| cue.num -= 1 if cue.num > @@counter}
        @script.delete(key)
        @@counter -= 1
    end

    def cue_finder(time)
        key = "#{time[0]}:#{time[1]}:#{time[2]}:#{time[3]}"

        return @script[key]
    end
end
