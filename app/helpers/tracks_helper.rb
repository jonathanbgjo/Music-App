module TracksHelper
    include ERB::Util
    def ugly_lyrics(lyrics)
        lines = lyrics.split('\n')
        complete_lyrics = ""
        lines.each do |line|
            complete_lyrics <<"&#9835; #{h(line)}<br>"
        end 
        "<pre>
#{complete_lyrics}
        </pre>".html_safe
    end
end
