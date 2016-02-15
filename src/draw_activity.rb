require 'ruboto/widget'

ruboto_import_widgets :Button, :EditText, :LinearLayout, :ScrollView, :TextView

import 'org.enebakkif.draw.Draw'

class DrawActivity
  def onCreate(bundle)
    super
    @file_name = "#{files_dir}/draw.dat"

    set_title 'Draw'

    self.content_view = linear_layout :orientation => :vertical do
      linear_layout do
        @player_count = edit_text :text => '', :width => :match_parent, :gravity => :center,
                                  :text_size => 18, :inputType => android.text.InputType::TYPE_CLASS_NUMBER,
                                  :layout => {:weight= => 1, :height= => :fill_parent, :width= => :fill_parent}
        @draw_button = button :text => 'Draw', :width => :match_parent, :on_click_listener => proc { draw },
                              :layout => {:weight= => 1, :height= => :fill_parent, :width= => :fill_parent}
      end
      scroll_view do
        @text_view = text_view :text => '', :width => :match_parent, :gravity => :center, :text_size => 18
      end
    end
  rescue Exception
    puts "Exception creating activity: #{$!}"
    puts $!.backtrace.join("\n")
  end

  def onResume
    super
    if File.exists? @file_name
      data = File.read @file_name
      @text_view.text = data
      @player_count.enabled = @draw_button.enabled = false
    end
  end

  def onPause
    super
  end

  def onCreateOptionsMenu(menu)
    menu.add('Redraw').setOnMenuItemClickListener do |mi|
      @player_count.enabled = @draw_button.enabled = true
      @text_view.text = ''
      true
    end
    true
  end

  private

  def draw
    res = Draw.draw(@player_count.text.to_s.to_i)

    data = res.join("\n")
    File.write @file_name, data

    @text_view.text = data
    @player_count.enabled = false
    @draw_button.enabled = false
  end
end
