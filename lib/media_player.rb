# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.

require 'rubygems'
require 'wx'
require 'mp3info'

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
            @media_length = 0
            @file_data = ["", "", ""]

            @player.set_volume(1.0)
            @player.show_player_controls(MEDIACTRLPLAYERCONTROLS_NONE)

            evt_media_loaded(@player)       {@media_loaded = true}
            evt_media_play(@player)         {@media_state = 1}
            evt_media_pause(@player)        {@media_state = 0}
            evt_media_stop(@player)         {@media_state = -1}
        end

        attr_reader :media_state, :media_loaded, :media_length, :file_data

        # Loads media file named by <i>media</i>.
        # If the media file is a video then a screen is displayed to
        # play the movie.
        def load(media)
            if media.match(/.+\.mp3/i)
                Mp3Info.open(media) do |mp3|
                    @file_data[0] = mp3.tag.title
                    @file_data[1] = mp3.tag.artist
                    @file_data[2] = mp3.tag.album
                end
            else
                @file_data[0] = media
            end

            @media_loaded = false
            @player.load(media)
            self.show if media.match(/.+\.(avi|divx|flv|mov|mp4|mpeg|wmv)/i)
            @player.get_best_size

            @media_length = @player.length
        end

        # Plays the loaded media file. Does nothing if no file is loaded.
        def play()
            @player.play if @media_loaded == true
        end

        # Pauses the loaded media file. Does nothing if no file is loaded.
        def pause()
            @player.pause if @media_loaded == true
        end

        # Stops the loaded media file. Does nothing if no file is loaded.
        def stop()
            @player.stop if @media_loaded == true
        end

        # Seeks time seconds from the beginning of the media.
        def seek(time)
            @player.seek(time) if @media_loaded == true
        end

        # Tells the current playback time in milliseconds.
        def tell()
            @player.tell if @media_loaded == true
        end
    end
end
