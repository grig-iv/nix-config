#!/usr/bin/env fish

set marks streets places metro

cd $HOME/Downloads/
set geojsons $(command ls -w 1 -t *.geojson)

for json in $geojsons
    set jsonMarks $(jq -r '.features[].properties.mark|values' $json)
    for mark in $marks
        if contains $mark $jsonMarks
            if set -q $mark
                continue
            end

            set $mark $json
        end
    end
end

for mark in $marks
    if set -q $mark
        echo movng $$mark to $mark.geojson
        mv -f $$mark "$HOME/Extended Mind/resources/maps/$mark.geojson"
    end
end
