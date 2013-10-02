class Identifier
  extend  ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :chord_scale, :base_note

  def persisted?
    false
  end  

  def identify(chord_tones)
    chord_tones.delete_if { |n| n.blank? } # if n == base_note
    self.base_note   = chord_tones.shift # not permanetnly removed, only if .shift!
    base_note_index  = Identifier.chromatic_scale.index(self.base_note)
    self.chord_scale = Identifier.chromatic_scale.rotate(base_note_index)

    chord_tones_indexes = chord_tones.map { |n| self.chord_scale.index(n) } 
    chord_tones_indexes.sort!

    chord_definitions_index = Identifier.chord_definitions.index(chord_tones_indexes)
    chord = "#{self.base_note} #{Identifier.chord_qualities[chord_definitions_index]}"
    chord
  end

  class << self
    
    def chromatic_scale
      %w(C C#/Db D D#/Eb E F F#/Gb G G#/Ab A A#/Bb B)
    end

    def chord_definitions
      [
        [4, 7],
        [3, 7],
        [3, 6],
        [4, 8],
        [4, 7, 11],
        [3, 7, 10],
        [4, 7, 10],
        [3, 6, 10],
        [3, 6, 9]
      ]
    end

    def chord_qualities
      %w(Major Minor Diminished Augmented Major-7th Minor-7th Domniant-7th Half-Diminished Diminished-7th)
    end
  end
end
