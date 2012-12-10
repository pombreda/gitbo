options= {
:font_size => 10,
:height => 13,
:background_color => '#3f007f',
:color => '#ffff56',
:destination => Proc.new{File.join Rails.root, "public/gifs"}
}

options.each { |k,v| MagickTitle.options[k] = v}