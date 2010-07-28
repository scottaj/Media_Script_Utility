# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'rubygems'
require 'wx'
require 'wx_sugar'
require 'cue_gui_event'

include Wx
include GUI

class MediaCueApp < App
    def on_init
        t = Timer.new(self, 55)
        evt_timer(55) {Thread.pass}
        t.start(10)
        CueGUIEvent.new.show
    end
end

def main()
    MediaCueApp.new.main_loop
end

main() if __FILE__ == $0
