# Copyright(c) 2010 Al Scott
# License details can be found in the LICENSE file.
#
# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: MediaCue.xrc 
# Generated at: Wed Jul 28 13:43:03 -0600 2010

class CueGUI < Wx::Frame
	
	attr_reader :main_window_menubar, :menu_file, :menu_tools,
              :tools_conf, :menu_help, :help_bug, :song_name_text,
              :song_artist_text, :song_album_text, :song_time_slider,
              :total_time, :last_cue_btn, :rwd_btn, :play_btn,
              :pause_btn, :ffw_btn, :next_cue_btn, :subsec_btn_0,
              :subsec_btn_1, :subsec_btn_2, :subsec_btn_3,
              :subsec_btn_4, :subsec_btn_5, :subsec_btn_6,
              :subsec_btn_7, :subsec_btn_8, :subsec_btn_9,
              :write_out_chk, :beep_chk, :pause_chk, :cue_list,
              :edit_btn
	
	def initialize(parent = nil)
		super()
		xml = Wx::XmlResource.get
		xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
		xml.init_all_handlers
		xml.load("MediaCue.xrc")
		xml.load_frame_subclass(self, parent, "main_window")

		finder = lambda do | x | 
			int_id = Wx::xrcid(x)
			begin
				Wx::Window.find_window_by_id(int_id, self) || int_id
			# Temporary hack to work around regression in 1.9.2; remove
			# begin/rescue clause in later versions
			rescue RuntimeError
				int_id
			end
		end
		
		@main_window_menubar = finder.call("main_window_menubar")
		@menu_file = finder.call("menu_file")
		@menu_tools = finder.call("menu_tools")
		@tools_conf = finder.call("tools_conf")
		@menu_help = finder.call("menu_help")
		@help_bug = finder.call("help_bug")
		@song_name_text = finder.call("song_name_text")
		@song_artist_text = finder.call("song_artist_text")
		@song_album_text = finder.call("song_album_text")
		@song_time_slider = finder.call("song_time_slider")
		@total_time = finder.call("total_time")
		@last_cue_btn = finder.call("last_cue_btn")
		@rwd_btn = finder.call("rwd_btn")
		@play_btn = finder.call("play_btn")
		@pause_btn = finder.call("pause_btn")
		@ffw_btn = finder.call("ffw_btn")
		@next_cue_btn = finder.call("next_cue_btn")
		@subsec_btn_0 = finder.call("subsec_btn_0")
		@subsec_btn_1 = finder.call("subsec_btn_1")
		@subsec_btn_2 = finder.call("subsec_btn_2")
		@subsec_btn_3 = finder.call("subsec_btn_3")
		@subsec_btn_4 = finder.call("subsec_btn_4")
		@subsec_btn_5 = finder.call("subsec_btn_5")
		@subsec_btn_6 = finder.call("subsec_btn_6")
		@subsec_btn_7 = finder.call("subsec_btn_7")
		@subsec_btn_8 = finder.call("subsec_btn_8")
		@subsec_btn_9 = finder.call("subsec_btn_9")
		@write_out_chk = finder.call("write_out_chk")
		@beep_chk = finder.call("beep_chk")
		@pause_chk = finder.call("pause_chk")
		@cue_list = finder.call("cue_list")
		@edit_btn = finder.call("edit_btn")
		if self.class.method_defined? "on_init"
			self.on_init()
		end
	end
end


