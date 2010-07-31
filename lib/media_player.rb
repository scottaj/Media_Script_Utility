# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require "rubygems"
require "wx"

include Wx

module GUI

    # = MediaPlayer
    #
    # This class creates a media player to playback loaded audio and video
    # files. Under normal circumstances the player remains hidden and just
    # audio. If a movie file is loaded a screen is displayed and the movie
    # plays on that screen.
    class MediaPlayer < MiniFrame

        # Initializes the media player.
        def initialize
            super(nil, :title => "Movie Screen")

            @player = MediaCtrl.new(self)
            @media_state = -1
            @media_loaded = false

            @player.set_volume(1.0)
            @player.show_player_controls(MEDIACTRLPLAYERCONTROLS_NONE)

            evt_media_loaded(@player)       {@media_loaded = true}
            evt_media_play(@player)         {@media_state = 1}
            evt_media_pause(@player)        {@media_state = 0}
            evt_media_stop(@player)         {@media_state = -1}
        end

        attr_reader :media_state, :media_loaded

        # Loads media file named by <i>media</i>.
        # If the media file is a video then a screen is displayed to
        # play the movie.
        def load(media)
            @media_loaded = false
            @player.load(media)
            self.show if media.match(/.+\.(avi|divx|flv|mov|mp4|mpeg|wmv)/i)
            @player.get_best_size
        end

        # Plays the loaded media file 
        def play()
            @player.play if @media_loaded == true
        end

        def pause()
            @player.pause if @media_loaded == true
        end

        def stop()
            @player.stop if @media_loaded == true
        end

        def seek(time)
            @player.seek(time) if @media_loaded == true
        end

        def tell()
            @player.tell if @media_loaded == true
        end
    end
end
