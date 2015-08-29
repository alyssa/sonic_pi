# beats per minute
use_bpm 140

# Choose a root note (one) and everything else will fall into place.
one = :D2

# Groove: quarter note triplets (trip-uh-let, trip-uh-let, ...)
trip_uh = 0.6666
let = 0.3333

in_thread(name: :bass) do
  2.times { bass_line one }
  1.times { bass_line one + 1 }
  1.times { bass_line one }
end

define :bass_line do |root|
  4.times do |i|
    if i != 3
      sleep trip_uh
      play_note root, let
      [[root + 6, root + 8], [root + 10,root+12], [root+14, root+10]].each do |note_1, note_2|
        cue :tick
        play_note note_1, trip_uh
        play_note note_2, let
      end

      if i == 0 || i == 2
        play_note root+12, 4
      elsif i == 1
        play_note root + 12, trip_uh
        play_note root + 7, let + 3
      end
    else 
      sleep trip_uh
      play_note root + 14, let + 1
      play_note root + 14, 1
      play_note root + 14, 1
      play_note root + 12, 1 + trip_uh
      play_note root + 7, 1
      sleep 1
    end
  end
end

define :play_note do |note, length|
  play note, release: length
  sleep length
end
