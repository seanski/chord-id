class Identifier
  extend  ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :chord_scale, :base_note

  def persisted?
    false
  end  

  def identify(chord_tones, base_note)
    chord_tones.delete_if { |n| n.blank? || n == base_note }
    self.base_note   = base_note
    base_note_index  = Identifier.chromatic_scale.index(self.base_note)
    self.chord_scale = Identifier.chromatic_scale.rotate(base_note_index)

    chord_tones_indexes = chord_tones.map { |n| self.chord_scale.index(n) } 
    chord_tones_indexes.sort!

    if Identifier.chord_definitions[chord_tones_indexes]
      chord_name = "#{self.base_note} #{Identifier.chord_definitions[chord_tones_indexes]}"
      chord_name
    else
      false
    end  
  end

  class << self
    
    def chromatic_scale
      %w(C C#/Db D D#/Eb E F F#/Gb G G#/Ab A A#/Bb B)
    end

    def chord_definitions
      { [7]        => "5 chord or \"Power Chord\"",
        [4]        => "Implied Major",
        [3]        => "Implied Minor",
        [10]       => "Implied 7th",
        [4,7]      => "Major",
        [3,7]      => "Minor",
        [4,8]      => "Augmented",
        [3,6]      => "Diminished",
        [2,7]      => "Sus 2",
        [5,7]      => "Sus 4",
        [4,7,11]   => "Major 7th",
        [4,7,10]   => "Dominant 7th",
        [3,7,10]   => "Minor 7th",
        [3,6,10]   => "Half Diminished",
        [3,7,9]    => "Diminished 7th",
        [4,7,9]    => "Major 6th",
        [3,7,9]    => "Minor 6th",
        [2,4,7]    => "Major Add 9",
        [2,3,7]    => "Minor Add 9",
        [5,7,10]   => "7 sus",
        [2,4,7,11] => "Major 9th",
        [2,4,7,10] => "Dominant 9th",
        [2,3,7,10] => "Minor 9th",
        [4,7,9,11] => "Major 13th",
        [4,7,9,10] => "Dominant 13th",
        [2,4,7,9]  => "6/9",
        [3,5,7,10] => "Minor 11th",
        [4,6,7,11] => "Major 7th #11",
        [4,6,7,10] => "Dominant #11",
        [1,4,7,10] => "Dominant 7th b9",
        [3,4,7,10] => "Dominant 7th  #9",
        [2,4,6,10] => "Dominant 9th b5",
        [2,4,8,10] => "Dominant 9th #5",
        [4,7,8,10] => "Dominant 7th b13",
        [1,3,6,10] => "Half Diminished b9",
        [2,3,6,10] => "Half Diminished 9th",
      }
    end
  end
end
