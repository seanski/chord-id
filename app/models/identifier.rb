class Identifier
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :notes, :base_note

  def persisted?
    false
  end  

  def identify(notes)
    notes.delete_if { |n| n.blank? }
    self.base_note = notes.shift
    self.notes = self.class.notes.rotate(self.class.notes.index(self.base_note))

    selected_indexes = notes.map { |n| self.notes.index(n) }

    selected_indexes = selected_indexes.sort

    offset_index = self.class.offsets.index(selected_indexes)
    chord = "#{self.base_note} #{self.class.qualities[offset_index]}"
    chord
  end

  class << self
    
    def notes
      %w(C C#/Db D D#/Eb E F F#/Gb G G#/Ab A A#/Bb B)
    end

    def qualities
      %w(Major Minor Diminished Augmented Major-7th Minor-7th Domniant-7th Half-Diminished Diminished-7th)
    end

    def offsets
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

  end

end
