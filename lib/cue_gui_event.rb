# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'cue_gui'
require 'cue_script'
require 'media_player'
require 'thread'
require 'yaml'

module GUI

    # = CueGUIEvent
    #
    # This class contains all event handling code for the main GUI window.
    # It also initializes and manages the media player.
    class CueGUIEvent < CueGUI

        # Creates the main GUI window initializing all event handlers.
        # Also creates a MediaPlayer and a timer to monitor playback time.
        def initialize
            super

            @media_player = MediaPlayer.new
            @script = CueScript.new
            @sync = Mutex.new

            @cues_on = {}

            media_t = Timer.new(self, 102)
            evt_timer(102) do
                if @media_player.media_loaded
                    @song_time_slider.set_range(0, (@media_player.media_length / 1000) + 1) unless (@media_player.media_length / 1000) + 1 == @song_time_slider.get_max
                    
                    if @media_player.media_state == 1
                        Thread.new {cue_scan(@media_player.tell)}
                        set_media_time(@media_player.tell)
                    end
                else
                    @total_time.set_label("0:00:00")
                    self.send_size_event
                end
          
            end
            media_t.start(75)
            @def_c = @subsec_btn_0.get_background_colour()

            evt_close()                         {quit_program()}

            evt_menu(ID_NEW)                    {new_script()}

            evt_button(@play_btn)               {play_script()}
            evt_button(@pause_btn)              {pause_script()}
            evt_button(@stop_btn)               {stop_script()}

            #@media_player.load("/media/Main Drive/Users/Al/Music/Amazon MP3/Elton John/Goodbye Yellow Brick Road/04 - Goodbye Yellow Brick Road.mp3")
        end

        # Looks for a cue at the current time in the script, if one is present
        # that cue is added to the list of currently turned on cues for its
        # assigned duration and then deleted.
        def cue_scan(raw_time)
            time = [(min / 60).to_i,
                (raw_time / 1000 / 60).to_i,
                (raw_time / 1000) % 60,
                raw_time.to_s.split("")[-3].to_i]
            cue = @script.cue_finder(time)

            if cue
                cue.exec do |val, comment, num|
                    if val
                        @sync.syncronize do
                            @cues_on[num] = [val, comment]
                        end
                    else
                         @sync.syncronize do
                            @cues_on.delete(num)
                        end
                    end
                    sleep(0.1)
                end
            end
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
                buttons.each {|b| b.set_background_colour(@def_c)} if tenth == 0
                button = buttons[tenth]
                button.set_background_colour(RED)
            rescue NoMethodError
            end

            # Set static text value
            @total_time.set_label("#{"#{hour}:" if hour >= 1}#{min}:#{0 if sec < 10}#{sec}")

            # Move Slider
            @song_time_slider.set_value(raw_time / 1000)
        end

        # Quits the program
        def quit_program()
            @media_player.destroy
            self.destroy
        end

        def new_script()
            @script = CueScript.new
        end

        def play_script()
            @media_player.play unless @media_player.media_state == 1
        end

        def pause_script()
            @media_player.pause unless @media_player.media_state == 0
        end

        def stop_script()
            @media_player.stop unless @media_player.media_state == -1
        end
    end
end