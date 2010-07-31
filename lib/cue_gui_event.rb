# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'cue_gui'
require 'media_player'

module GUI

    class CueGUIEvent < CueGUI

        def initialize
            super

            @media_player = MediaPlayer.new

            media_t = Timer.new(self, 102)
            evt_timer(102) do
                if @media_player.media_loaded
                    if @media_player.media_state == 1
                        set_media_time(@media_player.tell)
                    end
                end
            end
            media_t.start(50)


        end

        def set_media_time(raw_time)
            
        end
    end
end
