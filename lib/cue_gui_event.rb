# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'cue_gui'
require 'media_player'

module GUI

    # = CueGUIEvent
    #
    # This class contains all event handling code for the main GUI window.
    # It also initializes and manages the media player.
    class CueGUIEvent < CueGUI

        # Creates the main GUI window initalizing all event handlers.
        # Also creates a MediaPlayer and a timer to moniter playback time.
        def initialize
            super

            @media_player = MediaPlayer.new

            media_t = Timer.new(self, 102)
            evt_timer(102) do
                if @media_player.media_loaded
                    if @media_player.media_state == 1
                        set_media_time(@media_player.tell)
                    end
                else
                    @total_time.set_label("0:00")
          
            end
            media_t.start(75)
            @def_c = @subsec_btn_0.get_background_colour()

            evt_close()                         {quit_program()}

            evt_button(@play_btn)               {play_script()}
            evt_button(@pause_btn)              {pause_script()}
        end

        def quit_program()
            @media_player.destroy
            self.destroy
        end

        # Changes all the widgets relating to displaying the current time.
        def set_media_time(raw_time)
            tenth = raw_time.to_s.split("")[-3].to_i
            sec = (raw_time / 1000) % 60
            min = (raw_time / 1000 / 60).to_i
            hour = (min / 60).to_i

            # Set toggle button color.
            buttons = [@subsec_btn_0, @subsec_btn_1, @subsec_btn_2,
                @subsec_btn_3, @subsec_btn_4, @subsec_btn_5, @subsec_btn_6,
                @subsec_btn_7, @subsec_btn_8, @subsec_btn_9
            ]
            begin
                buttons.each {|b| b.set_background_colour(@def_c)}
                button = buttons[tenth]
                button.set_background_colour(RED)
            rescue NoMethodError
            end

            # Set static text value
            @total_time.set_label("#{"#{hour}:" if hour >= 1}#{min}:#{0 if sec < 10}#{sec}")

            # Move Slider
            @song_time_slider.set_value(sec)
        end

        def play_script()
            @media_player.play unless @media_player.media_state == 1
        end

        def pause_script()
            @media_player.pause unless @media_player.media_state == 0
        end

    end
end
